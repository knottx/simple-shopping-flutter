import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @cartPageAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartPageAppBarTitle;

  /// No description provided for @cartPageCheckout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get cartPageCheckout;

  /// No description provided for @cartPageCheckoutSuccessShopAgain.
  ///
  /// In en, this message translates to:
  /// **'Shop again'**
  String get cartPageCheckoutSuccessShopAgain;

  /// No description provided for @cartPageCheckoutSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for shopping with us!'**
  String get cartPageCheckoutSuccessMessage;

  /// No description provided for @cartPageCheckoutSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get cartPageCheckoutSuccessTitle;

  /// No description provided for @cartPageEmptyCart.
  ///
  /// In en, this message translates to:
  /// **'Empty Cart'**
  String get cartPageEmptyCart;

  /// No description provided for @cartPageGoToShopping.
  ///
  /// In en, this message translates to:
  /// **'Go to Shopping'**
  String get cartPageGoToShopping;

  /// No description provided for @cartPagePromotionDiscount.
  ///
  /// In en, this message translates to:
  /// **'Promotion discount'**
  String get cartPagePromotionDiscount;

  /// No description provided for @cartPageSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get cartPageSubtotal;

  /// No description provided for @commonAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get commonAddToCart;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  /// No description provided for @commonUnit.
  ///
  /// In en, this message translates to:
  /// **'unit'**
  String get commonUnit;

  /// No description provided for @shoppingPageTabCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get shoppingPageTabCart;

  /// No description provided for @shoppingPageTabShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shoppingPageTabShopping;

  /// No description provided for @errorSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorSomethingWentWrong;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Sorry'**
  String get errorTitle;

  /// No description provided for @shoppingPageLatestProducts.
  ///
  /// In en, this message translates to:
  /// **'Latest Products'**
  String get shoppingPageLatestProducts;

  /// No description provided for @shoppingPageRecommendProduct.
  ///
  /// In en, this message translates to:
  /// **'Recommend Product'**
  String get shoppingPageRecommendProduct;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
