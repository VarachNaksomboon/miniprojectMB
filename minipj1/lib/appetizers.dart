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

class AppetizerPage extends StatefulWidget {
  const AppetizerPage({Key? key}) : super(key: key);
  @override
  _AppetizerPageState createState() => _AppetizerPageState();
}

class _AppetizerPageState extends State<AppetizerPage> {
  final List<String> menuCategories = [
    '1',
  ];
  final Map<String, List<Map<String, dynamic>>> menuItems = {
    '1': [
      {
        'name': 'Sticky Baked Chicken Wings',
        'price': 150,
        'ingredients': ['Chicken wings ', 'Fish sauce', 'Pepper'],
        'imageURL':
            'https://thegardeningcook.com/wp-content/uploads/2013/06/sticky-wings-main-image.jpg',
      },
      {
        'name': 'Brandade',
        'price': 120,
        'ingredients': [
          'Cods ',
          'Milks',
          'Thyme',
          'Olive Oils',
          'Potatoes',
          'Garlic',
          'Cayenne Pepper',
          'Lemons'
        ],
        'imageURL':
            'https://assets.bonappetit.com/photos/6374bca36cc47ec05a9b4582/1:1/w_1588,h_1588,c_limit/20221011%201222%20PEPIN%2012832.jpg',
      },
      {
        'name': 'Chinese Pork Potstickers',
        'price': 70,
        'ingredients': [
          'napa cabbage ',
          'salt',
          'lean ground pork',
          'chopped green onions',
          'white wine',
          'sesame oil',
          'freshly ground white pepper'
        ],
        'imageURL':
            'https://christieathome.com/wp-content/uploads/2021/04/Pork-Chive-Dumplings-updated-5-b.jpg',
      },
      {
        'name': 'Steamed BBQ Pork Buns',
        'price': 40,
        'ingredients': [
          'Roast pork',
          'Shallots',
          'Chicken stock',
          'Oyster sauce',
          'Soy sauce, light',
          'Soy sauce, dark',
          'Active dry yeast',
          'Baking powder',
          'Cornstarch',
          'cups Flour',
          'Sugar',
          'Canola or vegetable oil',
          'Oil',
          'Sesame oil',
          'Water'
        ],
        'imageURL':
            'https://www.katieinherkitchen.com/wp-content/uploads/2021/05/FullSizeRender-223-scaled-e1621610933168.jpg',
      },
      {
        'name': 'Sweet and spicy soy glazed edamame',
        'price': 90,
        'ingredients': [
          ' frozen edamame',
          'canola oil',
          'garlic',
          'fresh ginger',
          'soy sauce',
          'water',
          'rice vinegar',
          'brown sugar',
          'red pepper flakes'
        ],
        'imageURL':
            'https://farm9.staticflickr.com/8509/8428764571_91cace2547.jpg',
      },
      {
        'name': 'Tsukune (Japanese Chicken Meatballs)',
        'price': 50,
        'ingredients': [
          'ground chicken thigh',
          'Diamond Crystal kosher salt',
          'toasted sesame oil',
          'shallot, minced',
          'shiitake mushroom',
          'avocado oil',
          'All-Purpose Stir-Fry Sauce',
          'toasted sesame seeds '
        ],
        'imageURL':
            'https://i8b2m3d9.stackpathcdn.com/wp-content/uploads/2016/11/Tsukune_0450-731x1024.jpg',
      },
      {
        'name': 'KIMCHI PANCAKES',
        'price': 80,
        'ingredients': [
          'all-purpose flour',
          'water',
          'fine sea salt',
          'egg',
          ' kimchi',
          'kimchi liquid',
          ' ice cubes',
          'green chili',
          'red chili',
          'Some vegetable cooking oil',
          'Homemade Kimchi pancake  sauce '
        ],
        'imageURL':
            'https://food-images.files.bbci.co.uk/food/recipes/korean_kimchi_pancake_23271_16x9.jpg',
      },
      {
        'name': 'KOREAN BBQ CHICKPEAS',
        'price': 40,
        'ingredients': [
          'garbonzo (chickpeas) beans',
          'Korean BBQ sauce',
          'gochujang Korean hot pepper paste',
          'honey'
        ],
        'imageURL':
            'https://airfrywithme.com/wp-content/uploads/2020/05/Korean-BBQ-Chickpeas.jpg',
      },
      {
        'name': 'Kluai thot',
        'price': 50,
        'ingredients': [
          'Bananas',
          'Rice Flours',
          'Tapioca Flours',
          'Baking Soda',
          'Sesame Seeds',
          'Coconuts',
          'Salts',
          'Oils'
        ],
        'imageURL':
            'https://cdn.tasteatlas.com/images/dishes/864cc5e7036042d8bc373b214230821e.jpg?mw=1300',
      },
      {
        'name': 'Yam nuea yang',
        'price': 150,
        'ingredients': [
          'Beef',
          'Shallots',
          'Tomatoes',
          'Cucumbers',
          'Coriander',
          'Mint',
          'Basil',
          'Bird Eye Chili'
        ],
        'imageURL':
            'https://www.notesfromamessykitchen.com/wp-content/uploads/2017/03/IMG_20170327_200234.jpg',
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
                                    ingredients: menuItem['ingredients'],
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
