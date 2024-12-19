import 'package:flutter/material.dart';
import 'dart:math';
import '../components/custom_button.dart';

class ArranjoComRepeticao extends StatefulWidget {
  const ArranjoComRepeticao({super.key});

  @override
  State<ArranjoComRepeticao> createState() => _ArranjoComRepeticaoState();
}

class _ArranjoComRepeticaoState extends State<ArranjoComRepeticao> {
  String n = '';
  String p = '';
  String resultado = '';
  bool isTypingN = true;

  void handleButtonPress(String value) {
    setState(() {
      if (resultado.isEmpty) {
        if (isTypingN) {
          n += value; // Adiciona o número ao valor de n
        } else {
          p += value; // Adiciona o número ao valor de p
        }
      }
    });
  }

  void handleClearPress() {
    setState(() {
      n = '';
      p = '';
      resultado = '';
      isTypingN = true;
    });
  }

  void handleCalculate() {
    if (isTypingN) {
      setState(() {
        isTypingN = false; // Alterna para digitar p
      });
    } else {
      try {
        final nNumber = int.tryParse(n); // Converte n para int
        final pNumber = int.tryParse(p); // Converte p para int

        if (nNumber != null && pNumber != null) {
          final result = pow(nNumber, pNumber).toInt(); // Calcula n^p
          setState(() {
            resultado = result.toString(); // Exibe o resultado
          });
        } else {
          setState(() {
            resultado = 'Erro: Números inválidos';
          });
        }
      } catch (e) {
        setState(() {
          resultado = 'Erro';
        });
      }
    }
  }

  Widget buildNumberPad() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        if (index < 9) {
          return CustomButton(
            label: '${index + 1}',
            onPressed: () => handleButtonPress('${index + 1}'),
          );
        } else if (index == 9) {
          return CustomButton(
            label: 'Limpar',
            onPressed: handleClearPress,
            color: Colors.red,
          );
        } else if (index == 10) {
          return CustomButton(
            label: '0',
            onPressed: () => handleButtonPress('0'),
          );
        } else {
          return CustomButton(
            label: 'Calcular',
            onPressed: handleCalculate,
            color: Colors.green,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arranjos com Repetição'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isTypingN
                      ? 'Digite o valor de n: $n'
                      : 'Digite o valor de p: $p',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              buildNumberPad(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Resultado: $resultado',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
