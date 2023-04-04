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
                    'Price: \฿ $menuPrice',
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

class BeveragePage extends StatefulWidget {
  const BeveragePage({Key? key}) : super(key: key);
  @override
  _BeveragePageState createState() => _BeveragePageState();
}

class _BeveragePageState extends State<BeveragePage> {
  final List<String> menuCategories = [
    '1',
  ];
  final Map<String, List<Map<String, dynamic>>> menuItems = {
    '1': [
      {
        'name': 'Bottle of water',
        'price': 10,
        'imageURL':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSLg3eZC2sTj2F_06tK2NSrMGfYGDFTgxFTQ&usqp=CAU',
      },
      {
        'name': 'Soda',
        'price': 20,
        'imageURL':
            'https://cf.ltkcdn.net/best/images/std/182338-425x283r1-best-selling-sodas.jpg',
      },
      {
        'name': 'Vodka',
        'price': 90,
        'imageURL':
            'https://www.campoluzenoteca.com/979-big_default_2x/absolut-vodka.jpg',
      },
      {
        'name': 'Fog Cutter',
        'price': 120,
        'imageURL':
            'https://www.tasteatlas.com/images/ingredients/cabaf4e8a23d4f249e31a272b52f377c.jpg',
      },
      {
        'name': 'Apple Beer',
        'price': 70,
        'imageURL':
            'https://icdn.bottlenose.wine/images/full/437398.jpg?min-w=200&min-h=200&fit=crop',
      },
      {
        'name': 'California Common',
        'price': 70,
        'imageURL':
            'https://www.tasteatlas.com/images/ingredients/d5b6c4d54a3b4b1bb980fb9f96fa3329.jpg',
      },
      {
        'name': 'Xinjiang Black Beer',
        'price': 50,
        'imageURL':
            'https://heremag-prod-app-deps-s3heremagassets-bfie27mzpk03.s3.amazonaws.com/wp-content/uploads/2019/08/19130940/Miss-Ali_1655-800x1200.jpg',
      },
      {
        'name': 'Oolong Tea',
        'price': 50,
        'imageURL':
            'https://cdn.shopify.com/s/files/1/0044/0267/5761/articles/iStock-490736031_1445x.jpg?v=1623363656',
      },
      {
        'name': 'Matcha (Green Tea)',
        'price': 60,
        'imageURL':
            'https://gimmedelicious.com/wp-content/uploads/2018/03/Iced-Matcha-Latte2.jpg',
      },
      {
        'name': 'Nihonshu (Sake)',
        'price': 80,
        'imageURL':
            'https://www.nippon.com/en/ncommon/contents/guide-to-japan/1797/1797.jpg',
      },
      {
        'name': 'Soju ',
        'price': 130,
        'imageURL':
            'https://obs.line-scdn.net/r/ect/ect/image_164679737837871874519cb9233t0f644932',
      },
      {
        'name': 'Makgeolli',
        'price': 100,
        'imageURL':
            'https://justliquor.com.au/c/12-category_default/makgeolli.jpg',
      },
      {
        'name': 'Nom Yen',
        'price': 60,
        'imageURL':
            'https://localiseasia.com/wp-content/uploads/2021/10/Thai-pink-milk_featured.jpg',
      },
      {
        'name': 'Beer Chang',
        'price': 65,
        'imageURL':
            'https://www.thaibev.com/images2019/product/Beer/chang_beer.jpg',
      },
      {
        'name': 'Beer Leo',
        'price': 60,
        'imageURL':
            'https://www.brandbuffet.in.th/wp-content/uploads/2016/12/LEO.jpg',
      },
      {
        'name': 'HongThong',
        'price': 300,
        'imageURL':
            'https://www.thaibev.com/images2019/product/Spirit/hongthong.jpg',
      },
      {
        'name': 'สุราข้าวหอม',
        'price': 130,
        'imageURL':
            'https://pbs.twimg.com/media/DpzAoO4U0AAWHh0?format=jpg&name=large',
      },
    ],
    'Other': [
      {
        'name': 'Drinking water',
        'price': 50,
        'imageURL':
            'https://www.fmchealth.org/app/uploads/2021/06/Water-Drinking-725x484.jpg',
      },
      {
        'name': 'Soda',
        'price': 50,
        'imageURL':
            'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/91iFMPtXsIL.jpg',
      },
      {
        'name': 'Vorka',
        'price': 50,
        'imageURL':
            'http://f.ptcdn.info/546/003/000/1364321387-1absolutvo-o.jpg',
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
