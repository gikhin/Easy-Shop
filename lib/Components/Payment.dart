import 'dart:convert';

import 'package:ecommerce/Components/Trackingpage.dart';
import 'package:ecommerce/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  final List<dynamic> items;

  const Payment({Key? key, required this.items}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late String selectedPaymentMethod;
  dynamic product;

  @override
  void initState() {
    selectedPaymentMethod = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> items = widget.items;

    double totalPrice = 0;
    for (var item in items) {
      totalPrice += item['price'];
    }

    return MaterialApp(
      title: 'Payment Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Payment Page",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFFE6955),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 30),
                Text(
                  'Select Payment Method',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Card(
                  child: ListTile(
                    trailing: ElevatedButton(
                      onPressed: () {
                        selectPaymentMethod('PayPal');
                      },
                      child: Text('PayPal'),
                    ),
                    title: Text('PayPal'),
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: Image.network(
                          'https://9to5mac.com/wp-content/uploads/sites/6/2019/03/paypal-logo.jpeg?quality=82&strip=all'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  child: ListTile(
                    trailing: ElevatedButton(
                      onPressed: () {
                        selectPaymentMethod('Google Pay');
                      },
                      child: Text('Google Pay'),
                    ),
                    title: Text('Google Pay'),
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: Image.network(
                          'https://lh3.googleusercontent.com/lfSN8-0uxLdHSqBD9ULaZUiBRJ_9lCKK8Jq'
                              'HGWhdgy4WjGJNYQtQ5hPbw2RBCBfEABPTqljEVA4J2J3Pr-emxqnIZu16WIt41CE7Mg'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  child: ListTile(
                    trailing: ElevatedButton(
                      onPressed: () {
                        selectPaymentMethod('Debit Card');
                      },
                      child: Text('Debit Card'),
                    ),
                    title: Text('Debit Card'),
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: Image.network(
                          'https://www.visa.com.vc/dam/VCOM/regional/lac/ENG/Default/Pay%20With%20Visa/Find%20a%20Card/'
                              'Debit%20Cards/Visa%20Debit%20Gold/visagolddebit-400x225.jpg'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  child: ListTile(
                    trailing: ElevatedButton(
                      onPressed: () {
                        selectPaymentMethod('Cash on Delivery');
                      },
                      child: Text('Cash on Delivery'),
                    ),
                    title: Text('Cash On Delivery'),
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: Image.network(
                          'https://4.imimg.com/data4/RC/YR/MY-8877598/cash-on-delivery-services-500x500.jpg'),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Selected Payment Method: $selectedPaymentMethod',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (items != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Pay:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '\$$totalPrice',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                height: 45,
                width: 330,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFE6955),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrackingPage(selectedItem: widget.items,)));
                    },
                    child: Text(
                      'Track Your Order',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }
}
