import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'INPO Mobile App'**
  String get appTitle;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Specialties page title
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get specialties;

  /// News page title
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// Contacts page title
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// Chat page title
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// Error message title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Back button text
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Home page header text
  ///
  /// In en, this message translates to:
  /// **'MAIN\nPAGE'**
  String get homeHeader;

  /// Specialties page header text
  ///
  /// In en, this message translates to:
  /// **'PROFESSIONS'**
  String get specialtiesHeader;

  /// Chat bot page header text
  ///
  /// In en, this message translates to:
  /// **'CHAT-BOT'**
  String get chatHeader;

  /// Contacts page header text
  ///
  /// In en, this message translates to:
  /// **'CONTACTS'**
  String get contactsHeader;

  /// News page header text
  ///
  /// In en, this message translates to:
  /// **'NEWS'**
  String get newsHeader;

  /// Error page header text
  ///
  /// In en, this message translates to:
  /// **'ERROR'**
  String get errorHeader;

  /// Brand name/logo
  ///
  /// In en, this message translates to:
  /// **'INPO'**
  String get brandName;

  /// University name abbreviation
  ///
  /// In en, this message translates to:
  /// **'ISTU'**
  String get universityName;

  /// Why choose us section title
  ///
  /// In en, this message translates to:
  /// **'Why us?'**
  String get whyUsTitle;

  /// First feature card title
  ///
  /// In en, this message translates to:
  /// **'Constant participation in\ninternational competitions and\nolympiads'**
  String get card1Title;

  /// Second feature card title
  ///
  /// In en, this message translates to:
  /// **'Creative student\nlife'**
  String get card2Title;

  /// Third feature card title
  ///
  /// In en, this message translates to:
  /// **'Large variety of\nspecialties'**
  String get card3Title;

  /// Typing indicator text
  ///
  /// In en, this message translates to:
  /// **'Thinking...'**
  String get thinking;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went\nwrong...'**
  String get somethingWentWrong;

  /// Server error message
  ///
  /// In en, this message translates to:
  /// **'The server is lying down and relaxing,\nbut everything will be fine soon ;)'**
  String get serverMessage;

  /// Go back button text
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// URL not found error message
  ///
  /// In en, this message translates to:
  /// **'Error: URL not found'**
  String get urlNotFound;

  /// Contacts menu item
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get menuContacts;

  /// News menu item
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get menuNews;

  /// Chat/AI assistant menu item
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get menuChat;

  /// Specialties menu item
  ///
  /// In en, this message translates to:
  /// **'Professions'**
  String get menuSpecialties;

  /// Home menu item
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get menuHome;

  /// Join us call to action
  ///
  /// In en, this message translates to:
  /// **'JOIN\nUS!'**
  String get joinUs;

  /// Image collage overlay text
  ///
  /// In en, this message translates to:
  /// **'More than just an\nordinary technical institute'**
  String get moreThanInstitute;

  /// Description section header
  ///
  /// In en, this message translates to:
  /// **'DESCRIPTION'**
  String get description;

  /// Disciplines guide section header
  ///
  /// In en, this message translates to:
  /// **'DISCIPLINES GUIDE'**
  String get disciplinesGuide;

  /// Employment opportunities section header
  ///
  /// In en, this message translates to:
  /// **'WHERE WILL THEY HIRE FOR WORK AND INTERNSHIP?'**
  String get employmentOpportunities;

  /// Enroll button text
  ///
  /// In en, this message translates to:
  /// **'Enroll'**
  String get enroll;

  /// Number of available seats suffix
  ///
  /// In en, this message translates to:
  /// **'seats'**
  String get seats;

  /// Show more button text
  ///
  /// In en, this message translates to:
  /// **'More details'**
  String get showMore;

  /// Hide button text
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// Introduction text for competencies section
  ///
  /// In en, this message translates to:
  /// **'As a result of mastering the training program, the graduate will be professionally prepared for the following types of activities:'**
  String get competenciesIntro;

  /// Loading chat history message
  ///
  /// In en, this message translates to:
  /// **'Loading history...'**
  String get loadingHistory;

  /// Chat input placeholder
  ///
  /// In en, this message translates to:
  /// **'Ask the chatbot a question'**
  String get askQuestion;

  /// Chatbot subtitle
  ///
  /// In en, this message translates to:
  /// **'I will help you with any questions'**
  String get helpWithQuestions;

  /// User label in chat
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// AI assistant label in chat
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistant;

  /// AI typing indicator
  ///
  /// In en, this message translates to:
  /// **'AI Assistant is typing...'**
  String get aiTyping;

  /// Stop button text
  ///
  /// In en, this message translates to:
  /// **'STOP'**
  String get stop;

  /// Message input hint
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
