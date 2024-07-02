import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:music_search/generated/l10n.dart';
import 'package:music_search/home_screen.dart';
import 'package:music_search/home_screen_bloc.dart';
import 'package:music_search/internal_state/app_repository.dart';
import 'package:music_search/internal_state/persistent_bloc.dart';
import 'package:music_search/utils/debug.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  initializeDebugFunctions(kDebugMode);

  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(RepositoryProvider(
      create: (_) => AppRepository(),
      child:
          BlocProvider(create: (_) => PersistentBloc(), child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Future<void> _appRepositoryInitiationFuture;

  @override
  void initState() {
    _appRepositoryInitiationFuture = AppRepository.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      localizationsDelegates: const [S.delegate],
      supportedLocales: const [Locale.fromSubtags(languageCode: 'en')],
      home: FutureBuilder(
        future: _appRepositoryInitiationFuture,
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: state.connectionState == ConnectionState.done
                ? BlocProvider(
                    create: (_) => HomeScreenBloc(), child: const HomeScreen())
                : _getSplashScreen(context),
          );
        },
      ),
    );
  }

  Widget _getSplashScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
            width: 144.0,
            height: 144.0,
            image: AssetImage('assets/launcher.png')),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(S.of(context).caching_itunes_data,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: LinearProgressIndicator(),
        )
      ],
    );
  }
}
