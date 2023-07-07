import 'package:flutter/material.dart';

import 'Ordercon.dart';

class Cart extends StatefulWidget {
  final List<dynamic> cartItems;
  final Function(int) onCartItemRemoved;

  const Cart({
    Key? key,
    required this.cartItems,
    required this.onCartItemRemoved,
  }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<dynamic> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _cartItems = List.from(widget.cartItems);
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    widget.onCartItemRemoved(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFE6955)),
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFE6955),
          ),
        ),
      ),
      body: _cartItems.isEmpty
          ? Center(
        child: Text(
          'Cart is empty',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ):ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          final product = _cartItems[index];
          return Column(
            children: [
              SizedBox(height: 16),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 250,
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        child: Image.network(product["thumbnail"]),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product["brand"],
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
                          Text('4.5'),
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
                                    '\$${product["price"].toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _removeItem(index);
                                    },
                                    icon: Icon(Icons.delete_rounded),
                                    color: Color(0xFFFE6955),
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
                                    'Discount Percentage:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${product["discountPercentage"].toString()}%',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderConfirmation(
                        selectedItem: _cartItems[index],
                      ),
                    ),
                  ).then((value) {
                    // Remove the selected item from the cart
                    _removeItem(index);
                  });
                },
                child: Text(
                  'Order Now',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}
