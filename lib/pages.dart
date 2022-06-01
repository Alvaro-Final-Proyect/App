import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:padel/screens/challenge_screen/challenge_screen.dart';
import 'package:padel/screens/friend_screen/friend_page.dart';
import 'package:padel/screens/home_screen/home_page.dart';
import 'package:padel/screens/invitations_screen/invitations_screen.dart';
import 'package:padel/screens/login_screen/login_page.dart';
import 'package:padel/screens/match_screen/match_page.dart';
import 'package:padel/screens/matches_screen/matches_page.dart';
import 'package:padel/screens/profile_screen/profile_page.dart';
import 'package:padel/screens/ranking_screen/ranking_screen.dart';
import 'package:padel/screens/register-screen/register_page.dart';
import 'package:padel/screens/settings_screen/settings_screen.dart';
import 'package:padel/screens/tournaments_screen/tournaments_screen.dart';

List<GetPage<dynamic>> pages = [
  GetPage(
    name: '/login',
    page: () => LoginPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/register',
    page: () => RegisterPage(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/home/friends',
    page: () => FriendPage(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: '/home/profile',
    page: () => ProfilePage(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: '/home/matches',
    page: () => MatchesPage(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: '/home/matches/match',
    page: () => MatchPage(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: '/home/tournaments',
    page: () => TournamentsPage(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: '/home/settings',
    page: () => SettingsScreen(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: '/home/matches/match/challenge',
    page: () => ChallengeScreen(),
    transition: Transition.upToDown,
  ),
  GetPage(
    name: '/home/invitations',
    page: () => InvitationsScreen(),
  ),
  GetPage(
    name: '/home/ranking',
    page: () => RankingScreen(),
  ),
];
