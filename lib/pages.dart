import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:padel/screens/administration_screen/administration_screen.dart';
import 'package:padel/screens/challenge_screen/challenge_screen.dart';
import 'package:padel/screens/company_settings_screen/company_settings_screen.dart';
import 'package:padel/screens/create_user_screen/create_user_screen.dart';
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
import 'package:padel/screens/tournament_screen/tournament_screen.dart';
import 'package:padel/screens/tournaments_screen/tournaments_screen.dart';
import 'package:padel/screens/update_user_screen/update_user_screen.dart';

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
    page: () => TournamentsScreen(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: '/home/tournaments/tournament',
    page: () => TournamentScreen(),
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
  GetPage(
    name: '/home/administration',
    page: () => AdministrationScreen(),
  ),
  GetPage(
    name: '/home/administration/companySettings',
    page: () => CompanySettingsScreen(),
  ),
  GetPage(
    name: '/home/administration/updateUser',
    page: () => UpdateUserScreen(),
  ),
  GetPage(
    name: '/home/administration/createUser',
    page: () => CreateUserScreen(),
  ),
];
