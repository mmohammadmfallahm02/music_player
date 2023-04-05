import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/common/routes/name_routes.dart';
import '../../models/models.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.playlist,
    required this.themeData,
  }) : super(key: key);

  final Playlist playlist;
  final ThemeData themeData;

  Widget _buildImageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: CachedNetworkImage(
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        imageUrl: playlist.imageUrl,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
      ),
    );
  }

  Widget _buildContentWidget() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            playlist.title,
            style: themeData.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text("${playlist.songs.length} songs",
              maxLines: 2, style: themeData.textTheme.bodySmall!),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.playlistScreen, arguments: playlist);
      },
      child: Container(
        height: 75,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 1))
            ],
            color: Colors.deepPurple.shade800.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20.0)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _buildImageWidget(),
          const SizedBox(
            width: 20,
          ),
          _buildContentWidget(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_circle,
                color: Colors.white,
              ))
        ]),
      ),
    );
  }
}
