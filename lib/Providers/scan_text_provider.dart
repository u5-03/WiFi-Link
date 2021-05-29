import 'dart:math';

import '../packages.dart';

class ScanTextProvider extends ChangeNotifier {
  String ssid = '';
  String password = '';
  File fileImage;
  List<String> detectedWords = [];
  List<VisionText> currentTextLabels = <VisionText>[];
  bool get isWifiInfoSelected {
    return ssid.isNotEmpty || password.isNotEmpty;
  }
  FirebaseVisionTextDetector _detector = FirebaseVisionTextDetector.instance;

  void _setDetectedWords(List<String> words) {
    this.detectedWords = words;
    notifyListeners();
  }

  void setImage(File image) {
    this.fileImage = image;
    notifyListeners();
  }

  void setSSID(String ssid) {
    this.ssid = ssid;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future<List<String>> detectText() async {
    if(fileImage == null) { return []; }
    try {
      var currentTextLabels = await _detector.detectFromPath(fileImage.path);

      if (currentTextLabels.isEmpty) { return []; }
      this.currentTextLabels = currentTextLabels;
      // スペース、:の正規表現
      RegExp splitDelimiters = RegExp(r'[\s:]');
      // 半角英数字記号の正規表現
      RegExp filterDelimiters = RegExp(r'^[a-zA-Z0-9!-/:-@¥[-`{-~]*$');
      // 除外ワードリスト
      List<String> removeWordList = ['SSID', 'AirStation'];

      // 正規表現による分割はパフォーマンスが悪いため、1回で実行できるように、joinする。
      this.detectedWords = this.currentTextLabels
        .map((e) => e.text.trim())
        .join(' ').split(splitDelimiters)
        .where((element) {
          // ５文字以上かつ半角英数字記号のみ有効
          return element.length >= 4
            && filterDelimiters.hasMatch(element)
            && !removeWordList.contains(element);
        }).toList();
      notifyListeners();
      return this.detectedWords;
    } catch (e) {
      print(e.toString());
    }
  }
}