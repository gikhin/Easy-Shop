import 'package:ecommerce/Homepage.dart';
import 'package:flutter/material.dart';

class TrackingPage extends StatefulWidget {
  final List<dynamic> selectedItem;

  const TrackingPage({Key? key, required this.selectedItem}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFE6955)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Tracking Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFE6955),
          ),
        ),
        leading: Icon(
          Icons.local_shipping, // Use the truck icon
          color: Color(0xFFFE6955),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.selectedItem[0]["images"].length,
              itemBuilder: (context, index) {
                final image = widget.selectedItem[0]["images"][index];
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
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedItem.length,
              itemBuilder: (context, index) {
                final trackingId = widget.selectedItem[index]['id'];
                final orderNo = widget.selectedItem[index]['stock'];
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    Text(
                      'Tracking ID: $trackingId',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Order No: $orderNo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Status: On the way',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
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
                                  builder: (context) => Homescreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
