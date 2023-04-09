import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/common/routes/app_routes.dart';
import 'package:music_player_app/common/routes/name_routes.dart';
import '../models/models.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  Widget _buildPlaylistInfoWidget(Playlist playlist, ThemeData themeData) {
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: CachedNetworkImage(
            height: Get.size.height * 0.3,
            width: Get.size.height * 0.3,
            fit: BoxFit.cover,
            imageUrl: playlist.imageUrl,
            placeholder: (context, url) => const CupertinoActivityIndicator()),
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        playlist.title,
        style: themeData.textTheme.headlineSmall!
            .copyWith(fontWeight: FontWeight.bold),
      )
    ]);
  }

  Widget _buildPlaylistSongWidget(Playlist playlist, ThemeData themeData) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 25),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: playlist.songs.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          final song = playlist.songs[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(RouteName.songScreen,arguments: song);
              },
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                tileColor: Colors.deepPurple.shade200.withOpacity(0.2),
                leading: Text(
                  '${index + 1}',
                  style: themeData.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                title: Text(
                  song.title,
                  style: themeData.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${song.description} ⚬ 02:45'),
                trailing: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Playlist playlist = Get.arguments;
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Playlist'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildPlaylistInfoWidget(playlist, themeData),
                const SizedBox(
                  height: 30,
                ),
                const PlayOrShuffleSwitch(),
                _buildPlaylistSongWidget(playlist, themeData)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayOrShuffleSwitch extends StatefulWidget {
  const PlayOrShuffleSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayOrShuffleSwitch> createState() => _PlayOrShuffleSwitchState();
}

class _PlayOrShuffleSwitchState extends State<PlayOrShuffleSwitch> {
  bool isPlay = true;
  @override
  Widget build(BuildContext context) {
    final double width = Get.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          isPlay = !isPlay;
        });
      },
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: isPlay ? 0 : width * 0.46,
              child: Container(
                height: 50,
                width: width * 0.45,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade400,
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Play',
                          style: TextStyle(
                              color: isPlay ? Colors.white : Colors.deepPurple,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.play_circle,
                        color: isPlay ? Colors.white : Colors.deepPurple,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Shuffle',
                          style: TextStyle(
                              color: isPlay ? Colors.deepPurple : Colors.white,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.shuffle,
                          color: isPlay ? Colors.deepPurple : Colors.white)
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
