import 'package:flutter/material.dart';
import './routes/home_screen.dart';
import './routes/permutacao_screen.dart';
import './routes/permutacaocomposta_screen.dart';
import './routes/arranjo_screen.dart';
import './routes/arranjo_composto_screen.dart';
import './routes/combinacao_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/permutacaoSimples': (context) => const PermutacaoSimplesScreen(),
        '/permutacao': (context) => const PermutacaoComRepeticao(),
        '/arranjo': (context) => const ArranjoSimples(),
        '/arranjoComRepeticao': (context) => const ArranjoComRepeticao(),
        '/combinacao': (context) => const CombinacaoScreen(),
      },
    );
  }
}
