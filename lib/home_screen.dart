import 'package:flutter/material.dart';
import 'package:music_search/app_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final results = AppRepository.itunesResponse;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Padding(
            padding:
                //todo check top padding with iOS
                EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top,
                    left: 16.0,
                    right: 16.0),
            child: SearchAnchor(builder: (context, searchController) {
              return SearchBar(
                controller: searchController,
                leading: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => searchController.openView(),
                ),
                onTap: () => searchController.openView(),
              );
            }, suggestionsBuilder: (context, searchController) {
              return [];
            }),
          ),
        ),
        body: const SizedBox());
  }
}
