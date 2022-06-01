import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:padel/core/retrofit_helper.dart';

import '../data/models/user_response.dart';
import '../res/constants.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  final _user = RetrofitHelper.user.obs;
  UserModel? get user => _user.value;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundImage: user?.image == null
                        ? Image.network(userImageUrl).image
                        : Image.memory(base64Decode(user!.image!)).image,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0, top: 10),
                  child: Text(
                    '${user?.name?.capitalize} ${user?.surname?.capitalize}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const DrawerItem(
            title: 'titleProfile',
            icon: Icons.manage_accounts,
            page: '/home/profile',
          ),
          const DrawerItem(
            title: 'textPlay',
            icon: Icons.sports_tennis,
            page: '/home/matches',
          ),
          const DrawerItem(
            title: 'textFriends',
            icon: Icons.people,
            page: '/home/friends',
          ),
          const DrawerItem(
            title: 'textTournaments',
            icon: Icons.military_tech,
            page: '/home/tournaments',
          ),
          const DrawerItem(
            title: 'textInvitations',
            icon: Icons.mail,
            page: '/home/invitations',
          ),
          const DrawerItem(
            title: 'Ranking',
            icon: FontAwesomeIcons.rankingStar,
            page: '/home/ranking',
          ),
          const DrawerItem(
            title: 'textSettings',
            icon: Icons.settings,
            page: '/home/settings',
          ),
          if(user!.isAdmin)
            const DrawerItem(
              title: 'textAdministration',
              icon: Icons.admin_panel_settings,
              page: '/home/administration',
            ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key, required this.title, this.page, this.icon})
      : super(key: key);

  final String title;
  final String? page;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      color: Theme.of(context).colorScheme.onPrimary,
      child: ListTile(
        title: Text(title.tr),
        onTap: () {
          if (page != null) {
            Get.toNamed(page!);
          }
        },
        trailing: Icon(icon),
      ),
    );
  }
}
