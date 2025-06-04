import 'package:bucketlist/add_bucketList.dart';
import 'package:bucketlist/viewItem.dart';
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
  bool isError = false;
  Future<void> getData() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      Response response = await Dio().get(
        "https://flutterapitest123-e4e6a-default-rtdb.firebaseio.com/bucketlist.json",
      );

      if (response.data is List) {
        bucketlistData = response.data;
      } else {
        bucketlistData = [];
      }
      isLoading = false;
      isError = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget errorWidget({required String errorText}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text(errorText),
          ElevatedButton(onPressed: getData, child: Text("Try again")),
        ],
      ),
    );
  }

  Widget ListDataWidget() {
    List<dynamic> filteredList =
        bucketlistData
            .where((element) => !(element?["completed"] ?? false))
            .toList();

    return filteredList.length < 1
        ? Center(child: Text("No data on the bucket list"))
        : ListView.builder(
          itemCount: bucketlistData.length,
          itemBuilder: (BuildContext context, int index) {
            return (bucketlistData[index] is Map &&
                    (!(bucketlistData[index]?["completed"] ?? false)))
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ViewItemScreen(
                              index: index,
                              title: bucketlistData[index]['item'] ?? "",
                              image: bucketlistData[index]['image'] ?? "",
                            );
                          },
                        ),
                      ).then((value) {
                        if (value == "refresh") {
                          getData();
                        }
                      });
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        bucketlistData[index]?['image'] ?? "",
                      ),
                    ),
                    title: Text(bucketlistData[index]?['item'] ?? ""),
                    trailing: Text(
                      bucketlistData[index]?['cost'].toString() ?? "",
                    ),
                  ),
                )
                : SizedBox();
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddBucketListScreen(newIndex: bucketlistData.length);
              },
            ),
          ).then((value) {
            if (value == "refresh") {
              getData();
            }
          });
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),

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
                : isError
                ? errorWidget(errorText: "Error connecting ...")
                : ListDataWidget(),
      ),
    );
  }
}
