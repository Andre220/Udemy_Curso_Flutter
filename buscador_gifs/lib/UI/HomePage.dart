import 'dart:convert';

import 'Package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;

  int _offset = 0;

  Future<Map>_getSearch() async {
    http.Response response;

    if (_search == null)
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=LvA5rSRaVSxnK80qJ3nYRWt7rNqY31gu&limit=20&rating=g");
    else
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=LvA5rSRaVSxnK80qJ3nYRWt7rNqY31gu&q=$_search&limit=20&offset=$_offset&rating=g&lang=en");

    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getSearch().then((map) => print(map));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
