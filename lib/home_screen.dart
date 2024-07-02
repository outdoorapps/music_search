import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_minimalist_audio_player/flutter_minimalist_audio_player.dart';
import 'package:local_hero/local_hero.dart';
import 'package:music_search/audio_player.dart';
import 'package:music_search/generated/l10n.dart';
import 'package:music_search/home_screen_bloc.dart';
import 'package:music_search/internal_state/app_repository.dart';
import 'package:music_search/internal_state/persistent_bloc.dart';
import 'package:music_search/json_model/itunes_response.dart';
import 'package:music_search/utils/disabled_focus_node.dart';
import 'package:music_search/utils/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final SearchController _searchController = SearchController();
  List<Track> _randomTracks = [];
  var _carouselIndex = 0;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = DisabledFocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenBlocState>(
        builder: (context, state) {
      final tracks = AppRepository.itunesResponse?.tracks;
      final track = context.read<HomeScreenBloc>().state.selectedTrack;
      return PopScope(
        canPop: track == null,
        onPopInvoked: (bool? didPop) {
          if (track != null) {
            context.read<HomeScreenBloc>().add(ChangeSelectedTrackEvent(null));
          }
        },
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _getSearchBar(),
                ),
              ),
            ),
            body: LocalHeroScope(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Builder(
                builder: (context) {
                  if (tracks == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 64.0,
                              height: 64.0,
                              child: Visibility(
                                visible: state.appRepositoryRefreshStatus !=
                                    BlocStatus.done,
                                child: const CircularProgressIndicator(),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              S.of(context).fail_to_cache,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              context
                                  .read<HomeScreenBloc>()
                                  .add(RefreshAppRepositoryEvent());
                            },
                            label: Text(S.of(context).refresh),
                            icon: const Icon(Icons.refresh),
                          )
                        ],
                      ),
                    );
                  } else {
                    if (_randomTracks.isEmpty) {
                      _randomTracks = [...tracks]..shuffle();
                    }
                    if (state.selectedTrack == null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 36.0),
                        child: CarouselSlider(
                          items: List<Widget>.generate(10, (index) {
                            final randomTrack = _randomTracks[index];
                            return CarouselTrackItem(
                              randomTrack: randomTrack,
                              heroTag: randomTrack.trackId,
                            );
                          }),
                          options: CarouselOptions(
                              initialPage: _carouselIndex,
                              height: 400.0,
                              aspectRatio: 4 / 3,
                              onPageChanged: (index, _) {
                                _carouselIndex = index;
                              }),
                        ),
                      );
                    } else {
                      return AudioPlayer(track: state.selectedTrack!);
                    }
                  }
                },
              ),
            )),
      );
    });
  }

  Widget _getSearchBar() {
    return Builder(builder: (context) {
      return SearchAnchor(
          viewHintText: S.of(context).search,
          searchController: _searchController,
          builder: (context, searchController) {
            return SearchBar(
              hintText: S.of(context).search,
              textInputAction: TextInputAction.search,
              controller: searchController,
              focusNode: _focusNode,
              leading:
                  BlocSelector<HomeScreenBloc, HomeScreenBlocState, Track?>(
                      selector: (state) {
                return state.selectedTrack;
              }, builder: (context, track) {
                return IconButton(
                  icon: Icon(track == null ? Icons.search : Icons.arrow_back),
                  onPressed: () {
                    if (track == null) {
                      searchController.openView();
                      FocusScope.of(context).unfocus();
                    } else {
                      context
                          .read<HomeScreenBloc>()
                          .add(ChangeSelectedTrackEvent(null));
                    }
                  },
                );
              }),
              onTap: () {
                searchController.openView();
                FocusScope.of(context).unfocus();
              },
            );
          },
          viewBuilder: (_) {
            return BlocSelector<PersistentBloc, PersistentState, SortingType>(
              selector: (state) => state.sortingType,
              builder: (context, state) {
                final query = _searchController.text;
                var widgets = _getResultItems(query);
                if (query.isNotEmpty && widgets.isEmpty) {
                  widgets = [
                    ListTile(
                        title: Center(child: Text(S.of(context).no_results)))
                  ];
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getSortingRadioButtons(),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(children: widgets),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          suggestionsBuilder: (context, searchController) => []);
    });
  }

  Widget _getSortingRadioButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocSelector<PersistentBloc, PersistentState, SortingType>(
          selector: (state) => state.sortingType,
          builder: (context, sortingType) {
            return Row(
              children: [
                Text('${S.of(context).sort_by}:',
                    style: Theme.of(context).textTheme.titleMedium),
                Row(
                  children:
                      List<Widget>.generate(SortingType.values.length, (index) {
                    final value = SortingType.values[index];
                    action() => context.read<PersistentBloc>().add(
                        UpdatePersistentStateEvent(
                            type: PersistentType.sortingType, value: value));
                    return InkWell(
                      onTap: () {
                        if (sortingType != value) {
                          action();
                        }
                      },
                      child: Row(
                        children: [
                          Radio(
                              value: value,
                              groupValue: sortingType,
                              onChanged: (sortingType) => action()),
                          Text(value.toName(context)),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            );
          }),
    );
  }

  List<Widget> _getResultItems(String query) {
    final results = AppRepository.itunesResponse?.tracks
        .where((e) =>
            e.trackName.toLowerCase().contains(query) ||
            e.collectionName.toLowerCase().contains(query))
        .toList();
    final sortingType = context.read<PersistentBloc>().state.sortingType;
    if (results != null && results.isNotEmpty) {
      switch (sortingType) {
        case SortingType.song:
          results.sort((a, b) => a.trackName.compareTo(b.trackName));
          break;
        case SortingType.album:
          results.sort((a, b) => a.collectionName.compareTo(b.collectionName));
          break;
      }
      return List<Widget>.generate(results.length, (index) {
        final track = results[index];
        return ListTile(
          leading: SizedBox(
              height: 60.0,
              width: 60.0,
              child: Image.network(track.artworkUrl60)),
          title: Text(
            track.trackName,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(track.collectionName),
          trailing: MinimalistAudioPlayer(media: track.previewUrl),
          onTap: () {
            context.read<HomeScreenBloc>().add(ChangeSelectedTrackEvent(track));
            _searchController.closeView(query);
          },
        );
      });
    } else {
      return [];
    }
  }
}

class CarouselTrackItem extends StatelessWidget {
  const CarouselTrackItem({
    super.key,
    required this.randomTrack,
    required this.heroTag,
  });

  final Track randomTrack;
  final int heroTag;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            context
                .read<HomeScreenBloc>()
                .add(ChangeSelectedTrackEvent(randomTrack));
          },
          child: Wrap(
            direction: Axis.vertical,
            spacing: 8.0,
            children: [
              LocalHero(
                tag: heroTag,
                child: Image.network(
                    randomTrack.artworkUrl100.replaceAll('100x100', '300x300')),
              ),
              SizedBox(
                width: 300.0,
                child: Text(
                  randomTrack.trackName,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 300.0,
                child: Text(
                  randomTrack.collectionName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
