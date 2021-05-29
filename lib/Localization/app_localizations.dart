import './../packages.dart';
import 'localization_text.dart';

class AppLocalizations {
  final LocalizationText localization;

  AppLocalizations(Locale locale): this.localization = LocalizationText.of(locale);

  static LocalizationText of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations).localization;
  }
}