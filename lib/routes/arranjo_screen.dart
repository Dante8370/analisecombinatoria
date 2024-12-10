import 'package:flutter/material.dart';
import '../components/custom_button.dart'; // Certifique-se de importar o CustomButton

class ArranjoSimples extends StatefulWidget {
  const ArranjoSimples({super.key});

  @override
  ArranjoSimplesState createState() => ArranjoSimplesState();
}

class ArranjoSimplesState extends State<ArranjoSimples> {
  String n = '';
  String p = '';
  String resultado = '';
  bool isTypingN = true;

  void handleButtonPress(String value) {
    setState(() {
      if (resultado.isEmpty) {
        if (isTypingN) {
          n += value;
        } else {
          p += value;
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
        isTypingN = false;
      });
    } else {
      try {
        final nNumber = int.tryParse(n);
        final pNumber = int.tryParse(p);

        if (nNumber != null && pNumber != null && nNumber >= pNumber) {
          final result = arranjoSimples(nNumber, pNumber);
          setState(() {
            resultado = result.toString();
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

  int arranjoSimples(int n, int p) {
    return factorial(n) ~/ factorial(n - p);
  }

  int factorial(int num) {
    if (num <= 1) return 1;
    return num * factorial(num - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Arranjos Simples'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'A',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${n.isEmpty ? "n" : n},${p.isEmpty ? "p" : p}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Text(
                      '=',
                      style: TextStyle(fontSize: 24),
                    ),
                    Column(
                      children: [
                        Text(
                          '${n.isEmpty ? "n" : n}!',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Container(
                          height: 2,
                          width: 50,
                          color: Colors.black,
                        ),
                        Text(
                          '(${n.isEmpty ? "n" : n} - ${p.isEmpty ? "p" : p})!',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Column(
              children: [
                const Text(
                  'Digite os valores de n e p:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 12, // Total de botões
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 botões por linha
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    if (index < 9) {
                      // Botões de 1 a 9
                      return CustomButton(
                        label: '${index + 1}',
                        onPressed: () => handleButtonPress('${index + 1}'),
                      );
                    } else if (index == 9) {
                      // Botão Limpar
                      return CustomButton(
                        label: 'Limpar',
                        onPressed: handleClearPress,
                        color: Colors.red, // Cor personalizada
                      );
                    } else if (index == 10) {
                      // Botão 0
                      return CustomButton(
                        label: '0',
                        onPressed: () => handleButtonPress('0'),
                      );
                    } else {
                      // Botão Calcular
                      return CustomButton(
                        label: 'Calcular',
                        onPressed: handleCalculate,
                        color: Colors.green, // Cor personalizada
                      );
                    }
                  },
                ),
              ],
            ), 
          ],
        ),
      ),
    );
  }
}

class DisplayForm extends StatelessWidget {
  final String n;
  final String p;

  const DisplayForm({super.key, required this.n, required this.p});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('A',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('${n.isEmpty ? "n" : n},${p.isEmpty ? "p" : p}',
              style: const TextStyle(fontSize: 12)),
          const Text('=', style: TextStyle(fontSize: 24)),
          Column(
            children: [
              Text('${n.isEmpty ? "n" : n}!',
                  style: const TextStyle(fontSize: 20)),
              Container(
                height: 2,
                width: 50,
                color: Colors.black,
              ),
              Text('(${n.isEmpty ? "n" : n} - ${p.isEmpty ? "p" : p})!',
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }
}

