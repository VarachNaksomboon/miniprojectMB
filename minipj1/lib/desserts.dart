import 'package:flutter/material.dart';
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:minipj1/main.dart';
import 'package:minipj1/orders.dart';

class MenuDetailPage extends StatelessWidget {
  final String menuItem;
  final int menuPrice;
  final String imageURL;

  MenuDetailPage({
    required this.menuItem,
    required this.menuPrice,
    required this.imageURL,
  });

  final GlobalKey<FormState> key = GlobalKey();
  final _form = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  final store = FirebaseFirestore.instance;

  DocumentReference get documentReference =>
      store.collection(user.email! + '_Personal').doc('user');

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
        ),
        body: Form(
            key: _form,
            child: ListView(children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.network(
                  imageURL,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    menuItem,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Price: \฿  $menuPrice',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Center(
                    child: ElevatedButton(
                  style: style,
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 12.0),
                        Text('Add to cart'),
                      ]),
                  onPressed: () async {
                    if (_form.currentState!.validate()) {
                      print('save button press');

                      Map<String, dynamic> data = {
                        'title': menuItem,
                        'price': menuPrice,
                        'image': imageURL
                      };

                      try {
                        DocumentReference ref =
                            await store.collection(user.email!).add(data);

                        print('save id = ${ref.id}');

                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error $e'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please validate value'),
                        ),
                      );
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(),
                      ),
                    );
                  },
                ))
              ]),
            ])));
  }

  void setState(Null Function() param0) {}
}

class DessertPage extends StatefulWidget {
  const DessertPage({Key? key}) : super(key: key);
  @override
  _DessertPageState createState() => _DessertPageState();
}

class _DessertPageState extends State<DessertPage> {
  final List<String> menuCategories = [
    '1',
  ];
  final Map<String, List<Map<String, dynamic>>> menuItems = {
    '1': [
      {
        'name': 'Brownie',
        'price': 85,
        'imageURL':
            'https://www.receitasnestle.com.br/sites/default/files/srh_recipes/bbff925842e3e2f4f698e004eeff4cc8.jpg',
      },
      {
        'name': 'Cake',
        'price': 65,
        'imageURL':
            'https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552__340.jpg',
      },
      {
        'name': 'Budino',
        'price': 120,
        'imageURL':
            'https://cdn.tasteatlas.com/Images/Dishes/b64aa30fdaef4e749f4f1eb99cc0ff36.jpg?mw=1300',
      },
      {
        'name': 'Fraisier',
        'price': 300,
        'imageURL':
            'https://cdn.tasteatlas.com/Images/Dishes/7ecaf44167d945f0ac64690b83292269.jpg?mw=1300',
      },
      {
        'name': 'Stracciatella',
        'price': 150,
        'imageURL':
            'https://cdn.tasteatlas.com/Images/Dishes/a335a79b8d78459aa06bfad000ef06aa.jpg?mw=1300',
      },
      {
        'name': 'Red Bean Bun',
        'price': 50,
        'imageURL':
            'https://mamaloli.com/wp-content/uploads/2012/01/anpan18.jpg',
      },
      {
        'name': 'Tanghulu — Candied Fruit on A Stick',
        'price': 120,
        'imageURL':
            'https://amiraspantry.com/wp-content/uploads/2021/02/tanghulu-recipe-I.jpg',
      },
      {
        'name': 'Dorayaki (Japanese Red Bean Pancake)',
        'price': 50,
        'imageURL':
            'https://www.justonecookbook.com/wp-content/uploads/2022/08/Japanese-Dorayaki-3716.jpg',
      },
      {
        'name': 'Delicious Dango Recipes',
        'price': 60,
        'imageURL':
            'https://simplyhomecooked.com/wp-content/uploads/2021/02/dango-recipe-2.jpg',
      },
      {
        'name': 'Honey Bread',
        'price': 150,
        'imageURL':
            'https://www.willflyforfood.net/wp-content/uploads/2023/01/korean-desserts-honey-bread.jpg.webp',
      },
      {
        'name': 'Bingsu',
        'price': 160,
        'imageURL':
            'https://www.willflyforfood.net/wp-content/uploads/2020/01/sulbing-cafe.jpg.webp',
      },
      {
        'name': 'Khao Niaow Ma Muang (Mango Sticky Rice)',
        'price': 75,
        'imageURL':
            'https://www.willflyforfood.net/wp-content/uploads/2022/06/thai-desserts-mango-sticky-rice.jpg.webp',
      },
      {
        'name': 'Bua Loi',
        'price': 60,
        'imageURL':
            'https://www.willflyforfood.net/wp-content/uploads/2022/06/thai-desserts-bua-loi.jpg.webp',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Menu',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Menu'),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OrderPage()));
                    },
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.white),
              ],
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            body: ListView.builder(
              itemCount: menuCategories.length,
              itemBuilder: (BuildContext context, int categoryIndex) {
                return Column(
                  children: menuItems[menuCategories[categoryIndex]]!
                      .map((menuItem) => ListTile(
                            title: Text(menuItem['name']),
                            subtitle: Text('\฿ ${menuItem['price']}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuDetailPage(
                                    menuItem: menuItem['name'],
                                    menuPrice: menuItem['price'],
                                    imageURL: menuItem['imageURL'],
                                  ),
                                ),
                              );
                            },
                          ))
                      .toList(),
                );
              },
            )));
  }
}
