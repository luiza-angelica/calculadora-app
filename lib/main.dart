import 'package:flutter/material.dart';

void main() => runApp(const CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String output = "0"; // O que é mostrado na tela
  String _tempOutput = ""; // Armazena temporariamente números inseridos
  double num1 = 0; // Primeiro número
  double num2 = 0; // Segundo número
  String operation = ""; // Operação atual

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        // Resetar a calculadora
        output = "0";
        _tempOutput = "";
        num1 = 0;
        num2 = 0;
        operation = "";
      } else if (value == "+" || value == "-" || value == "x" || value == "÷") {
        // Armazena o primeiro número e a operação
        if (_tempOutput.isNotEmpty) {
          num1 = double.parse(_tempOutput);
          operation = value;
          _tempOutput = ""; // Reinicia para inserir o próximo número
        }
      } else if (value == "=") {
        // Realiza o cálculo com o segundo número
        if (_tempOutput.isNotEmpty && operation.isNotEmpty) {
          num2 = double.parse(_tempOutput);
          switch (operation) {
            case "+":
              output = (num1 + num2).toString();
              break;
            case "-":
              output = (num1 - num2).toString();
              break;
            case "x":
              output = (num1 * num2).toString();
              break;
            case "÷":
              if (num2 != 0) {
                output = (num1 / num2).toString();
              } else {
                output = "Erro";
              }
              break;
          }
          operation = "";
          _tempOutput = output; // Exibe o resultado
        }
      } else {
        // Constrói os números na tela
        _tempOutput += value;
        output = _tempOutput;
      }
    });
  }

  Widget buildButton(String label, {Color? color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.pink[100],
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => buttonPressed(label),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              color: label == "C" ? Colors.blue : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.purple[50],
      body: Column(
        children: [
          // Tela de resultado
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              color: Colors.pink[50],
              child: Text(
                output,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Botões da calculadora
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("÷", color: Colors.pink[200]),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("x", color: Colors.pink[200]),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-", color: Colors.pink[200]),
                ],
              ),
              Row(
                children: [
                  buildButton("0"),
                  buildButton("."),
                  buildButton("C"),
                  buildButton("+", color: Colors.pink[200]),
                ],
              ),
              Row(
                children: [
                  buildButton("=", color: Colors.green[200]),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
