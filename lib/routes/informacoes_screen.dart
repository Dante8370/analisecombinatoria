import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class InformacoesScreen extends StatefulWidget {
  const InformacoesScreen({super.key});

  @override
  State<InformacoesScreen> createState() => _InformacoesScreenState();
}

class _InformacoesScreenState extends State<InformacoesScreen> {
  late YoutubePlayerController _controller;

  // Mapeamento de IDs dos vídeos
  final Map<String, String> videoIds = {
    'Permutação': 'z7ppAHnNqj8', // Substitua pelo ID do vídeo sobre permutação
    'Permutação com Repetição': 'fI2UFV5UA7w', // Substitua pelo ID equivalente
    'Arranjo': 'Cc7SMiwrL-s', // Substitua pelo ID equivalente
    'Arranjo com Repetição': 'pjtwmAyoCOs', // Substitua pelo ID equivalente
    'Combinação': 'ABg4eQ90Acc', // Substitua pelo ID equivalente
  };

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videoIds['Permutação']!, // Vídeo inicial
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  void _playVideo(String videoId) {
    _controller.load(videoId);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        // Usando o Center para centralizar o título
        title: const Center(
          child: Text(
            'Informações',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
            onReady: () {
              debugPrint('Player está pronto.');
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Escolha um conteúdo para assistir:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: videoIds.keys.map((title) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => _playVideo(videoIds[title]!),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00695C),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
