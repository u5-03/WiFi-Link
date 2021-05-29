import './../packages.dart';
import './../Providers/custom_providers.dart';
import './../Localization/app_localizations.dart';

class WifiInfoWidget extends StatefulWidget {
  WifiInfoWidget({Key key}) : super(key: key);

  @override
  _WifiInfoWidget createState() => _WifiInfoWidget();
}

class _WifiInfoWidget extends State<WifiInfoWidget> {

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ScanTextProvider>(context);

    return Padding(
    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
    child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context).scanCheckText),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: 80,
                child: Text('SSID: '),
              ),
              Flexible(
                child: TextField(
                  controller: TextEditingController(text: viewModel.ssid),
                  decoration: InputDecoration(
                    prefixText: ' ',
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => viewModel.setSSID(''),
                      icon: Icon(Icons.clear),
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                  onChanged: (text) {
                    viewModel.ssid = text;
                  },
                )
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: 80,
                child: Text('${AppLocalizations.of(context).passwordText}: '),
              ),
              Flexible(child:
                TextField(
                  controller: TextEditingController(text: viewModel.password),
                  decoration: InputDecoration(
                    prefixText: ' ',
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => viewModel.setPassword(''),
                      icon: Icon(Icons.clear),
                      color: Theme.of(context).textTheme.bodyText1.color,
                    )
                  ),
                  onChanged: (text) {
                    viewModel.password = text;
                  },
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
