import 'package:flutter/material.dart';

class AboutUsBody extends StatefulWidget {
  const AboutUsBody({Key? key}) : super(key: key);

  @override
  State<AboutUsBody> createState() => _AboutUsBodyState();
}

class _AboutUsBodyState extends State<AboutUsBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 10,
          backgroundColor: Colors.blue.shade800,
          centerTitle: true,
          title: Column(
            children: const [
              Text("About",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
              Text("Us",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
          actions: const [
            Icon(Icons.shopping_cart),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
