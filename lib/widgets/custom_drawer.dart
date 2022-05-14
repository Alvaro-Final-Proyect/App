import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

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
          const Padding(
            padding: EdgeInsets.only(bottom: 0, top: 10),
            child: Text(
              'Alvaro Martinez Gutierrez',
              style: TextStyle(
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
            title: 'Profile',
            icon: Icons.manage_accounts,
            page: '/home/profile',
          ),
          const DrawerItem(
              title: 'Play!',
              icon: Icons.sports_tennis,
              page: '/home/matches',
          ),
          const DrawerItem(
            title: 'Friends',
            icon: Icons.people,
            page: '/home/friends',
          ),
          const DrawerItem(
            title: 'Tournaments',
            icon: Icons.military_tech,
            page: '/home/tournaments',
          ),
          const DrawerItem(
            title: 'Settings',
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
      color: Get.theme.brightness == Brightness.light ? Colors.blue : Colors.lightBlueAccent,
      child: ListTile(
        title: Text(title),
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