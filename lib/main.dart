import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurants in my area',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {},
                      ),
                      Text(
                        'Munchies',
                        style: TextStyle(fontFamily: 'Satisfy', fontSize: 40),
                      ),
                      IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Sections('Favorites'),
                Favorites(),
                SizedBox(
                  height: 5.0,
                ),
                Sections('All Restaurants'),
                Restaurants()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Widget> favorites = [];

  List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.png',
    'assets/images/8.jpg',
    'assets/images/9.jpg',
    'assets/images/10.jpg',
  ];

  List<String> menus = [
    "Burgers",
    "Chinese",
    "Fast Food",
    "Italian",
    "Juice",
    "Burgers",
    "Chinese",
    "Fast Food",
    "Italian",
    "Juice"
  ];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      Widget menu = Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 5.0,
                        spreadRadius: 1.0)
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  images[i],
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black])),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          menus[i],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'More than 10% off',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      favorites.add(menu);
    }

    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenWidth / 2,
      child: PageView(
        controller: PageController(initialPage: 1, viewportFraction: .8),
        scrollDirection: Axis.horizontal,
        children: favorites,
      ),
    );
  }
}

class Sections extends StatelessWidget {
  Sections(this.header);

  final String header;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            header,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black26,
                fontWeight: FontWeight.w900),
          ),
          Divider(
            height: 10.0,
            thickness: 3,
          ),
        ],
      ),
    );
  }
}

class Restaurants extends StatefulWidget {
  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Future<List<Widget>> listOfRest() async {
      List<Widget> restaurants = [];

      print('1');
      dynamic jsonData =
          await DefaultAssetBundle.of(context).loadString('assets/data.json');
      print(jsonData.toString());

      List<dynamic> rest = await jsonDecode(jsonData);
      print(rest.toString());

      rest.forEach((element) async {
        String menuItems = '';
        List<dynamic> items = element['placeItems'];
        items.forEach((item) {
          menuItems += item + ' | ';
        });

        restaurants.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 5, spreadRadius: 1)
                ]),
            width: width,
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    element['placeImage'],
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      element['placeName'],
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(menuItems),
                    Text("MinOrder : \$${element['minOrder'].toString()}"),
                  ],
                )
              ],
            ),
          ),
        ));
      });

      return restaurants;
    }

    return FutureBuilder(
      initialData: <Widget>[Text('')],
      future: listOfRest(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            primary: false,
            shrinkWrap: true,
            children: snapshot.data,
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
