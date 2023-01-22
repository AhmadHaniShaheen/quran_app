import 'package:flutter/material.dart';
import 'package:tryproject/constants/app_uri.dart';
import 'package:tryproject/drawer_secreen/my_drawer.dart';
import 'package:tryproject/models/quran_details.dart';
import 'package:tryproject/shared_pref/shared_pref_controller.dart';
import 'package:tryproject/widgets/arabic_sura_num.dart';
import 'package:tryproject/widgets/sura_builder.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FABClicked = true;
          if (await SharedPrefController().readBookMark() == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuraBuilder(
                  arabic: quran[0],
                  surah: bookmarkSurah - 1,
                  suranName: QuranDetails().arabicName[bookmarkSurah - 1]
                      ['name'],
                  ayah: bookmarkAyah,
                ),
              ),
            );
          }
        },
        tooltip: 'Go to bookmark',
        backgroundColor: Colors.green,
        child: const Icon(Icons.bookmark),
      ),
      appBar: AppBar(
        title: Text(
          " ‏‏‏‏‏‏‏ ‏‏‏‏‏‏",
          style: TextStyle(fontFamily: 'quran', fontSize: 24, shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 2.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ]),
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 56, 115, 59),
      ),
      body: FutureBuilder(
        future: readJson(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print('error is: ${snapshot.error}');
              return const Center(child: Text('error here'));
            } else if (snapshot.hasData) {
              return indexCreator(snapshot.data, context);
            } else {
              return const Center(child: const Text('Empty data'));
            }
          } else {
            return Center(child: Text('State: ${snapshot.connectionState}'));
          }
        },
      ),
    );
  }

  Container indexCreator(quran, context) {
    return Container(
      color: const Color.fromARGB(255, 221, 250, 236),
      child: ListView(
        children: [
          for (int i = 0; i < 114; i++)
            Container(
              color: i % 2 == 0
                  ? const Color.fromARGB(255, 253, 247, 230)
                  : const Color.fromARGB(255, 253, 251, 240),
              child: TextButton(
                child: Row(
                  children: [
                    ArabicSuraNumbers(i: i),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      QuranDetails().arabicName[i]['name'],
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black87,
                          fontFamily: 'quran',
                          shadows: [
                            Shadow(
                              offset: Offset(.5, .5),
                              blurRadius: 1.0,
                              color: Color.fromARGB(255, 130, 130, 130),
                            )
                          ]),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                onPressed: () {
                  FABClicked = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuraBuilder(
                        arabic: quran[0],
                        surah: i,
                        suranName: QuranDetails().arabicName[i]['name'],
                        ayah: 0,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
