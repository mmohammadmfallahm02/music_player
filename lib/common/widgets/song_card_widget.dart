import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/models.dart';
import '../routes/routes.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  Widget _buildTagWidget(ThemeData themeData) {
    return Container(
      height: 50,
      width: Get.size.width * 0.37,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                song.title,
                style: themeData.textTheme.bodyLarge!.copyWith(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
              Text(
                song.description,
                style: themeData.textTheme.bodySmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Icon(
            Icons.play_circle,
            color: Colors.deepPurple,
          )
        ],
      ),
    );
  }

  Widget _buildBackgroundImageWidget() {
    return Container(
      width: Get.size.width * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage(
                song.coverUrl,
              ),
              fit: BoxFit.cover)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: () {
        Get.toNamed(RouteName.songScreen, arguments: song);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildBackgroundImageWidget(),
            _buildTagWidget(themeData),
          ],
        ),
      ),
    );
  }
}
