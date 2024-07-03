// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_search/internal_state/app_repository.dart';
import 'package:music_search/internal_state/persistent_bloc.dart';
import 'package:music_search/main.dart';

import 'search_test.dart';

void main() async {
  await AppRepository.ensureInitialized();
  final response = AppRepository.itunesResponse;

  if (response != null) {
    searchTests(response.tracks);
    setUpAll(() {
      // ↓ required to avoid HTTP error 400 mocked returns
      HttpOverrides.global = null;
    });

    testWidgets('Widget screen test', (WidgetTester tester) async {
      // HydratedBloc.storage = await HydratedStorage.build(
      //   storageDirectory:
      //       kIsWeb ? HydratedStorage.webStorageDirectory : Directory(''),
      // );

      await tester.pumpWidget(
          BlocProvider(create: (_) => PersistentBloc(), child: const MyApp()));
      final t = find.text('Caching iTunes data...');
      expect(t, findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // final icon = find.byType(Icon);
      // expect(icon, findsOneWidget);
      // await tester.tap(find.ancestor(
      //     of: find.byIcon(Icons.search),
      //     matching: find.byWidgetPredicate((e) => e is IconButton)));
      // await tester.pump();
      //
      // await tester.enterText(find.byType(TextField), 'all');
      // await tester.pump();
      //
      // var item =
      //     tester.widgetList<ListTile>(find.byType(ListView)).elementAt(0);
      // expect((item.title as Text).data,
      //     'All Too Well (10 Minute Version) [Taylor\'s Version] [From The Vault]');
    });
  } else {
    print('Test cannot initiate: failed to cache itunes data');
  }
}
