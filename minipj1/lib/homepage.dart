import 'package:flutter/material.dart';
import 'package:minipj1/orders.dart';

void main() => runApp(Homepage());

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Menu",
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderPage()));
              },
              icon: const Icon(Icons.shopping_cart),
              color: Colors.white),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Main Course'),
            onTap: () {
              Navigator.pushNamed(context, '/food');
            },
          ),
          ListTile(
            title: Text('Appetizers'),
            onTap: () {
              Navigator.pushNamed(context, '/appetizers');
            },
          ),
          ListTile(
            title: Text('Desserts'),
            onTap: () {
              Navigator.pushNamed(context, '/desserts');
            },
          ),
          ListTile(
            title: Text('Beverages'),
            onTap: () {
              Navigator.pushNamed(context, '/beverages');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/reviewpage');
        },
        child: Icon(Icons.comment_outlined),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
