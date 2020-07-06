import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp
    (home: Home(),title: "Calculadora IMC",)
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe seu peso e altura.";
  double IMC = 0;

  void _ResetFields()
  {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _info = "Informe seu peso e altura";
    });
  }

  void _calculaImc()
  {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.6)
      {
        _info = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      }
      
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
          title: Text('Calculadora de IMC',),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>
          [
            IconButton
              (
                icon: Icon(Icons.autorenew),
                onPressed: _ResetFields,
              )
          ]
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView
      (
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Form
        (
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>
              [
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField
                  (
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration
                    (
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.green)
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: weightController,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return "insira seu peso";
                      }
                    },
                  ),
                TextFormField
                (
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration
                    (
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value)
                  {
                    if(value.isEmpty)
                    {
                      return "insira sua altura";
                    }
                  },
                ),
                Padding
                  (
                  padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                  child: Container
                    (
                    height: 50.0,
                    child:  RaisedButton
                      (
                      onPressed: ()
                      {
                        if(_formKey.currentState.validate())
                        {
                          _calculaImc();
                        }
                      },
                      child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(_info, textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25.0),)
              ],
            ),
        ),
      )
    );
  }
}
