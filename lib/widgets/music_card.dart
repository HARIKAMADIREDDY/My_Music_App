
import 'package:flutter/material.dart';
import '../models/song.dart';

class MusicCard extends StatelessWidget {
  final Song song;
  const MusicCard({required this.song, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/now'),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF11121A),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 12)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(song.assetPath, height: 140, width: 160, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(song.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(song.artist, style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
