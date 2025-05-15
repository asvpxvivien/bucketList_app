import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<dynamic> bucketlistData = [];
  bool isLoading = false;
  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await Dio().get(
        "https://flutterapitest123-e4e6a-default-rtdb.firebaseio.com/bucketlist.json",
      );

      bucketlistData = response.data;
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
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
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bucket List"),
        actions: [
          InkWell(
            onTap: getData,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getData();
        },
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
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
    );
  }
}
