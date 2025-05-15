import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<dynamic> bucketlistData = [];
  Future<void> getData() async {
    try {
      Response response = await Dio().get(
        "https://flutterapitest123-e4e6a-default-rtdb.firebaseio.com/bucketlist.json",
      );

      bucketlistData = response.data;
      setState(() {});
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Cannot connect to the server Try after few seconds"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bucket List")),
      body: Column(
        children: [
          ElevatedButton(onPressed: getData, child: Text("Get data")),
          Expanded(
            child: ListView.builder(
              itemCount: bucketlistData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        bucketlistData[index]['image'] ?? "",
                      ),
                    ),
                    title: Text(bucketlistData[index]['item'] ?? ""),
                    trailing: Text(
                      bucketlistData[index]['cost'].toString() ?? "",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
