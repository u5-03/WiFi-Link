import '../packages.dart';

// class AdManager {
//   static String get appId {
//     if (Platform.isIOS) {
//       return 'ca-app-pub-3168345110913095~1884645660';
//     } else if (Platform.isAndroid) {
//       return '';
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }

//   static String get bannerAdUnitId {
//     if (Platform.isIOS) {
//       if (bool.fromEnvironment('dart.vm.product')) {
//         // Release
//         return 'ca-app-pub-3168345110913095/2201992825';
//       } else {
//         return BannerAd.testAdUnitId;
//       }
//     } else if (Platform.isAndroid) {
//       return '';
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }

//   static final BannerAd banner = BannerAd(
//     adUnitId: AdManager.bannerAdUnitId,
//     size: AdSize.banner,
//     request: AdRequest(),
//     listener: listener
//   );

//   static final AdListener listener = AdListener(
//     // Called when an ad is successfully received.
//     onAdLoaded: (Ad ad) => print('Ad loaded.'),
//     // Called when an ad request failed.
//     onAdFailedToLoad: (Ad ad, LoadAdError error) {
//       ad.dispose();
//       print('Ad failed to load: $error');
//     },
//     // Called when an ad opens an overlay that covers the screen.
//     onAdOpened: (Ad ad) => print('Ad opened.'),
//     // Called when an ad removes an overlay that covers the screen.
//     onAdClosed: (Ad ad) => print('Ad closed.'),
//     // Called when an ad is in the process of leaving the application.
//     onApplicationExit: (Ad ad) => print('Left application.'),
//   );

//   static void initialize() {
//     MobileAds.instance.initialize();
//   }
// }