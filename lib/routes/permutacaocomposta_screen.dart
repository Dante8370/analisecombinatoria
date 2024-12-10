import 'package:flutter/material.dart';

class PermutacaoComRepeticao extends StatefulWidget {
  const PermutacaoComRepeticao({super.key});

  @override
  PermutacaoComRepeticaoState createState() => PermutacaoComRepeticaoState();
}

class PermutacaoComRepeticaoState extends State<PermutacaoComRepeticao> {
  // Variáveis para armazenar o valor de "n" (quantidade de elementos) e o resultado do cálculo
  String n = '';
  String resultado = '';
  
  // Lista para armazenar a quantidade de elementos repetidos
  List<int> elementosRepetidos = [];

  // Controladores para os campos de texto
  final TextEditingController _controllerN = TextEditingController(); // Controlador para o campo "n"
  final TextEditingController _controllerElementos = TextEditingController(); // Controlador para os elementos repetidos

  // Função para adicionar elementos repetidos à lista
  void addQuantidadeDeElementos(String valor) {
    final int? quantidade = int.tryParse(valor); // Tenta converter o valor para inteiro
    if (quantidade != null) {
      setState(() {
        elementosRepetidos.add(quantidade); // Adiciona o valor à lista de elementos repetidos
        _controllerElementos.clear(); // Limpa o campo de elementos repetidos após o envio
      });
    }
  }

  // Função para limpar todos os campos e resetar o estado
  void handleClearPress() {
    setState(() {
      n = ''; // Limpa o valor de "n"
      resultado = ''; // Limpa o resultado
      elementosRepetidos.clear(); // Limpa a lista de elementos repetidos
      _controllerN.clear(); // Limpa o campo de entrada de "n"
    });
  }

  // Função para calcular a permutação com repetição
  void handleCalculate() {
    // Verifica se o valor de "n" ou os elementos repetidos não foram preenchidos
    if (n.isEmpty || elementosRepetidos.isEmpty) {
      // Exibe um alerta caso os campos estejam vazios
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erro'),
          content: const Text(
            'Por favor, insira um valor para "n" e os elementos repetidos.'
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final int nInt = int.parse(n); // Converte o valor de "n" para inteiro
      final int numerador = factorial(nInt); // Calcula o fatorial de "n"

      // Calcula o denominador multiplicando os fatoriais dos elementos repetidos
      final int denominador = elementosRepetidos
          .map((e) => factorial(e))
          .reduce((value, element) => value * element);

      // Calcula o resultado final da permutação com repetição
      final double resultadoFinal = numerador / denominador;

      // Exibe o resultado na tela, formatado com 2 casas decimais
      setState(() {
        resultado = resultadoFinal.toStringAsFixed(2);
      });
    } catch (e) {
      // Em caso de erro no cálculo, exibe uma mensagem de erro
      setState(() {
        resultado = 'Erro no cálculo';
      });
    }
  }

  // Função para calcular o fatorial de um número
  int factorial(int num) {
    if (num <= 1) return 1; // Base da recursão: fatorial de 0 ou 1 é 1
    return num * factorial(num - 1); // Recursivamente calcula o fatorial
  }

  // Método para construir a fórmula da permutação com repetição
  Widget _buildPermutacaoComRepeticaoFormula() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Parte esquerda: Pₙ^(a,b,c)
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "P", // Letra "P" representando permutação
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -6),
                      child: const Text(
                        "a,b,c", // Subscrito com os elementos repetidos
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-6, -2), // Ajusta a posição do subscrito
                      child: const Text(
                        "n", // Subscrito com "n"
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const Text(
          " = ", // Símbolo de igualdade
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // Parte direita: Fração
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Numerador da fração: n!
            const Text(
              "n!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Linha da fração
            Container(
              width: 60,
              height: 2,
              color: Colors.black,
              margin: const EdgeInsets.symmetric(vertical: 2),
            ),
            // Denominador da fração: a!·b!·c!
            Text(
              elementosRepetidos.isEmpty
                  ? 'a!·b!·c!' // Texto genérico caso não haja elementos repetidos
                  : elementosRepetidos.map((e) => '$e!').join(' · '), // Exibe os fatoriais dos elementos repetidos
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Cor de fundo da tela
      appBar: AppBar(
        backgroundColor: Colors.teal[700], // Cor de fundo da AppBar
        title: const Text(
          'Permutação com Repetição', // Título da tela
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true, // Centraliza o título
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Exibição da fórmula de permutação com repetição
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.9, // 90% da largura da tela
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildPermutacaoComRepeticaoFormula(),
            ),

            // Exibição do resultado do cálculo
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'O resultado é: $resultado', // Mostra o resultado calculado
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Campo de entrada para o valor de "n"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _controllerN, // Controlador para o campo de "n"
                keyboardType: TextInputType.number, // Tipo de entrada numérica
                onChanged: (value) {
                  setState(() {
                    n = value; // Atualiza o valor de "n" sempre que o usuário digita
                  });
                  print("Valor de n: $n"); // Imprime o valor de "n" no console (opcional para debugging)
                },
                decoration: const InputDecoration(
                  labelText: 'Digite o valor de n',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            // Campo de entrada para o valor dos elementos repetidos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: _controllerElementos, // Controlador para os elementos repetidos
                keyboardType: TextInputType.number, // Tipo de entrada numérica
                onSubmitted: addQuantidadeDeElementos, // Chama a função de adicionar elementos repetidos
                decoration: const InputDecoration(
                  labelText: 'Elemento repetido',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            // Botões para calcular e limpar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: handleCalculate, // Chama a função de cálculo
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: const Text('Calcular'),
                  ),
                  ElevatedButton(
                    onPressed: handleClearPress, // Limpa todos os campos
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Limpar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
