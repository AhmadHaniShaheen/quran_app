import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tryproject/constants/app_uri.dart';
import 'package:tryproject/shared_pref/shared_pref_controller.dart';

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener =
    ItemPositionsListener.create();

bool FABClicked = true;

class SuraBuilder extends StatefulWidget {
  const SuraBuilder(
      {super.key, this.surah, this.arabic, this.suranName, this.ayah});

  final surah;
  final arabic;
  final suranName;
  final ayah;

  @override
  State<SuraBuilder> createState() => _SuraBuilderState();
}

class _SuraBuilderState extends State<SuraBuilder> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => jumbToAyah());
    super.initState();
  }

  jumbToAyah() {
    if (FABClicked) {
      itemScrollController.scrollTo(
          index: widget.ayah,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    FABClicked = false;
  }

  Row VerseBuilder(int index, prev) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                widget.arabic[index + prev]['aya_text'],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'quran',
                  fontSize: arabicFontSize,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  SafeArea SingleSuraBuilder(LengthOfSura) {
    String fullSura = '';
    int previousVerses = 0;
    if (widget.surah + 1 != 1) {
      for (int i = widget.surah - 1; i >= 0; i--) {
        previousVerses = previousVerses + noOfVerses[i];
      }
    }

    if (!view)
      for (int i = 0; i < LengthOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }

    return SafeArea(
        child: Container(
            color: const Color.fromARGB(
              255,
              253,
              251,
              240,
            ),
            child: view
                ? ScrollablePositionedList.builder(
                    itemCount: LengthOfSura,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          index != 0 || widget.surah == 0 || widget.surah == 8
                              ? const Text('')
                              : const Basmala(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              color: index % 2 != 0
                                  ? Color.fromARGB(225, 253, 251, 240)
                                  : Color.fromARGB(225, 253, 237, 230),
                              child: PopupMenuButton(
                                child: VerseBuilder(index, previousVerses),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () async {
                                      await SharedPrefController().saveBookMark(
                                          widget.surah + 1, index);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.bookmark_add),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Bookmark'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Icon(Icons.share),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('share'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                  )
                : ListView(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              widget.surah + 1 != 1 && widget.surah + 1 != 9
                                  ? Basmala()
                                  : Text(''),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  fullSura,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'quran',
                                    fontSize: quranFontSize,
                                  ),
                                ),
                              )
                            ],
                          ))
                        ],
                      )
                    ],
                  )));
  }

  bool view = true;

  @override
  Widget build(BuildContext context) {
    int LengthOfSura = noOfVerses[widget.surah];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Tooltip(
            message: 'Mushaf Mode',
            child: IconButton(
              icon: const Icon(
                Icons.chrome_reader_mode,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  view = !view;
                });
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            widget.suranName,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: arabicFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'quran',
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ]),
          ),
          backgroundColor: const Color.fromARGB(255, 56, 115, 59),
        ),
        body: SingleSuraBuilder(LengthOfSura),
      ),
    );
  }
}

class Basmala extends StatelessWidget {
  const Basmala({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
            style: TextStyle(fontFamily: 'quran', fontSize: arabicFontSize),
            textDirection: TextDirection.rtl,
          ),
        )
      ],
    );
  }
}
