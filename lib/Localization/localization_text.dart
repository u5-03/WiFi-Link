import '../packages.dart';

class LocalizationText {
  LocalizationText({
    @required this.introText,
    @required this.cameraExplanationText,
    @required this.cameraButtonText,
    @required this.gallaryExplanationText,
    @required this.gallaryButtonText,
    @required this.actionSheetSSIDTitle,
    @required this.actionSheetPasswordTitle,
    @required this.passwordText,
    @required this.reselectWifiInfoText,
    @required this.connectWifiButtonText,
    @required this.connectCompleteText,
    @required this.connectFailureText,
    @required this.cameraInstructionText,
    @required this.textListEmptyText,
    @required this.scanCheckText,
  });

  final String introText;
  final String cameraExplanationText;
  final String cameraButtonText;
  final String gallaryExplanationText;
  final String gallaryButtonText;
  final String actionSheetSSIDTitle;
  final String actionSheetPasswordTitle;
  final String passwordText;
  final String reselectWifiInfoText;
  final String connectWifiButtonText;
  final String connectCompleteText;
  final String connectFailureText;
  final String cameraInstructionText;
  final String textListEmptyText;
  final String scanCheckText;

  factory LocalizationText.of(Locale locale) {
    switch (locale.languageCode) {
      case 'ja':
        return LocalizationText.ja();
      case 'en':
        return LocalizationText.en();
      default:
        return LocalizationText.en();
    }
  }

  factory LocalizationText.ja() => LocalizationText(
    introText: 'Wi-Fiへ接続する準備をしましょう!',
    cameraExplanationText: 'カメラでWi-FiのSSIDとパスワードを撮影する',
    cameraButtonText: 'カメラで撮影する',
    gallaryExplanationText: '【推奨】Wi-FiのSSIDとパスワードが\n写っている写真を選ぶ',
    gallaryButtonText: 'アルバムから写真を選択する',
    actionSheetSSIDTitle: 'SSIDを選択してください。\n選択後も編集できます。',
    actionSheetPasswordTitle: 'パスワードを選択してください。\n選択後も編集できます。',
    passwordText: 'パスワード',
    reselectWifiInfoText: 'SSIDとパスワードを再選択する',
    connectWifiButtonText: 'Wi-Fiへ接続する',
    connectCompleteText: '接続に成功しました!',
    connectFailureText: 'Wi-Fiへの接続に失敗しました。SSIDとパスワードを見直してください。',
    cameraInstructionText: 'SSIDとパスワードが大きく写るように撮影してください',
    textListEmptyText: 'テキスト情報を取得できませんでした',
    scanCheckText: 'スキャンされたSSID/パスワードに誤りがある場合は、訂正してください'
  );

  factory LocalizationText.en() => LocalizationText(
    introText: 'Get ready to connect to Wi-Fi!',
    cameraExplanationText: 'Take a picture of the Wi-Fi SSID and password with the camera',
    cameraButtonText: 'Take a picture',
    gallaryExplanationText: '【Recommendation】Select a photo that shows Wi-Fi SSID and password',
    gallaryButtonText: 'Select a photo from the album',
    actionSheetSSIDTitle: 'please choose SSID. \nYou can edit after selecting.',
    actionSheetPasswordTitle: 'please choose password. \nYou can edit after selecting.',
    passwordText: 'Password',
    reselectWifiInfoText: 'Reselect SSID and password',
    connectWifiButtonText: 'Connect to Wi-Fi',
    connectCompleteText: 'The connection was successful!',
    connectFailureText: 'Failed to connect to Wi-Fi. Please review your SSID and password.',
    cameraInstructionText: 'Please shoot so that the SSID and password appear large',
    textListEmptyText: 'Could not get text information',
    scanCheckText: 'If the scanned SSID / password is incorrect, please correct it.'
  );
}