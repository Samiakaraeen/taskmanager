import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/io_client.dart';
import 'package:taskmanager/addedittask.dart';
import 'package:taskmanager/global.dart';

class Task extends StatefulWidget {
  Task({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Item>? items = [];
  Item it = new Item();
  @override
  void initState() {
    super.initState();

    get();
  }

  void get() async {
    items = await fetchProducts();
    setState(() {});
  }

  Future<List<Item>?> fetchProducts() async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var response;

    response = await http.get(Uri.parse("https://localhost:44390/api/task"));

    Item i = new Item();
    if (response.statusCode == 200) {
      List<Item>? items = i.parseProducts(response.body);
      try {
        //  pd.close();
      } catch (x) {}

      return items;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  bool saveorupdate = false;
  TextEditingController sami = TextEditingController();

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            it = new Item();
            it.id = -1;
            it.content = '';
            it.title = '';

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      addEditTask(items: items, savedorupdate: false, itm: it)),
            );
            // Respond to button press
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.red,
                      child: // Image.network(
                          // 'https://natureconservancy-h.assetsadobe.com/is/image/content/dam/tnc/nature/en/photos/Zugpsitze_mountain.jpg?crop=0,176,3008,1654&wid=4000&hei=2200&scl=0.752',
                          //  fit: BoxFit.fill)),
                          Image.asset('images/l.jpg', fit: BoxFit.fill)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: sami,
                          decoration: InputDecoration(
                            hintText: 'Enter Search key...',
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
                      )),
                      Container(
                          width: 50,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                            label: Text(''),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.only(
                                  left: 10, right: 5, top: 12, bottom: 10),
                            ),
                          ))
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                      ))
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.amber,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(globals.docid)
                      .collection("tasks")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: (snapshot.data!).docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = (snapshot.data!).docs[index];
                          return ListTile(
                              contentPadding: EdgeInsets.all(10.0),
                              leading:
                                  Text('Id:' + doc.id + ':' + doc['title']),
                              subtitle: Text(doc['desc']),
                              title: Text(DateTime.now().toString()));
                        });
                  }),
            ))
          ],
        ),
      ),
    );
  }
}

class Item {
  int? id;
  String? title;
  String? content;
  Item({this.id, this.title, this.content});

  Map toJson() {
    return {'id': id, 'title': title, 'description': content};
  }

  List<Item>? parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Item>((json) => Item.fromJson(json)).toList();
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'].toString(),
      content: json['description'].toString(),
    ); //json['discount'].toDouble());
  }
}
