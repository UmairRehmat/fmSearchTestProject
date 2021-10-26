import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmsearcfeature/models/album_response.dart';
import 'package:fmsearcfeature/providers/search_result_provider.dart';
import 'package:provider/provider.dart';

class SearchPageScreen extends StatefulWidget {
  const SearchPageScreen({Key? key}) : super(key: key);

  @override
  _SearchPageScreenState createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {
  TextEditingController inputController = TextEditingController();
  String defaultImage =
      "https://staffordonline.org/wp-content/uploads/2019/01/Google.jpg";
  bool onSearchClicked = false;
  String currentSearch = "";
  @override
  Widget build(BuildContext context) {
    SearchProvider provider = Provider.of<SearchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Here"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Center(child: Text("Search By Album Name")),
          TextField(
            controller: inputController,
            onChanged: (input) {},
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 14, height: 1),
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                labelText: "Search Album Here",
                hintText: "Search Album Here",
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: MaterialButton(
              minWidth: 200,
              color: Theme.of(context).primaryColorDark,
              onPressed: () {
                if (inputController.text.trim().isEmpty) {
                  onSearchClicked = false;
                  return;
                }
                if (currentSearch == inputController.text.trim()) return;
                setState(() {
                  currentSearch = inputController.text.trim();
                  onSearchClicked = true;
                });
              },
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white),
              ),
              shape: StadiumBorder(),
            ),
          ),
          onSearchClicked
              ? FutureBuilder<List<Album?>>(
                  future: provider.getResults(inputController.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                      );
                    else if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: GridView.builder(
                            shrinkWrap: true,
                            primary: true,
                            physics: ScrollPhysics(), // new
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              var item = snapshot.data![index];
                              // int itemPrice = double.parse(item.price).round();
                              int length = item?.image?.length ?? 0;
                              int largeImage = length > 0 ? length - 1 : length;
                              String image =
                                  item?.image?[largeImage]!.text == ""
                                      ? defaultImage
                                      : item?.image?[largeImage]!.text ??
                                          defaultImage;
                              if (!image.startsWith("http"))
                                image = "http://$image";
                              return InkWell(
                                onTap: () {
                                  print("Item Clicked");
                                  // Navigator.push(
                                  //   context,
                                  //   TransitionEffect(
                                  //       widget: SubCategoryScreen(
                                  //           item.childrenData!, item.name!),
                                  //       alignment: Alignment.bottomCenter,
                                  //       durationAnimation: 300),
                                  // );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 15, bottom: 10),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 6),
                                  decoration: new BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(1,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      // gradient: LinearGradient(
                                      //   begin: Alignment.topCenter,
                                      //   end: Alignment.bottomCenter,
                                      //   colors: [
                                      //     Color(0xFF2D51DB),
                                      //     Color(0xFF1A3083),
                                      //   ],
                                      // ),
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Hero(
                                              tag: "MainImage$index",
                                              child: Image.network(
                                                image,
                                                fit: BoxFit.cover,
                                              ))),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        item?.name ?? " N/A",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )),
                                ),
                              );
                            }),
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
                  })
              : Text("Search Something in top Search Bar")
        ],
      ),
    );
  }
}
