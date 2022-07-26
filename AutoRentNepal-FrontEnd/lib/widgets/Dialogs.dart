import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogBox {
  static foldingcube(
      {required BuildContext context, required String message}) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 300,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SpinKitFoldingCube(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                        decoration: (BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    )));
                  },
                ),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
