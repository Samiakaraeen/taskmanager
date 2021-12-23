import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:taskmanager/addedittask.dart';

class Task extends StatefulWidget {
  Task({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TextEditingController sami = TextEditingController();
  late List<Item> items = [];
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff03dac6),
            foregroundColor: Colors.black,
            onPressed: () {
              cardKey.currentState!.toggleCard();
              // Respond to button press
            },
            child: Icon(Icons.add),
          ),
          body: FlipCard(
            direction: FlipDirection.VERTICAL,
            key: cardKey,
            flipOnTouch: false,
            front: Column(
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
                        child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              var item = items[index];
                              return Slidable(
                                key: ValueKey(index),
                                startActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: const ScrollMotion(),

                                  // A pane can dismiss the Slidable.

                                  // All actions are defined in the children parameter.
                                  children: const [
                                    // A SlidableAction can have an icon and/or a label.
                                    SlidableAction(
                                      onPressed: null,
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: null,
                                      backgroundColor: Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.share,
                                      label: 'Share',
                                    ),
                                  ],
                                ),
                                endActionPane: const ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      // An action can be bigger than the others.
                                      flex: 2,
                                      onPressed: null,
                                      backgroundColor: Color(0xFF7BC043),
                                      foregroundColor: Colors.white,
                                      icon: Icons.archive,
                                      label: 'Archive',
                                    ),
                                    SlidableAction(
                                      onPressed: null,
                                      backgroundColor: Color(0xFF0392CF),
                                      foregroundColor: Colors.white,
                                      icon: Icons.save,
                                      label: 'Save',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                    contentPadding: EdgeInsets.all(10.0),
                                    leading: Text(item.title.toString()),
                                    subtitle: Text(item.content.toString()),
                                    title: Text(DateTime.now().toString())),
                              );
                            })))
              ],
            ),
            back: addEditTask(
              cardKey: cardKey,
              items: items,
            ),
            onFlip: () {
              setState(() {});
            },
          )),
    );
  }
}

class Item {
  String? title;
  String? content;
  Item({this.title, this.content});
}
