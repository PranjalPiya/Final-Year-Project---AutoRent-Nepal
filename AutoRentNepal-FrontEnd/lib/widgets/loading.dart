import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingIndicator {
  static Widget Wave() {
    return Center(
      child: SpinKitChasingDots(
        size: 20,
        //color: Colors.green,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
              decoration: (BoxDecoration(
            color: index.isEven ? Colors.white : Colors.blue,
          )));
        },
      ),
    );
  }

  static Widget FoldingCube() {
    return Center(
      child: SpinKitFoldingCube(
        //color: Colors.green,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
              decoration: (BoxDecoration(
            color: index.isEven ? Colors.blue : Colors.blue.shade800,
          )));
        },
      ),
    );
  }

  static Widget FoldingCubeIndicator(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SpinKitChasingDots(
          color: Colors.blue,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          message,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}
