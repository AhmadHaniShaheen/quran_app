import 'package:flutter/material.dart';
import 'package:tryproject/constants/app_uri.dart';
import 'package:tryproject/shared_pref/shared_pref_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          const Text(
            'Arabic Font Size:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Slider(
            value: arabicFontSize,
            min: 20,
            max: 40,
            onChanged: (value) {
              setState(() {
                arabicFontSize = value;
              });
            },
          ),
          Text(
            "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
            style: TextStyle(fontFamily: 'quran', fontSize: arabicFontSize),
            textDirection: TextDirection.rtl,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Divider(),
          ),
          const Text(
            'Mushaf Mode Font Size:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Slider(
            value: quranFontSize,
            min: 20,
            max: 50,
            onChanged: (value) {
              setState(() {
                quranFontSize = value;
              });
            },
          ),
          Text(
            "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
            style: TextStyle(fontFamily: 'quran', fontSize: quranFontSize),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(150, 46)),
                onPressed: () {
                  setState(() {
                    arabicFontSize = 28;
                    quranFontSize = 40;
                  });
                  SharedPrefController().saveSetting();
                },
                child: Text('Rest'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(150, 46)),
                onPressed: () {
                  setState(() {
                    arabicFontSize = 28;
                    quranFontSize = 40;
                  });
                  SharedPrefController().saveSetting();
                  Navigator.pop(context);
                },
                child: Text('save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
