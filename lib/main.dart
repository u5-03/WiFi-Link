import 'package:flutter_wifi_connect/flutter_wifi_connect.dart';

import './packages.dart';
import 'Providers/custom_providers.dart';
import './Components/components.dart';
import './Localization/localization.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ScanTextProvider()),
    ],
    child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Wi-Fi Link'),
      // Localize設定(Ref: https://tkzo.jp/blog/flutter-i18n/)
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ja'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final picker = ImagePicker();

  void _selectWifiInfo(bool isSSID) async {
    List<String> words = context.read<ScanTextProvider>().detectedWords;
    String message = isSSID ? AppLocalizations.of(context).actionSheetSSIDTitle : AppLocalizations.of(context).actionSheetPasswordTitle;
    List<BottomSheetAction> actions = words
      .map((e) => {
        BottomSheetAction(title: Text(e), onPressed: () {
          if (isSSID) {
            context.read<ScanTextProvider>().setSSID(e);
          } else {
            context.read<ScanTextProvider>().setPassword(e);
          }
          // Dismiss action sheet
          Navigator.pop(context);
          if (isSSID) {
            sleep(Duration(milliseconds: 500));
            _selectWifiInfo(false);
          }
        })
      }).expand((element) => element).toList();
    await showAdaptiveActionSheet(
      context: context,
      title: Text(message),
      actions: actions
    );
  }

  void _onPickImageSelected(ImageSource source) async {
    context.read<ScanTextProvider>().detectedWords = [];
    final pickedFile = await picker.getImage(source: source);

    try {
      if (pickedFile != null) {
        context.read<ScanTextProvider>().setImage(File(pickedFile.path));
        List<String> textList = await context.read<ScanTextProvider>().detectText();
        if (textList.isEmpty) {
          _showAlert(AppLocalizations.of(context).textListEmptyText, () {});
          return;
        }
        _selectWifiInfo(true);
      } else {
        print('No image selected.');
      }
    } catch(e) {
      print(e.toString());
    }
  }

  void _showAlert(String message, Function() completion) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                completion();
              },
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }

  void _connectWifi() async {
    // iOSはCapabilities追加しないと、以下のエラー出る
    // NEHotspotConfigurationHelper failed to communicate to helper server.
    // https://developer.apple.com/forums/thread/127834?answerId=401656022#401656022

    String ssid = context.read<ScanTextProvider>().ssid;
    String password = context.read<ScanTextProvider>().password;
//    try {
//      await WifiConnect.connect(
//        context,
//        ssid: ssid,
//        password: password,
//        hidden: false,
//        securityType: SecurityType.auto,
//      );
//    } on WifiConnectException catch (e) {
//      print('error: $e');
////      return;
//      _showAlert(AppLocalizations.of(context).connectFailureText, () => {});
//      return;
//    }
//    _showAlert(AppLocalizations.of(context).connectCompleteText, () => {});
    bool isConnected = await FlutterWifiConnect.connectToSecureNetwork(ssid, password);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ScanTextProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 32, 12, 20),
                  child: Text(
                    AppLocalizations.of(context).introText,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 20),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).gallaryExplanationText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder()
                        ),
                        child: Text(AppLocalizations.of(context).gallaryButtonText),
                        onPressed: () {
                          _onPickImageSelected(ImageSource.gallery);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 8, 12, 20),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).cameraExplanationText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder()
                        ),
                        child: Text(AppLocalizations.of(context).cameraButtonText),
                        onPressed: () {
                          _showAlert(AppLocalizations.of(context).cameraInstructionText, () => {
                          _onPickImageSelected(ImageSource.camera)
                          });
                        },
                      ),
                    ],
                  ),
                ),
                viewModel.isWifiInfoSelected
                ? WifiInfoWidget()
                : SizedBox.shrink(),
                SizedBox(height: 20),
                viewModel.isWifiInfoSelected
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder()
                      ),
                      child: Text(AppLocalizations.of(context).reselectWifiInfoText),
                      onPressed: () {
                        _selectWifiInfo(true);
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Colors.indigo[700]
                      ),
                      child: Text(AppLocalizations.of(context).connectWifiButtonText),
                      onPressed: () {
                        _connectWifi();
                      },
                    ),
                  ])
                : SizedBox.shrink(),
                SizedBox(height: 40)
              ],
            ),
          ),
      )
    );
  }
}

