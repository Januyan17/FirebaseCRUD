import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docid.get('title'));
    content = TextEditingController(text: widget.docid.get('content'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFB3551F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'title',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: TextField(
                  controller: content,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'content',
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Successfully Deleted",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Color.fromARGB(255, 84, 227, 201),
                          textColor: Colors.white);
                      widget.docid.reference.delete().whenComplete(() {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => Home()));
                      });
                    },
                    child: Text("Delete"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      widget.docid.reference.update({
                        'title': title.text,
                        'content': content.text,
                      }).whenComplete(() {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => Home()));
                      });
                    },
                    child: Text("Update"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
