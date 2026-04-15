// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Tasky`
  String get tasky {
    return Intl.message(
      'Tasky',
      name: 'tasky',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To Tasky`
  String get welcomeToTasky {
    return Intl.message(
      'Welcome To Tasky',
      name: 'welcomeToTasky',
      desc: '',
      args: [],
    );
  }

  /// `Your productivity journey starts here.`
  String get yourProductivityJourneyStartsHere {
    return Intl.message(
      'Your productivity journey starts here.',
      name: 'yourProductivityJourneyStartsHere',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get yourName {
    return Intl.message(
      'Your Name',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Name.`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please Enter Your Name.',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Abdelwahab Mo`
  String get egAbdelwahabMo {
    return Intl.message(
      'e.g. Abdelwahab Mo',
      name: 'egAbdelwahabMo',
      desc: '',
      args: [],
    );
  }

  /// `Let's Get Started`
  String get letsGetStarted {
    return Intl.message(
      'Let\'s Get Started',
      name: 'letsGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `To Do Tasks`
  String get toDoTasks {
    return Intl.message(
      'To Do Tasks',
      name: 'toDoTasks',
      desc: '',
      args: [],
    );
  }

  /// `taskName`
  String get taskName {
    return Intl.message(
      'taskName',
      name: 'taskName',
      desc: '',
      args: [],
    );
  }

  /// `No Tasks To Do`
  String get noTasksToDo {
    return Intl.message(
      'No Tasks To Do',
      name: 'noTasksToDo',
      desc: '',
      args: [],
    );
  }

  /// `Take some rest for now`
  String get takesomerestfornow {
    return Intl.message(
      'Take some rest for now',
      name: 'takesomerestfornow',
      desc: '',
      args: [],
    );
  }

  /// `High Priority Tasks`
  String get highPriorityTasks {
    return Intl.message(
      'High Priority Tasks',
      name: 'highPriorityTasks',
      desc: '',
      args: [],
    );
  }

  /// `No High Priority Tasks`
  String get noHighPriorityTasks {
    return Intl.message(
      'No High Priority Tasks',
      name: 'noHighPriorityTasks',
      desc: '',
      args: [],
    );
  }

  /// `Relax for now`
  String get relaxfornow {
    return Intl.message(
      'Relax for now',
      name: 'relaxfornow',
      desc: '',
      args: [],
    );
  }

  /// `Completed Tasks`
  String get completedTasks {
    return Intl.message(
      'Completed Tasks',
      name: 'completedTasks',
      desc: '',
      args: [],
    );
  }

  /// `No Completed Tasks`
  String get noCompletedTasks {
    return Intl.message(
      'No Completed Tasks',
      name: 'noCompletedTasks',
      desc: '',
      args: [],
    );
  }

  /// `Time to make progress`
  String get timetomakeprogress {
    return Intl.message(
      'Time to make progress',
      name: 'timetomakeprogress',
      desc: '',
      args: [],
    );
  }

  /// `User Details`
  String get userDetails {
    return Intl.message(
      'User Details',
      name: 'userDetails',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Motivation Quote`
  String get motivationQuote {
    return Intl.message(
      'Motivation Quote',
      name: 'motivationQuote',
      desc: '',
      args: [],
    );
  }

  /// `e.g. One task at a time. One step closer.`
  String get egOnetaskatatimeOnestepcloser {
    return Intl.message(
      'e.g. One task at a time. One step closer.',
      name: 'egOnetaskatatimeOnestepcloser',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Profile Info`
  String get profileInfo {
    return Intl.message(
      'Profile Info',
      name: 'profileInfo',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `No Notes Yet`
  String get noNotesYet {
    return Intl.message(
      'No Notes Yet',
      name: 'noNotesYet',
      desc: '',
      args: [],
    );
  }

  /// `Add your first one`
  String get addyourfirstone {
    return Intl.message(
      'Add your first one',
      name: 'addyourfirstone',
      desc: '',
      args: [],
    );
  }

  /// `Delete Notes`
  String get deleteNotes {
    return Intl.message(
      'Delete Notes',
      name: 'deleteNotes',
      desc: '',
      args: [],
    );
  }

  /// `The selected notes will be permanently deleted.`
  String get theselectednoteswillbepermanentlydeleted {
    return Intl.message(
      'The selected notes will be permanently deleted.',
      name: 'theselectednoteswillbepermanentlydeleted',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add New Note`
  String get addNewNote {
    return Intl.message(
      'Add New Note',
      name: 'addNewNote',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Note something down ..`
  String get notesomethingdown {
    return Intl.message(
      'Note something down ..',
      name: 'notesomethingdown',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `To Do`
  String get toDo {
    return Intl.message(
      'To Do',
      name: 'toDo',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter The Task Name.`
  String get pleaseEnterTheTaskName {
    return Intl.message(
      'Please Enter The Task Name.',
      name: 'pleaseEnterTheTaskName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `High Priority`
  String get highPriority {
    return Intl.message(
      'High Priority',
      name: 'highPriority',
      desc: '',
      args: [],
    );
  }

  /// `Add Task`
  String get addTask {
    return Intl.message(
      'Add Task',
      name: 'addTask',
      desc: '',
      args: [],
    );
  }

  /// `Add New Task`
  String get addNewTask {
    return Intl.message(
      'Add New Task',
      name: 'addNewTask',
      desc: '',
      args: [],
    );
  }

  /// `No Tasks Yet`
  String get noTasksYet {
    return Intl.message(
      'No Tasks Yet',
      name: 'noTasksYet',
      desc: '',
      args: [],
    );
  }

  /// `Start your first one`
  String get startyourfirstone {
    return Intl.message(
      'Start your first one',
      name: 'startyourfirstone',
      desc: '',
      args: [],
    );
  }

  /// `My Tasks`
  String get myTasks {
    return Intl.message(
      'My Tasks',
      name: 'myTasks',
      desc: '',
      args: [],
    );
  }

  /// `Sort Down`
  String get sortDown {
    return Intl.message(
      'Sort Down',
      name: 'sortDown',
      desc: '',
      args: [],
    );
  }

  /// `Sort Up`
  String get sortUp {
    return Intl.message(
      'Sort Up',
      name: 'sortUp',
      desc: '',
      args: [],
    );
  }

  /// `Delete All Tasks`
  String get deleteAllTasks {
    return Intl.message(
      'Delete All Tasks',
      name: 'deleteAllTasks',
      desc: '',
      args: [],
    );
  }

  /// `All tasks will be deleted permanently.`
  String get alltaskswillbedeletedpermanently {
    return Intl.message(
      'All tasks will be deleted permanently.',
      name: 'alltaskswillbedeletedpermanently',
      desc: '',
      args: [],
    );
  }

  /// `Hello,`
  String get hello {
    return Intl.message(
      'Hello,',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `One task at a time. One step closer.`
  String get onetaskatatimeOnestepcloser {
    return Intl.message(
      'One task at a time. One step closer.',
      name: 'onetaskatatimeOnestepcloser',
      desc: '',
      args: [],
    );
  }

  /// `tasks`
  String get tasks {
    return Intl.message(
      'tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
