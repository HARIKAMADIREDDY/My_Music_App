import 'package:flutter/material.dart';
import '../services/fake_repository.dart';
import '../widgets/music_card.dart';
import '../widgets/mini_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _isSearchExpanded = false;
  late AnimationController _searchController;
  late Animation<double> _searchWidthAnimation;

  @override
  void initState() {
    super.initState();
    _searchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _searchWidthAnimation = Tween<double>(begin: 56, end: 300).animate(
      CurvedAnimation(parent: _searchController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
      if (_isSearchExpanded) {
        _searchController.forward();
      } else {
        _searchController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final songs = FakeRepository.songs;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Discover',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            AnimatedBuilder(
              animation: _searchController,
              builder: (context, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: _searchWidthAnimation.value,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white70),
                        onPressed: _toggleSearch,
                      ),
                      if (_isSearchExpanded)
                        const Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white70,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trending',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // 🎶 Horizontal Trending Songs
            SizedBox(
              height: 220,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: ListView.separated(
                  key: ValueKey(_isSearchExpanded),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: songs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final s = songs[index];
                    return Hero(
                      tag: s.title,
                      child: MusicCard(song: s),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Recently Played',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // 🎵 Vertical Recently Played List
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: songs.length,
                separatorBuilder: (_, __) =>
                const Divider(height: 1, color: Colors.white10),
                itemBuilder: (context, index) {
                  final s = songs[index];
                  return ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        s.assetPath,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      s.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      s.artist,
                      style:
                      const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    trailing: IconButton(
                      icon:
                      const Icon(Icons.more_vert, color: Colors.white70),
                      onPressed: () {},
                    ),
                    onTap: () => Navigator.pushNamed(context, '/now'),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // 🎧 Floating Mini Player
      bottomNavigationBar: MiniPlayer(
        title: songs[0].title,
        artist: songs[0].artist,
        assetPath: songs[0].assetPath,
      ),
    );
  }
}
