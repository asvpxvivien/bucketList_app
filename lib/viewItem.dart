import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ViewItemScreen extends StatefulWidget {
  String title;
  String image;
  int index;
  ViewItemScreen({
    super.key,
    required this.index,
    required this.title,
    required this.image,
  });

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    try {
      Response response = await Dio().delete(
        "https://flutterapitest123-e4e6a-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json",
      );
      Navigator.pop(context);
    } catch (e) {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 1) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Are you sure to delete?"),
                      actions: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        InkWell(onTap: deleteData, child: Text("Confirm")),
                      ],
                    );
                  },
                );
              }
              print(value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 1, child: Text("Delete")),
                PopupMenuItem(value: 2, child: Text("Mark as complete")),
              ];
            },
          ),
        ],
        title: Text("${widget.title}"),
      ),
      body: Column(
        children: [
          Text(widget.index.toString()),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
