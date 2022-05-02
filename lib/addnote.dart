import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

class addnote extends StatefulWidget {
  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 179, 85, 31)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: 'title',
                      focusedBorder: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Required';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextFormField(
                    controller: content,
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'content',
                      focusedBorder: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Required';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    if (title.text == "" && content.text == "") {
                      Fluttertoast.showToast(
                          msg: "Please Provide Valid data",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color.fromARGB(255, 84, 227, 201),
                          textColor: Colors.white);
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Submiting')),
                        );
                      }
                    } else {
                      ref.add({
                        'title': title.text,
                        'content': content.text,
                      }).whenComplete(() {
                        Fluttertoast.showToast(
                            msg: "Data Saved",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Color.fromARGB(255, 84, 227, 201),
                            textColor: Colors.white);
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => Home()));
                      });
                    }
                  },
                  child: Text("Add"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
