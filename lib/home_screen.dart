import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_search/generated/l10n.dart';
import 'package:music_search/internal_state/persistent_bloc.dart';
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
          viewBuilder: (suggestions) {
            List<Widget> widgets = _searchController.text.isNotEmpty &&
                    suggestions.isEmpty
                ? [
                    ListTile(
                        title: Center(child: Text(S.of(context).no_results)))
                  ]
                : suggestions.toList();

            return BlocListener<PersistentBloc, PersistentState>(
              listener: (context, state) {
                // Triggers suggestionsBuilder on filters change (causes 2 queries)
                final query = _searchController.text;
                _searchController.text = '';
                _searchController.text = query;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getSortRadioButtons(),
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(children: widgets),
                    ),
                  ),
                ],
              ),
            );
          },
          suggestionsBuilder: (context, searchController) {
            return [];
          });
    });
  }

  Widget _getSortRadioButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<PersistentBloc, PersistentState>(
          builder: (context, state) {
        return Wrap(
          spacing: 8.0,
          children: [
            Text('${S.of(context).sort_by}:',
                style: Theme.of(context).textTheme.titleMedium),
            RadioListTile(
                title: Text(S.of(context).song_name),
                value: SortingType.song,
                groupValue: state.sortingType,
                onChanged: (sortingType) {
                  if (sortingType != null) {
                    context.read<PersistentBloc>().add(
                        UpdatePersistentStateEvent(
                            type: PersistentType.sortingType,
                            value: sortingType));
                  }
                }),
            RadioListTile(
                title: Text(S.of(context).album),
                value: SortingType.album,
                groupValue: state.sortingType,
                onChanged: (sortingType) {
                  if (sortingType != null) {
                    context.read<PersistentBloc>().add(
                        UpdatePersistentStateEvent(
                            type: PersistentType.sortingType,
                            value: sortingType));
                  }
                }),
          ],
        );
      }),
    );
  }
}
