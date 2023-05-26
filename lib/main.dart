import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController numbergerado = TextEditingController();
  int inicials = 0;
  int finals = 100;
  int numberaleatorio = 0;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Digite um numero de 0 a 100!!";

  _abirresult() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Se Lascou"),
        content: Text("Pode Tomar Uma!"),
        actions: [
          TextButton(
            onPressed: () {
              _resetFields();

              Navigator.of(context).pop();
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  void _resetFields() {
    inicials = 0;
    finals = 100;
    setState(() {
      _infoText = "Digite um numero de 0 a 100!!";
      numberaleatorio = Random().nextInt(101);
    });
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text("Jogo iniciado!"),
      duration: Duration(
        seconds: 3,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _calculate() {
    setState(
      () {
        int number = int.parse(numbergerado.text);

        if (number > numberaleatorio) {
          finals = number;
          _infoText = "Digite um numero de ${inicials} a ${finals}!!";
        } else if (number < numberaleatorio) {
          inicials = number;
          _infoText = "Digite um numero de ${inicials} a ${finals}!!";
        } else if (number == numberaleatorio) {
          _abirresult();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo dos 100"),
        centerTitle: true,
        backgroundColor: Colors.limeAccent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 120.0,
                color: Colors.black,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: numbergerado,
                decoration: InputDecoration(
                  labelText: "Número",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira Um Numero!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.limeAccent,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Enter",
                      style: TextStyle(
                        color: Color.fromARGB(255, 249, 249, 249),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(224, 0, 0, 0),
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
