import 'package:flutter/material.dart';
import './routes/home_screen.dart';
import './routes/informacoes_screen.dart'; // Nova tela de informações

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Índice da página atual

  // Lista de telas para navegação
  final List<Widget> _pages = [
    const HomeScreen(), // Tela inicial
    const InformacoesScreen(), // Tela de informações
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Mostra a página correspondente ao índice
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índice selecionado
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Atualiza a página com base no índice
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Informações',
          ),
        ],
        selectedItemColor: Colors.teal, // Cor do item selecionado
        unselectedItemColor: Colors.grey, // Cor dos itens não selecionados
      ),
    );
  }
}
