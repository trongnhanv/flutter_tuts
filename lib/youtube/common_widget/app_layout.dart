import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final String? textTitle;
  final Widget child;
  final void Function()? floatActionCallback;

  const AppLayout(
      {Key? key, this.textTitle, required this.child, this.floatActionCallback})
      : super(
          key: key,
        );

  PreferredSizeWidget? _buildAppBar() {
    var isShownAppBar = textTitle != null && textTitle!.isNotEmpty;
    if (!isShownAppBar) {
      return null;
    }
    return AppBar(title: Text(textTitle!));
  }

  Widget _buildBody() {
    var isShownAppBar = textTitle != null && textTitle!.isNotEmpty;
    return isShownAppBar
        ? child
        : SafeArea(
            minimum: const EdgeInsets.only(left: 5, right: 5), child: child);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,

            // Define the default font family.
            fontFamily: 'Georgia',

            // Define the default `TextTheme`. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
          ),
          home: Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
            floatingActionButton: FloatingActionButton(
                onPressed: floatActionCallback, child: const Icon(Icons.add)),
          )),
    );
  }
}
