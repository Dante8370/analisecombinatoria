import 'package:flutter/material.dart';
import '../components/custom_button.dart';

class PermutacaoSimplesScreen extends StatefulWidget {
  const PermutacaoSimplesScreen({super.key});

  @override
  State<PermutacaoSimplesScreen> createState() =>
      _PermutacaoSimplesScreenState();
}

class _PermutacaoSimplesScreenState extends State<PermutacaoSimplesScreen> {
  String n = '';
  String resultado = '';

  // Calcula o fatorial de n
  int calcularFatorial(int num) {
    if (num <= 1) return 1;
    return num * calcularFatorial(num - 1);
  }

  void handleButtonPress(String value) {
    setState(() {
      if (resultado.isEmpty) {
        n += value;
      }
    });
  }

  void handleClearPress() {
    setState(() {
      n = '';
      resultado = '';
    });
  }

  void handleCalculate() {
    try {
      final nNumber = int.tryParse(n);
      if (nNumber != null) {
        final result = calcularFatorial(nNumber).toString();
        setState(() {
          resultado = result;
        });
      } else {
        setState(() {
          resultado = 'Erro: Número inválido';
        });
      }
    } catch (error) {
      setState(() {
        resultado = 'Erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permutação Simples'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'P',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      n.isEmpty ? 'n' : n,
                     style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                    ),
                    const Text(' = ',
                    style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      n.isEmpty ? 'n' : n,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('!',
                    style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
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
                ),
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
                child: Column(
                  children: [
                    const Text(
                      'Digite o valor de n:',
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
