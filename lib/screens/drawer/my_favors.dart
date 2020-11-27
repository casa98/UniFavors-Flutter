import 'package:auth/shared/constants.dart';
import 'package:flutter/material.dart';

class MyFavors extends StatelessWidget {
  final String _title;
  MyFavors(this._title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: Text(MY_FAVORS),
      ),
    );
  }
}