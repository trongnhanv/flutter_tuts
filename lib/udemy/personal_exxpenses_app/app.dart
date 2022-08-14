import 'package:basic_tuts/udemy/personal_exxpenses_app/pages/home/home.dart';
import 'package:flutter/material.dart';

class PersonalExpenseApp extends StatelessWidget {
  const PersonalExpenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          theme: ThemeData(
              primarySwatch: Colors.purple,
              // colorScheme: ColorScheme.fromSwatch(accentColor: Colors.red),
              fontFamily: 'OpenSans',
              appBarTheme: const AppBarTheme(
                titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                // toolbarTextStyle:
                //     ThemeData.light().textTheme.copyWith().bodyText2,
                // titleTextStyle:
                //     ThemeData.light().textTheme.copyWith().headline6
              )

              // primaryColor: Colors.purple,
              // inputDecorationTheme: const InputDecorationTheme(
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.purple),
              //     ),
              //     floatingLabelStyle: TextStyle(color: Colors.purple)),
              // elevatedButtonTheme: ElevatedButtonThemeData(
              // style: ElevatedButton.styleFrom(primary: Colors.purple))
              )),
    );
  }
}
