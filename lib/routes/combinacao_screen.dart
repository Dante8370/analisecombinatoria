import 'package:flutter/material.dart';

class CombinacaoScreen extends StatefulWidget {
  const CombinacaoScreen({super.key});

  @override
  CombinacaoScreenState createState() => CombinacaoScreenState();
}

class CombinacaoScreenState extends State<CombinacaoScreen> {
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
          final result = combinacaoSimples(nNumber, pNumber);
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

  int combinacaoSimples(int n, int p) {
    return factorial(n) ~/ (factorial(p) * factorial(n - p));
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
        title: const Text('Combinação Simples'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Displaying the combination formula
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
                      'C',
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
              const SizedBox(height: 10),
              DisplayResult(resultado: resultado),
              const SizedBox(height: 2),
              // Input instruction and numpad
              Text(
                'Digite o valor de ${isTypingN ? 'n' : 'p'}',
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 10),
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
                child: GridView.builder(
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
                ),
              ), 
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayResult extends StatelessWidget {
  final String resultado;

  const DisplayResult({super.key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        'Resultado: $resultado',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
