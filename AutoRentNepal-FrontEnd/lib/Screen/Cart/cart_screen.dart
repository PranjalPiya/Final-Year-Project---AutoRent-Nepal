import 'package:auto_rent_nepal_fyp/Screen/Cart/single_cart.dart';
import 'package:auto_rent_nepal_fyp/Screen/Dashboard/landing_page.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screens';

  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart = Provider.of<CartState>(context).cart;

    if (cart == null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 10,
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
            title: Column(
              children: const [
                Text("Details",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                Text("Cart",
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Opps..!",
                style: GoogleFonts.roboto(
                  fontSize: 25,
                ),
              ),
              Image.asset(
                'images/empty_cart.png',
                height: 250,
                width: 500,
              ),
              Text(
                "No any vehicles added to the cart..!",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              elevation: 10,
              backgroundColor: Colors.blue.shade800,
              centerTitle: true,
              title: Column(
                children: const [
                  Text("Details",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                  Text("Cart",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
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
          body: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartvehicles!.length,
                    itemBuilder: (ctx, i) {
                      var item = cart.cartvehicles![i];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              flex: 1,
                              onPressed: (BuildContext context) {
                                Provider.of<CartState>(context, listen: false)
                                    .deleteVehicleCart(item!.id!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.blue,
                                        content: Text(
                                            'Vehicle removed from the cart')));
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: SingleCart(
                          id: item!.vehicle![0]!.id,
                          image: item.vehicle![0]!.image,
                          price: item.price,
                          title: item.vehicle![0]!.title,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: RaisedButton(
            color: Colors.red.shade600,
            onPressed: cart.cartvehicles!.isEmpty
                ? null
                : () async {
                    bool isdelete =
                        await Provider.of<CartState>(context, listen: false)
                            .deletecart(cart.id!);
                    if (isdelete) {
                      Navigator.of(context)
                          .pushReplacementNamed(LandingPage.routeName);
                    }
                  },
            child: const Text("Delete All"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      );
    }
  }
}

void doNothing(BuildContext context) {}
