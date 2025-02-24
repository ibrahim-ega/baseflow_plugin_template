import 'package:baseflow_plugin_template/src/info_page.dart';
import 'package:baseflow_plugin_template/src/page.dart';
import 'package:flutter/material.dart';

import 'home.dart';

/// A Flutter application demonstrating the functionality of this plugin
class BaseflowPluginExample extends StatelessWidget {
  final String pluginName;
  final List<ExamplePage> pages;
  final List<Widget>? appBarActions;

  /// [MaterialColor] to be used in the app [ThemeData]
  final MaterialColor themeMaterialColor =
      createMaterialColor(const Color.fromRGBO(207, 206, 195, 1));

  BaseflowPluginExample({
    super.key,
    required this.pluginName,
    required String githubURL,
    required String pubDevURL,
    required this.pages,
    this.appBarActions,
  }) {
    pages.add(InfoPage.createPage(pluginName, githubURL, pubDevURL));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baseflow $pluginName',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: Colors.black54,
              surface: const Color.fromRGBO(207, 206, 195, 0.8),
            ),
        buttonTheme: ButtonThemeData(
          buttonColor: themeMaterialColor.shade500,
          disabledColor: themeMaterialColor.withRed(55),
          splashColor: themeMaterialColor.shade900,
          textTheme: ButtonTextTheme.primary,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color.fromRGBO(198, 197, 184, 1),
        ),
        hintColor: themeMaterialColor.shade500,
        primarySwatch:
            createMaterialColor(const Color.fromRGBO(207, 206, 195, 1)),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 16,
            height: 1.3,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 18,
            height: 1.2,
          ),
          labelLarge: TextStyle(color: Colors.black),
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color.fromRGBO(218, 218, 218, 1),
          filled: true,
        ),
      ),
      home: AppHome(
        title: 'Baseflow $pluginName example app',
        pages: pages,
        appBarActions: appBarActions,
      ),
    );
  }

  /// Creates a [MaterialColor] based on the supplied [Color]
  static MaterialColor createMaterialColor(Color color) {
    var strengths = <double>[.05];
    var swatch = <int, Color>{};
    final r = 255 - color.red, g = 255 - color.green, b = 255 - color.blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
