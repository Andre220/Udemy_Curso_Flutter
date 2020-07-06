import 'package:flutter/material.dart';
import 'package:buscador_gifs/UI/HomePage.dart';
import 'package:buscador_gifs/UI/GifPage.dart';

void main() {
  runApp(MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          hintColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            hintStyle: TextStyle(color: Colors.orange),
          )
      )
  )
  );
}
