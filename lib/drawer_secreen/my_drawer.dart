import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tryproject/constants/app_uri.dart';
import 'package:tryproject/drawer_secreen/setting_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 137,
                  child: Image(
                    image: AssetImage('images/quran.png'),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {
              Share.share('''*Quran app*\n
                u can develop it from my github github.com/AhmadHaniShaheen ''');
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SettingScreen(),
              //   ),
              // );
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text('Rate'),
            onTap: () async {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SettingScreen(),
              //   ),
              // );
              if (!await launchUrl(
                quranAppUri,
                mode: LaunchMode.externalApplication,
              )) {
                throw 'could not lanuch $quranAppUri';
              }
            },
          ),
        ],
      ),
    );
  }
}
