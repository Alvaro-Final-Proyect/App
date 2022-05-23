import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/res/colors.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  final _user = RetrofitHelper.user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(top: 5),
              child: const CircleAvatar(
                backgroundImage: NetworkImage('https://grandimageinc.com/wp-content/uploads/2015/09/icon-user-default.png'),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0, top: 10),
            child: Text(
              '${_user?.name?.capitalize} ${_user?.surname?.capitalize}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            height: 40,
          ),
          const DrawerItem(
            title: 'titleProfile',
            icon: Icons.manage_accounts,
            page: '/home/profile',
          ),
          const DrawerItem(
              title: 'Play!',
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
            title: 'textSettings',
            icon: Icons.settings,
            page: '/home/settings',
          )
        ],
      )
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key, required this.title, this.page, this.icon}) : super(key: key);

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
            if(page != null){
              Get.toNamed(page!);
            }
          },
          trailing: Icon(icon),
        ),
      );
  }
}