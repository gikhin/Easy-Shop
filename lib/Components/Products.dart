import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Components/Payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Ordercon.dart';

class Product extends StatefulWidget {
  const Product({Key? key, required this.productId}) : super(key: key);

  final int productId;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  dynamic product;

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
        final products = responseData["products"];
        final filteredProduct = products.firstWhere(
              (product) => product["id"] == widget.productId,
          orElse: () => null,
        );
        setState(() {
          product = filteredProduct;
        });
      } else {
        print("Invalid response format: $responseData");
      }
    } else {
      print("Error occurred: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFE6955)),
        backgroundColor: Colors.white,
        title: Text(
          'Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFE6955),
          ),
        ),
      ),
      body: product != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product["images"].length,
              itemBuilder: (context, index) {
                final image = product["images"][index];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      width: 200,
                        child: Image.network(
                          image.toString(),
                          fit: BoxFit.fill,
                        ),

                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product["title"].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          'Rating:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(product["rating"].toString()),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 20),
                          Expanded(
                            child: Text(
                              product["description"],
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Price:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '\$${product["price"].toString()}',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Discount Percentage',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '%${product["discountPercentage"].toString()}',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFE6955),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderConfirmation(selectedItem: product),
                ),
              );
            },
            child: Text(
              'Buy Now',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),


        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
