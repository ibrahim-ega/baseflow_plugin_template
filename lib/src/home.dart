import 'package:baseflow_plugin_template/src/page.dart';
import 'package:flutter/material.dart';

/// A Flutter example demonstrating how the [pluginName] plugin could be used
class AppHome extends StatefulWidget {
  /// Constructs the [AppHome] class
  const AppHome({
    super.key,
    required this.title,
    required this.pages,
    this.appBarActions,
  });

  /// The [title] of the application, which is shown in the application's
  /// title bar.
  final String title;
  final List<ExamplePage> pages;
  final List<Widget>? appBarActions;

  @override
  State createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  static final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final pageWidgets = widget.pages.map((element) {
      return element.pageBuilder(context);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        actions: _currentPage == 0 ? widget.appBarActions : null,
        title: Image.asset(
          'assets/logo.png',
          width: 50,
          package: 'baseflow_plugin_template',
        ),
      ),
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      body: PageView(
        controller: _pageController,
        children: pageWidgets,
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
      ),
      bottomNavigationBar: _bottomAppBar(),
    );
  }

  BottomAppBar _bottomAppBar() {
    return BottomAppBar(
      elevation: 5,
      color: Theme.of(context).bottomAppBarTheme.color,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.unmodifiable(() sync* {
          for (var i = 0; i < widget.pages.length; i++) {
            yield Expanded(
              child: IconButton(
                iconSize: 30,
                icon: Icon(widget.pages[i].icon),
                color: _bottomAppBarIconColor(i),
                onPressed: () => _animateToPage(i),
              ),
            );
          }
        }()),
      ),
    );
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  Color _bottomAppBarIconColor(int page) {
    return _currentPage == page
        ? Colors.white
        : Theme.of(context).colorScheme.secondary;
  }
}
