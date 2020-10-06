import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Main.dart';
import 'PassWordScreen.dart';
import 'APP_CODE.dart' as globals;
import 'Translation.dart';

bool _isFirst;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirst  = prefs.getBool(globals.checkFirstTime) ?? true;
  _isFirst = isFirst;
  runApp(TODOLIST());
}

class TODOLIST extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var activity;
    if(_isFirst){
      activity = PassWordScreen(title: globals.MainScreenTitle);

    }else{
      activity = MyHomePage(title: globals.MainScreenTitle);
    }
    return MaterialApp(
      supportedLocales: [
        const Locale('ko', 'KR'),
        const Locale('en', 'US')
      ],
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      initialRoute: '/',
      title: 'TODO_LIST',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,

      ),
      routes:{'/ClickPage':(context)=> MyHomePage(title: 'TODOAPP Home Page')},
      home: activity,
    );
  }
}


