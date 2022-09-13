import 'package:flutter/material.dart';

class FutureWidget {
  Widget buildFutureContent(AsyncSnapshot<Object?> snapshot,
      {required Widget contentWidget,
      Widget? loadingWidget,
      Widget? errorWidget}) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return loadingWidget ??
            const Center(
              child: CircularProgressIndicator(),
            );
      case ConnectionState.done:
        if (snapshot.hasError) {
          print(snapshot.error);
          return errorWidget ??
              const Center(
                child: Text('Have an error!'),
              );
        }
        return contentWidget;
      default:
        return const Center(
          child: Text('Unhandle State!'),
        );
    }
  }
}
