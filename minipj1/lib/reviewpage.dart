import 'dart:io';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:image_picker/image_picker.dart';

class ReviewPage extends StatelessWidget {
  final store = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser!;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.collection('UserReviews').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Review"),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddReviewPage()));
                  },
                  icon: const Icon(Icons.border_color),
                  color: Colors.white),
            ],
          ),
          body: snapshot.hasData
              ? buildFavoritesList(snapshot.data!)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  ListView buildFavoritesList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.size,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);

        return ListTile(
          leading: Image.network(model['imageUrl']!),
          title: Text(model['title_reviews']),
          subtitle: Text(model['comment']),
          onTap: () {},
          trailing: IconButton(
            onPressed: () {
              deleteValue(model.id);
            },
            icon: Icon(Icons.delete_outlined),
          ),
        );
      },
    );
  }

  Future<void> deleteValue(String titleName) async {
    await _firestore
        .collection('UserReviews')
        .doc(titleName)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}

class AddReviewPage extends StatefulWidget {
  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';

  String _comment = '';

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Write a review'),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showImagePicker();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: _image == null
                      ? Icon(Icons.camera_alt_outlined)
                      : Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }

                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a comment';
                  }

                  return null;
                },
                onSaved: (value) {
                  _comment = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(),
            ],
          ),
        )));
  }

  ElevatedButton RaisedButton() {
    return ElevatedButton(
      onPressed: () {
        _submitForm();
      },
      child: Text('Post'),
    );
  }

  ElevatedButton FlatButtonCamera(ImagePicker picker) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.of(context).pop(await picker.pickImage(
          source: ImageSource.camera,
        ));
      },
      child: Text('Camera'),
    );
  }

  ElevatedButton FlatButtonGallery(ImagePicker picker) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.of(context).pop(await picker.pickImage(
          source: ImageSource.gallery,
        ));
      },
      child: Text('Gallery'),
    );
  }

  Future<void> _showImagePicker() async {
    final picker = ImagePicker();

    final pickedFile = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select image source'),
        actions: [
          FlatButtonCamera(picker),
          FlatButtonGallery(picker),
        ],
      ),
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() == false) {
      // handle validation error
    }

    _formKey.currentState?.save();

    final ref = FirebaseStorage.instance
        .ref()
        .child('UserReviews')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    final uploadTask = ref.putFile(_image!);

    final snapshot = await uploadTask.whenComplete(() {});

    final imageUrl = await snapshot.ref.getDownloadURL();

    final reviewData = {
      'title_reviews': _title,
      'comment': _comment,
      'imageUrl': imageUrl,
      'createdAt': DateTime.now(),
    };

    await FirebaseFirestore.instance.collection('UserReviews').add(reviewData);

    Navigator.of(context).pop();
  }
}
