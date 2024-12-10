import 'package:flutter/material.dart';
import 'dart:math';
import '../components/custom_button.dart'; // Ajuste para importar o botão personalizado

class ArranjoComRepeticao extends StatefulWidget {
  const ArranjoComRepeticao({super.key});

  @override
  State<ArranjoComRepeticao> createState() => ArranjoComRepeticaoState();
}

class ArranjoComRepeticaoState extends State<ArranjoComRepeticao> {
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

        if (nNumber != null && pNumber != null) {
          // Cálculo para arranjo com repetição: n^p
          final result = pow(nNumber, pNumber).toInt();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Caixa de exibição com borda
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('A', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('${n.isEmpty ? "n" : n},${p.isEmpty ? "p" : p}', style: const TextStyle(fontSize: 16)),
                    const Text('=', style: TextStyle(fontSize: 24)),
                    Column(
                      children: [
                        Text('${n.isEmpty ? "n" : n}^${p.isEmpty ? "p" : p}', style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
              // Caixa para exibir a entrada de números
              
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
            ],
        ),
      ),
      ),
    );
  }
}
