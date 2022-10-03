import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: const TextStyle(
              color: Colors.white,
            ),
          ),
          appBarTheme: AppBarTheme(
              toolbarTextStyle:
              ThemeData.light().textTheme.headline6?.merge(const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.amber),
        ),
        title: 'Personal Expenses');
  }
}