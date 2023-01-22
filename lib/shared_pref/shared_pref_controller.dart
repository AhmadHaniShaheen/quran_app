import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryproject/constants/app_uri.dart';

int bookmarkAyah = 1;
int bookmarkSurah = 1;

class SharedPrefController {
  static final SharedPrefController _instance = SharedPrefController._();
  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveSetting() async {
    await _sharedPreferences.setInt('arabicFontSize', arabicFontSize.toInt());
    await _sharedPreferences.setInt('quranFontSize', quranFontSize.toInt());
  }

  Future<void> saveBookMark(surah, ayah) async {
    _sharedPreferences.setInt('surah', surah);
    _sharedPreferences.setInt('ayah', ayah);
  }

  Future<bool> readBookMark() async {
    try {
      bookmarkAyah = _sharedPreferences.getInt('ayah')!;
      bookmarkSurah = _sharedPreferences.getInt('surah')!;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getSetting() async {
    try {
      arabicFontSize =
          await _sharedPreferences.getInt("arabicFontSize")!.toDouble();
      arabicFontSize =
          await _sharedPreferences.getInt("quranFontSize")!.toDouble();
    } catch (_) {
      arabicFontSize = 28;
      quranFontSize = 40;
    }
  }

  SharedPrefController._();
}
