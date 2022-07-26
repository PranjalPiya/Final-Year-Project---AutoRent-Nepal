import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatefulWidget {
  static const routeName = 'help-and-support';

  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.blue.shade700,
          title: Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Column(
              children: const [
                Text("Help and",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.white)),
                Text("Support",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white))
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                'Frequently Asked Questions..!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              faq(),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                child: const Text(
                  'Have Extra Queries..?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              contactUs(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget faq() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Card(
          elevation: 5,
          child: ExpansionTile(
              backgroundColor: Colors.grey.shade300,
              childrenPadding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              children: const [
                Text(
                  "User will have full access to choose the vehicle they want to rent. After selecting the vehicle, user is required to provide his/her address and should provide the total days of rents. Then, user will get two option for paying the vehicle. Hence after all the processes, user will be able to rent the vehicle. ",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
              collapsedBackgroundColor: Colors.grey.shade300,
              title: const SizedBox(
                width: double.infinity,
                child: Text(
                  "How to rent vehicle..?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )),
        ),
        //
        SizedBox(
          height: size.height * 0.02,
        ),
        //
        Card(
          elevation: 5,
          child: ExpansionTile(
              backgroundColor: Colors.grey.shade300,
              childrenPadding: const EdgeInsets.only(left: 10, right: 10),
              children: const [
                Text(
                  "Our Application comes with two types of payment options which are Online and Cash on Delievery. Talking about online payment, we currently do payment through stripe. So, inorder to pay through online user has to provide their card details along with their country zip code. A successful messege will be shown if the payment is done properly.",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
              collapsedBackgroundColor: Colors.grey.shade300,
              title: const SizedBox(
                width: double.infinity,
                child: Text(
                  "What is the procedure to pay online..?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )),
        ),
        //
        SizedBox(
          height: size.height * 0.02,
        ),
        //
        Card(
          elevation: 5,
          child: ExpansionTile(
              backgroundColor: Colors.grey.shade300,
              childrenPadding: const EdgeInsets.only(left: 10, right: 10),
              children: const [
                Text(
                  "User will have full access to choose the vehicle they want to rent. After selecting the vehicle, user is required to provide his/her address and should provide the total days of rents. Then, user will get two option for paying the vehicle. Hence after all the processes, user will be able to rent the vehicle. ",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
              collapsedBackgroundColor: Colors.grey.shade300,
              title: const SizedBox(
                width: double.infinity,
                child: Text(
                  "I want to hire a driver as well. How to do so..?",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )),
        ),
        //
        SizedBox(
          height: size.height * 0.02,
        ),
        //
        Card(
          elevation: 5,
          child: ExpansionTile(
              backgroundColor: Colors.grey.shade300,
              childrenPadding: const EdgeInsets.only(left: 10, right: 10),
              children: const [
                Text(
                  "User will have full access to choose the vehicle they want to rent. After selecting the vehicle, user is required to provide his/her address and should provide the total days of rents. Then, user will get two option for paying the vehicle. Hence after all the processes, user will be able to rent the vehicle. ",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
              collapsedBackgroundColor: Colors.grey.shade300,
              title: const SizedBox(
                width: double.infinity,
                child: Text(
                  "Where to submit our liscense in the app..?",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )),
        ),
        //
        SizedBox(
          height: size.height * 0.02,
        ),
        //
        Card(
          elevation: 5,
          child: ExpansionTile(
              backgroundColor: Colors.grey.shade300,
              childrenPadding: const EdgeInsets.only(left: 10, right: 10),
              children: const [
                Text(
                  "User will have full access to choose the vehicle they want to rent. After selecting the vehicle, user is required to provide his/her address and should provide the total days of rents. Then, user will get two option for paying the vehicle. Hence after all the processes, user will be able to rent the vehicle. ",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
              collapsedBackgroundColor: Colors.grey.shade300,
              title: const SizedBox(
                width: double.infinity,
                child: Text(
                  "How to reset password..?",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )),
        ),
        //
        SizedBox(
          height: size.height * 0.02,
        ),
        //
      ],
    );
  }

  Widget contactUs() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          "Contact us",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'at',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.email_outlined)),
                const Text('autorentnepal2022@gmail.com'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.facebook_outlined)),
                    const Text('AutoRent Nepal'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.call_outlined)),
                    const Text('+977-9845023754'),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
