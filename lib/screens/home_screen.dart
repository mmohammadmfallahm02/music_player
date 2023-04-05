import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/models/models.dart';
import '../common/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildDiscoverMusicWidget(ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: themeData.textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Enjoy your favorite music',
            style: themeData.textTheme.headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                hintStyle: themeData.textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade400,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none)),
          )
        ],
      ),
    );
  }

  Widget _buildTrendingMusicWidget(ThemeData themeData, List<Song> songs) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SectionHeader(
              themeData: themeData,
              title: 'Trending Music',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: Get.size.height * 0.27,
            child: ListView.builder(
                itemCount: songs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return SongCard(song: song);
                }),
          )
        ],
      ),
    );
  }

  Widget _buildPlaylistWidget(ThemeData themeData, List<Playlist> playlists) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SectionHeader(themeData: themeData, title: 'Playlists'),
          ListView.builder(
              shrinkWrap: true,
              itemCount: playlists.length,
              padding: const EdgeInsets.only(top: 20.0),
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return PlaylistCard(playlist: playlist, themeData: themeData);
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Song> songs = Song.songs;
    final List<Playlist> playlists = Playlist.playlists;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const _BuildCustomAppBar(),
        bottomNavigationBar: const _BuildCustomNavBar(),
        body: SingleChildScrollView(
          child: Column(children: [
            _buildDiscoverMusicWidget(themeData),
            _buildTrendingMusicWidget(themeData, songs),
            _buildPlaylistWidget(themeData, playlists)
          ]),
        ),
      ),
    );
  }
}

class _BuildCustomNavBar extends StatelessWidget {
  const _BuildCustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.deepPurple.shade800,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      // currentIndex: 2,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), label: 'Favorites'),
        BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline), label: 'Play'),
        BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined), label: 'Profile'),
      ],
    );
  }
}

class _BuildCustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _BuildCustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: CachedNetworkImage(
            imageUrl:
                "https://images.unsplash.com/photo-1519699047748-de8e457a634e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80",
            imageBuilder: (context, imageProvider) =>
                CircleAvatar(backgroundImage: imageProvider),
            placeholder: (context, url) => const CupertinoActivityIndicator(),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
