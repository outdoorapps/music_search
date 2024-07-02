import 'package:flutter/material.dart';

late void Function({String? text, required String tag}) startBenchmark;
late void Function({String? text, required String tag}) getBenchmark;
late void Function(String? text) p;
Map<String, Stopwatch> _stopWatchMap = {};

void initializeDebugFunctions(bool isDebugMode) {
  if (isDebugMode) {
    startBenchmark = ({String? text, required String tag}) {
      _stopWatchMap[tag] = Stopwatch()..start();
      if (text != null) debugPrint(text);
    };
    getBenchmark = ({String? text, required String tag}) {
      _stopWatchMap[tag]?.stop();
      debugPrint('$text (${_stopWatchMap[tag]?.elapsedMilliseconds} ms)');
      _stopWatchMap.remove(tag);
    };
    p = (String? text) => debugPrint(text);
  } else {
    startBenchmark = ({String? text, required String tag}) {};
    getBenchmark = ({String? text, required String tag}) {};
    debugPrint = (String? message, {int? wrapWidth}) {};
    p = (String? text) {};
  }
}
