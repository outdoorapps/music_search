import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_search/generated/l10n.dart';
import 'package:music_search/internal_state/app_repository.dart';
import 'package:music_search/internal_state/persistent_bloc.dart';
import 'package:music_search/utils/debug.dart';
import 'package:music_search/utils/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final SearchController _searchController = SearchController();
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode(canRequestFocus: false);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Padding(
            padding:
                //todo check top padding with iOS
                EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top,
                    left: 16.0,
                    right: 16.0),
            child: _getSearchBar(),
          ),
        ),
        body: const SizedBox());
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
              leading: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => searchController.openView(),
              ),
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
    final results = query.isEmpty
        ? AppRepository.itunesResponse?.results
        : AppRepository.itunesResponse?.results
            .where((e) =>
                e.trackName.toLowerCase().contains(query) ||
                e.collectionName.toLowerCase().contains(query))
            .toList();
    final sortingType = context.read<PersistentBloc>().state.sortingType;
    if (results != null && results.isNotEmpty) {
      switch (sortingType) {
        case SortingType.song:
          results.sort((a, b) => a.trackName.compareTo(b.trackName));
          p('sort by song'); //todo
          break;
        case SortingType.album:
          p('sort by album');
          results.sort((a, b) => a.collectionName.compareTo(b.collectionName));
          break;
      }
      return List<Widget>.generate(results.length, (index) {
        return ListTile(
          title: Text(results[index].trackName),
          subtitle: Text(results[index].collectionName),
          onTap: () {},
        );
      });
    } else {
      return [];
    }
  }
}
