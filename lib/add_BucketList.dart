import 'package:flutter/material.dart';

class AddBucketListScreen extends StatefulWidget {
  const AddBucketListScreen({super.key});

  @override
  State<AddBucketListScreen> createState() => _AddBucketListScreenState();
}

class _AddBucketListScreenState extends State<AddBucketListScreen> {
  Future<void> markAsComplete() async {
    try {
      Map<String, dynamic> data = {"completed": true};
      Response response = await Dio().patch(
        "https://flutterapitest123-e4e6a-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json",
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
      body: ElevatedButton(onPressed: () {}, child: Text("Add data")),
    );
  }
}
