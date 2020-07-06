import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const requestUrl = 'https://api.hgbrasil.com/finance';

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintStyle: TextStyle(color: Colors.amber),
      )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(requestUrl);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double Dolar;
  double Euro;

  void _realChanged(String Text)
  {
    double real = double.parse(Text);
    dolarController.text = (real/Dolar).toStringAsFixed(2);
    euroController.text = (real/Euro).toStringAsFixed(2);
  }

  void _dolarChanged(String Text)
  {
    double dolar = double.parse(Text);
    realController.text = (dolar * Dolar).toStringAsFixed(2);
    euroController.text = (dolar * Dolar / Euro).toStringAsFixed(2);
  }

  void _euroChanged(String Text)
  {
    double euro = double.parse(Text);
    realController.text = (euro * Euro).toStringAsFixed(2);
    dolarController.text = (euro * Euro / Dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$Conversor de moedas\$",
              style: TextStyle(color: Colors.yellow)),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot)
            {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text("Carregando dados",
                          style:
                              TextStyle(color: Colors.yellow, fontSize: 25.0),
                          textAlign: TextAlign.center));
                default:
                  if (snapshot.hasError)
                  {
                    return Center(
                        child: Text(
                      "Erro na busca dos dados!",
                      style: TextStyle(color: Colors.yellow, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  }
                  else
                  {
                    Dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                    Euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView
                    (
                      padding: EdgeInsets.all(10.0),
                      child: Column
                      (
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>
                        [
                          Icon(Icons.monetization_on, size: 150.0, color: Colors.amber,),
                          buildTextField(realController,"Reais","R\$",_realChanged),
                          Divider(),
                          buildTextField(dolarController,"Dolares","US\$",_dolarChanged),
                          Divider(),
                          buildTextField(euroController,"Euros","€",_euroChanged)
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

Widget buildTextField(TextEditingController controller,String Label, String Prefix, Function OnChanged)
{
  return TextField(
    decoration: InputDecoration(
        labelText: Label, labelStyle: TextStyle(color: Colors.amber, fontSize: 20.0), border: OutlineInputBorder(), prefixText: Prefix
    ),
    controller: controller,
    style: TextStyle(color: Colors.amber, fontSize: 15.0),
    onChanged: OnChanged,
    keyboardType: TextInputType.number,
  );
}
