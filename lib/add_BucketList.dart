import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddBucketListScreen extends StatefulWidget {
  int newIndex;
  AddBucketListScreen({super.key, required this.newIndex});

  @override
  State<AddBucketListScreen> createState() => _AddBucketListScreenState();
}

class _AddBucketListScreenState extends State<AddBucketListScreen> {
  Future<void> addData() async {
    try {
      Map<String, dynamic> data = {
        "item": "visit Nepal",
        "cost": 2000,
        "image":
            "https://www.travels2nepal.com/images/tour/nepal-tour-packages/nepal-tour-packages1.jpg",
        "completed": false,
      };

      Response response = await Dio().patch(
        "https://flutterapitest123-e4e6a-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json",
        data: data,
      );
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Bucket List")),
      body: ElevatedButton(onPressed: addData, child: Text("Add data")),
    );
  }
}
