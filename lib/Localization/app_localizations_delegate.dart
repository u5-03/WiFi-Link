import './app_localizations.dart';
import '../packages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>
{
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}