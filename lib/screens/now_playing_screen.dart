
import 'package:flutter/material.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  bool isPlaying = true;
  double progress = 0.3;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF1A0526), Color(0xFF0B0E1A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                const Text('Now Playing', style: TextStyle(fontSize: 14, color: Colors.white70)),
                const SizedBox(height: 8),
                const Text('Geetha Govindam', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Vijay,Rashmika', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 24),
                Expanded(
                  child: Center(
                    child: RotationTransition(
                      turns: _rotationController,
                      child: Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 20, spreadRadius: 2)],
                          image: const DecorationImage(image: AssetImage('assets/images/geetha.png'), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Progress bar and controls
                Column(
                  children: [
                    Slider(value: progress, onChanged: (v){ setState(()=>progress=v); }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('1:02', style: TextStyle(color: Colors.white70)),
                          Text('3:45', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(Icons.skip_previous, size: 36)),
                        const SizedBox(width: 12),
                        FloatingActionButton.large(
                          onPressed: (){
                            setState(()=>isPlaying = !isPlaying);
                            if(isPlaying) _rotationController.repeat();
                            else _rotationController.stop();
                          },
                          child: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 32),
                        ),
                        const SizedBox(width: 12),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.skip_next, size: 36)),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
