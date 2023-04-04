import 'package:get/get.dart';
import 'package:music_player_app/common/routes/routes.dart';
import '../../screens/screens.dart';

class AppRoutes {
  static final List<GetPage> listRoute = [
    // home screen
    GetPage(
      name: RouteName.homeScreen,
      page: () => const HomeScreen(),
    ),
    // song screen
    GetPage(
      name: RouteName.homeScreen,
      page: () => const SongScreen(),
    ),
    // playlist screen
    GetPage(
      name: RouteName.homeScreen,
      page: () => const PlaylistScreen(),
    ),
  ];
}
