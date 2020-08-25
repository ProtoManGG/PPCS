import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar(
          hintText: "From Where",
          searchBarPadding: EdgeInsets.all(16),
          onItemFound: (item, int index) {},
          onSearch: (String text) {},
        ),
      ),
    );
  }
}
