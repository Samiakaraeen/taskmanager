import 'dart:io';

import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:taskmanager/camera.dart';
import 'package:taskmanager/task.dart';

class addEditTask extends StatefulWidget {
  final List<Item>? items;

  final bool? savedorupdate;
  final Item? itm;
  addEditTask({Key? key, this.items, this.savedorupdate, this.itm})
      : super(key: key);

  @override
  _addEditTaskState createState() => _addEditTaskState();
}

class _addEditTaskState extends State<addEditTask> {
  TextEditingController txtbody = new TextEditingController();
  TextEditingController txttitle = new TextEditingController();
  late FocusNode focus;
  @override
  void initState() {
    super.initState();
    txtbody.text = widget.itm!.content.toString();
    txttitle.text = widget.itm!.title.toString();
    focus = new FocusNode();
  }

  int? val = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onScaleEnd: (details) {
          // txtbody.clear();
          //  setState(() {});
        },
        onHorizontalDragEnd: (d) {
          Navigator.pop(context);
        },
        child: Scaffold(
          body: ListView(
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: txttitle,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Task Title',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 6.0), //Same as `blurRadius` i guess
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),

                  height: 50,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.camera,
                            size: 20.0,
                          ),
                          label: Text(''),
                          onPressed: () async {
                            final cameras = await availableCameras();

                            // Get a specific camera from the lis\t of available cameras.
                            final firstCamera = cameras.first;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TakePictureScreen(
                                        camera: firstCamera,
                                      )),
                            );
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.attach_email,
                            size: 20.0,
                          ),
                          label: Text(''),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.emoji_emotions,
                            size: 20.0,
                          ),
                          label: Text(''),
                          onPressed: () {},
                        ),
                        Expanded(
                            child: Container(
                          color: Colors.amber,
                        )),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.emoji_emotions,
                            size: 20.0,
                          ),
                          label: Text(''),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      TextField(
                        focusNode: focus,
                        maxLength: 200,
                        onChanged: (z) {
                          setState(() {});
                        },
                        controller: txtbody,
                        textAlignVertical: TextAlignVertical.top,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Task Body',
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                txtbody.clear();
                                focus.requestFocus();
                              },
                              icon: Icon(Icons.clear))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Priority'),
              ),
              Container(
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('1'),
                    Radio(
                      value: 1,
                      onChanged: (value) {
                        setState(() {
                          val = value as int?;
                        });
                      },
                      activeColor: Colors.green,
                      groupValue: val,
                    ),
                    Text('2'),
                    Radio(
                      value: 2,
                      onChanged: (value) {
                        setState(() {
                          val = value as int?;
                        });
                      },
                      activeColor: Colors.green,
                      groupValue: val,
                    ),
                    Text('3'),
                    Radio(
                      value: 3,
                      onChanged: (value) {
                        setState(() {
                          val = value as int?;
                        });
                      },
                      activeColor: Colors.green,
                      groupValue: val,
                    ),
                    Text('4'),
                    Radio(
                      value: 4,
                      onChanged: (value) {
                        setState(() {
                          val = value as int?;
                        });
                      },
                      activeColor: Colors.green,
                      groupValue: val,
                    ),
                    Text('5'),
                    Radio(
                      value: 5,
                      onChanged: (value) {
                        setState(() {
                          val = value as int?;
                        });
                      },
                      activeColor: Colors.green,
                      groupValue: val,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.itm!.id = widget.items!.length;
                        widget.itm!.content = txtbody.text;
                        widget.itm!.title = txttitle.text;
                        if (widget.savedorupdate == false) {
                          widget.items!.add(widget.itm!);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Task(items: widget.items!)),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: Text('Save'),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: Text('Clear'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
