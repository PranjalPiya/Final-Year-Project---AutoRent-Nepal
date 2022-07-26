import 'package:auto_rent_nepal_fyp/Screen/Profile/Favourite/single_favourite.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/vehicle_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  static const routeName = '/favourite-screen';
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<VehicleState>(context).favourites;
    if (fav.isEmpty) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 10,
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
            title: Column(
              children: const [
                Text("Screen",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                Text("Favourite",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
              ],
            ),
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
              const Icon(
                Icons.favorite,
                size: 100,
                color: Colors.blue,
              ),
              Text(
                "There isn't any Favourites right now..!",
                style: GoogleFonts.roboto(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 10,
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
            title: Column(
              children: const [
                Text("Screen",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
                Text("Favourite",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 1, right: 10),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 4,
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: fav.length,
                    itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          child: SingleFavouriteVehicle(
                            brand: fav[i].Brand!.title,
                            id: fav[i].id,
                            title: fav[i].title,
                            image: fav[i].image,
                            price: fav[i].rentalPrice,
                          ),
                        )),
              ),
            ],
          ),
        ),
      );
    }
  }
}
