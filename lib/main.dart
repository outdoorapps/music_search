import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_search/app_repository.dart';
import 'package:music_search/generated/l10n.dart';
import 'package:music_search/home_screen.dart';
import 'package:music_search/utils/debug.dart';

void main() {
  initializeDebugFunctions(kDebugMode);

  runApp(
      RepositoryProvider(create: (_) => AppRepository(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      localizationsDelegates: const [S.delegate],
      supportedLocales: const [Locale.fromSubtags(languageCode: 'en')],
      home: FutureBuilder(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: state.connectionState == ConnectionState.done
                ? const HomeScreen()
                : _getSplashScreen(context),
          );
        },
        future: AppRepository.ensureInitialized(),
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
