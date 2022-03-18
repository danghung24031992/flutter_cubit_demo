import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../presentation/screens/onboarding.dart';

var notFoundHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return;
});

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const OnboardingPage();
});

Handler configHandler(page) {
  var handler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return page;
    },
  );
  return handler;
}
