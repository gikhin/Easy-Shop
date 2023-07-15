import 'dart:convert';
import 'package:ecommerce/Components/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'Components/Login.dart';
import 'Components/Products.dart';
import 'Components/Cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homescreen(),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<dynamic> data = [];
  List<dynamic> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData is Map && responseData.containsKey("products")) {
        setState(() {
          data = responseData["products"];
        });
      } else {
        print("Invalid response format: $responseData");
      }
    } else {
      print("Error occurred: ${response.statusCode}");
    }
  }

  void navigateToDetailsScreen(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Product(productId: id),
      ),
    );
  }

  void addToCart(dynamic product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu,color: Color(0xFFFE6955),),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [

          FloatingActionButton(
            backgroundColor: Color(0xFFFE6955),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(
                    cartItems: cartItems,
                    onCartItemRemoved: removeFromCart,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                Icon(Icons.shopping_cart),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      cartItems.length.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Color(0xFFFE6955),
              size: 20,
            ),
            SizedBox(width: 4),
            Flexible(
              child: Text(
                "Palakkad",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFE6955),
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color:  Color(0xFFFE6955)
              ),
              child: Text(
                'More Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,fontWeight: FontWeight.bold
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person,color: Color(0xFFFE6955)),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout,color: Color(0xFFFE6955)),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(msg: 'User Successfully Logout');

              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final product = data[index];
          return Column(
            children: [
              Card(
                child: SizedBox(
                  height: 100,
                  child: ListTile(
                    onTap: () {
                      navigateToDetailsScreen(product["id"]);
                    },
                    leading: Container(
                      height: 120,
                      width: 100,
                      child: Image.network(product["thumbnail"]),
                    ),
                    title: Text(product["brand"]),
                    subtitle: Text(product["category"].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            addToCart(product);
                          },
                          icon: Icon(Icons.shopping_cart),
                          color: Color(0xFFFE6955),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
