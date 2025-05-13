import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  Future<void> getData() async {
    // Get data from the API

    Response response = await Dio().get(
      "https://flutterapitest123-e4e6a-default-rtdb.firebaseio.com/bucketlist.json",
    );
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bucket List")),
      body: ElevatedButton(onPressed: getData, child: Text("Get data")),
    );
  }
}
