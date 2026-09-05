import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/generated/l10n.dart';
import 'package:flutter_project_template/gen/colors.gen.dart';
import 'package:flutter_project_template/constants/constants.dart';

class PlayDetailPage extends StatefulWidget {
  final String title;
  final String filePath;

  const PlayDetailPage({
    super.key,
    required this.title,
    required this.filePath,
  });

  @override
  State<PlayDetailPage> createState() => _PlayDetailPageState();
}

class _PlayDetailPageState extends State<PlayDetailPage> {
  late final AudioPlayer _player;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer()
      ..setSourceDeviceFile(widget.filePath)
      ..onPlayerStateChanged.listen((PlayerState state) {
        if (mounted) {
          setState(() {
            _isPlaying = state == PlayerState.playing;
          });
        }
      });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).funday), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingL),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Sizes.fontSizeXXL,
                  fontWeight: FontWeight.bold,
                  color: ColorName.color333333,
                ),
              ),
            ),
            const SizedBox(height: Sizes.paddingXXL),
            IconButton(
              iconSize: Sizes.iconXXL,
              color: ColorName.colorDe00000,
              icon: Icon(
                _isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
              ),
              onPressed: _togglePlayPause,
            ),
          ],
        ),
      ),
    );
  }
}
