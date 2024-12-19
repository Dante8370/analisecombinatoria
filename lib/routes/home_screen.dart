import 'package:flutter/material.dart';

// Definição da tela principal (HomeScreen)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        // Usando o Center para centralizar o título
        title: const Center(
          child: Text(
            'Análise combinatória',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF00695C),
      ),
      // Define a cor de fundo da tela
      backgroundColor: Colors.grey[300],

      // SafeArea evita sobreposição do conteúdo com elementos do sistema (ex. barra de status)
      body: SafeArea(
        child: Column(
          children: [
            // Área superior que exibe a pergunta
            Container(
              width: double.infinity, // Largura total da tela
              height: MediaQuery.of(context).size.height * 0.1, // 10% da altura da tela
              color: const Color.fromARGB(255, 0, 71, 63), // Cor verde escura
              alignment: Alignment.center, // Centraliza o texto
              child: Text(
                'Qual calculadora você gostaria de utilizar?',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05, // Tamanho do texto baseado na largura da tela
                  color: Colors.white, // Cor do texto
                  fontFamily: 'Helvetica', // Fonte personalizada
                ),
                textAlign: TextAlign.center, // Centraliza o texto
              ),
            ),

            // Área central com os botões das calculadoras
            Expanded(
              child: SingleChildScrollView(
                // Permite rolagem vertical
                padding: const EdgeInsets.symmetric(vertical: 20), // Espaçamento vertical
                child: Column(
                  children: [
                    // Botão de "Permutação Simples"
                    _buildButton(
                      context,
                      title: 'Permutação Simples', // Título do botão
                      content: _buildPermutacaoSimples(),
                      onTap: () => Navigator.pushNamed(context, '/permutacaoSimples'), // Navega para a tela correspondente
                    ),
                    // Botão de "Permutação com Repetição"
                    _buildButton(
                      context,
                      title: 'Permutação com Repetição',
                      content: _buildPermutacaoComRepeticaoFormula(),
                      onTap: () => Navigator.pushNamed(context, '/permutacao'),
                    ),
                    // Botão de "Arranjo"
                    _buildButton(
                      context,
                      title: 'Arranjo',
                      content:  _buildArranjoFormula(),
                      onTap: () => Navigator.pushNamed(context, '/arranjo'),
                    ),
                    // Botão de "Arranjo Com Repetição"
                    _buildButton(
                      context,
                      title: 'Arranjo Com Repetição',
                      content: _buildFormula(
                        left: "AR",
                        right: "n^p", // Fórmula para arranjo com repetição
                      ),
                      onTap: () => Navigator.pushNamed(context, '/arranjoComRepeticao'),
                    ),
                    // Botão de "Combinação Simples"
                    _buildButton(
                      context,
                      title: 'Combinação Simples',
                      content: _buildFormula(
                        left: "C",
                        right: "n!",
                        denominator: "p! (n - p)!", // Denominador da fórmula
                      ),
                      onTap: () => Navigator.pushNamed(context, '/combinacao'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para criar botões com fórmula e navegação
  Widget _buildButton(BuildContext context, {
    required String title, // Título do botão
    required Widget content, // Conteúdo visual do botão (fórmula)
    required VoidCallback onTap, // Ação ao pressionar o botão
  }) {
    return Column(
      children: [
        // Texto acima do botão
        Text(
          title,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.045, // Tamanho do texto
            fontWeight: FontWeight.bold, // Negrito
            color: Colors.black, // Cor do texto
          ),
        ),
        // Botão com interação
        GestureDetector(
          onTap: onTap, // Função de navegação
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10), // Espaçamento vertical
            padding: const EdgeInsets.symmetric(horizontal: 15), // Espaçamento interno
            height: MediaQuery.of(context).size.height * 0.15, // Altura relativa à tela
            width: MediaQuery.of(context).size.width * 0.9, // Largura relativa à tela
            decoration: BoxDecoration(
              color: Colors.white, // Cor de fundo
              borderRadius: BorderRadius.circular(25), // Bordas arredondadas
              border: Border.all(color: Colors.black, width: 2), // Borda preta
            ),
            alignment: Alignment.center, // Centraliza o conteúdo
            child: content, // Insere o conteúdo (fórmula)
          ),
        ),
      ],
    );
  }


// Método para construir a fórmula com expoente
Widget buildExponent(String base, String exponent) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        base, // Base da potência (ex.: "P")
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Transform.translate(
        offset: const Offset(0, -6), // Ajuste para elevar o expoente
        child: Text(
          exponent, // Expoente (ex.: "a! x b! x c!")
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

  // Método para construir a fórmula
  Widget _buildFormula({
    required String left, // Parte esquerda da fórmula
    required String right, // Numerador
    String? denominator, // Denominador (opcional)
  }) {
    // Verifica se a parte esquerda contém uma potência
    Widget parteEsquerda;
    if (left.contains("^")) {
      final parts = left.split("^");
      parteEsquerda = buildExponent(parts[0], parts[1]);
    } else {
      parteEsquerda = Text(
        left,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    // Verifica se o numerador contém uma potência
    Widget numerador;
    if (right.contains("^")) {
      final parts = right.split("^");
      numerador = buildExponent(parts[0], parts[1]);
    } else {
      numerador = Text(
        right,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        parteEsquerda, // Renderiza a parte esquerda
        const Text(" = "), // Símbolo de igualdade
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            numerador, // Renderiza o numerador
            if (denominator != null) ...[
              Container(
                height: 2, // Linha do traço da fração
                width: 80,
                color: Colors.black,
                margin: const EdgeInsets.symmetric(vertical: 2),
              ),
              Text(
                denominator,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
  // Método para criar a fórmula específica da Permutação com Repetição
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
                  "P",
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
                        "a,b,c",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-14, -6), // Ajusta a posição do subscrito
                      child: const Text(
                        "n",
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
            // Numerador
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
            // Denominador
            const Text(
              "a!·b!·c!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPermutacaoSimples() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Parte esquerda: Pₙ
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "P",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(-4, 6), // Ajusta a posição do subscrito
                  child: const Text(
                    "n",
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
        const Text(
          " = ", // Símbolo de igualdade
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // Parte direita: Numerador
        const Text(
          "n!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

  // Método para criar a fórmula específica da Permutação com Repetição
  Widget _buildArranjoFormula() {
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
                  "A",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Transform.translate(
                      offset: const Offset(1, 6), // Ajusta a posição do subscrito
                      child: const Text(
                        "np",
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
            // Numerador
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
            // Denominador
            const Text(
              "(n - p)!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }