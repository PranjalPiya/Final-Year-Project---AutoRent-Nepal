import 'package:auto_rent_nepal_fyp/Screen/SearchPage/single_search.dart';
import 'package:auto_rent_nepal_fyp/api/Provider/search_state.dart';
import 'package:auto_rent_nepal_fyp/models/search.dart';
import 'package:auto_rent_nepal_fyp/widgets/colors.dart';
import 'package:auto_rent_nepal_fyp/widgets/validatiors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _searchKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  String? searchTitle;
  bool showCancel = false;
  Future<Search>? search;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchV = Provider.of<SearchState>(context).searchessss;

    return Scaffold(
      backgroundColor: AppColor.WHITE,
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              searchV.clear();
            });
          });
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue.shade800,
              floating: true,
              pinned: true,
              snap: false,
              centerTitle: false,
              title: const Text(
                'Search Vehicle',
                style: TextStyle(),
              ),
              bottom: AppBar(
                backgroundColor: Colors.blue.shade800,
                title: Center(
                  child: Form(
                    key: _searchKey,
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) async {
                        searchTitle = value;
                        var isSearch = await Provider.of<SearchState>(context,
                                listen: false)
                            .getSearchDetails(q: "$searchTitle");
                        print(searchTitle);
                      },
                      validator: (value) {
                        return TextFieldValidator.emailValidation(value);
                      },
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        //showCancel = true;
                      },
                      decoration: InputDecoration(
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    searchV;
                                  });
                                  // searchV;
                                },
                                icon: const Icon(Icons.close))
                            : null,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Search for something',
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Other Sliver Widgets
            SliverList(
              delegate: SliverChildListDelegate([
                _searchController.text.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/no_search.png',
                              height: 300,
                              width: 500,
                            ),
                            //  Text('Search your vehicle here...! '),
                            const Text(
                                'Seach for vehicles to get displayed..!'),
                          ],
                        )),
                      )
                    : SizedBox(
                        height: 1000,
                        child: listSearch(),
                      ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget listSearch() {
    final searchV = Provider.of<SearchState>(context).searchessss;
    return ListView.builder(
        //shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: searchV.length,
        itemBuilder: (ctx, i) => SingleSearchVehicle(
              id: searchV[i].id,
              brand: searchV[i].Brand!.title,
              image: searchV[i].image,
              title: searchV[i].title,
              price: searchV[i].rentalPrice,
            ));
  }
}
