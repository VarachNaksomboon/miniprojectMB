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
  final List<String> ingredients;
  final String imageURL;

  MenuDetailPage({
    required this.menuItem,
    required this.menuPrice,
    required this.ingredients,
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
          title: Text('Food Detail'),
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
                        'image': imageURL,
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

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final List<String> menuCategories = [
    'Western',
    'Chinese',
    'Japanese',
    'Korean',
    'Thai',
  ];
  final Map<String, List<Map<String, dynamic>>> menuItems = {
    'Western': [
      {
        'name': 'Fried Rice',
        'price': 50,
        'ingredients': ['rice', 'egg', 'soy sauce', 'vegetable oil'],
        'imageURL':
            'https://media.istockphoto.com/id/1175434591/photo/fried-rice-with-ketchup-and-soy-sauce.jpg?s=612x612&w=0&k=20&c=h4PypFpU_ktxXBGlw6P-K6t6WfDeJ6PMcCEXb7rwxqk=',
      },
      {
        'name': 'Spaghetti Carbonara',
        'price': 100,
        'ingredients': ['spaghetti', 'bacon', 'egg yolk', 'parmesan cheese'],
        'imageURL':
            'https://upload.wikimedia.org/wikipedia/commons/0/05/Classic-spaghetti-carbonara.jpg',
      },
    ],
    'Chinese': [
      {
        'name': 'Kung Pao Chicken',
        'price': 80,
        'ingredients': [
          'chicken breast',
          'peanuts',
          'soy sauce',
          'hoisin sauce',
          'cornstarch',
          'vegetable oil'
        ],
        'imageURL':
            'https://media.istockphoto.com/id/507124607/photo/homemade-kung-pao-chicken.jpg?s=612x612&w=0&k=20&c=agx6smvn5a7whsmfAMmK5M-e-68eKavqQl78zizf-lY=',
      },
      {
        'name': 'Hot and Sour Soup',
        'price': 60,
        'ingredients': [
          'tofu',
          'bamboo shoots',
          'soy sauce',
          'vinegar',
          'eggs'
        ],
        'imageURL':
            'https://masalachilli.com/wp-content/uploads/2021/07/Hot-and-Sour-Soup-3.jpg',
      },
    ],
    'Japanese': [
      {
        'name': 'Sushi',
        'price': 120,
        'ingredients': ['rice', 'nori', 'raw fish', 'soy sauce', 'wasabi'],
        'imageURL':
            'https://s.isanook.com/ca/0/rp/r/w728/ya0xa0m1w0/aHR0cHM6Ly9zLmlzYW5vb2suY29tL2NhLzAvdWQvMjc3LzEzODgzNDUvc3VzaGkuanBn.jpg',
      },
      {
        'name': 'Ramen',
        'price': 90,
        'ingredients': [
          'ramen noodles',
          'pork belly',
          'soy sauce',
          'miso paste',
          'green onions'
        ],
        'imageURL':
            'https://media.istockphoto.com/id/1365977387/photo/ramen-with-steaming-sizzle.jpg?b=1&s=170667a&w=0&k=20&c=8iOcgakOhguZ67D_dSUhMF5cAG_mgHBV8yiz1K74EFU=',
      },
    ],
    'Korean': [
      {
        'name': 'Bibimbap',
        'price': 70,
        'ingredients': [
          'rice',
          'beef',
          'spinach',
          'mung bean sprouts',
          'carrots',
          'egg'
        ],
        'imageURL':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Dolsot-bibimbap.jpg/1200px-Dolsot-bibimbap.jpg',
      },
      {
        'name': 'Kimchi Stew',
        'price': 110,
        'ingredients': ['kimchi', 'pork belly', 'tofu', 'green onions'],
        'imageURL':
            'https://www.cookerru.com/wp-content/uploads/2021/05/kimchi-stew-recipe-card.jpg',
      },
    ],
    'Thai': [
      {
        'name': 'Stir fried Thai basil with minced pork and a fried egg',
        'price': 75,
        'ingredients': [
          'ground pork',
          'basil leaves',
          'birds eye chili',
          'garlic',
          'soy sauce'
        ],
        'imageURL':
            'https://myformosafood.com/wp-content/uploads/2021/02/8.jpg',
      },
      {
        'name': 'Green Curry',
        'price': 95,
        'ingredients': [
          'chicken',
          'green curry paste',
          'coconut milk',
          'bamboo shoots',
          'eggplant'
        ],
        'imageURL':
            'https://hot-thai-kitchen.com/wp-content/uploads/2022/09/vegan-green-curry-sq-1.jpg',
      },
      {
        'name': 'Spicy Prawn Soup',
        'price': 85,
        'ingredients': ['prawns', 'lemongrass', 'galangal', 'lime leaves'],
        'imageURL':
            'https://img.freepik.com/free-photo/spicy-prawn-soup_74190-564.jpg?w=2000',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    menuCategories[categoryIndex],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Column(
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
                                    ingredients: menuItem['ingredients'],
                                    imageURL: menuItem['imageURL'],
                                  ),
                                ),
                              );
                            },
                          ))
                      .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
