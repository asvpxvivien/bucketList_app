import 'package:flutter/material.dart';

class ViewItemScreen extends StatefulWidget {
  const ViewItemScreen({super.key});

  @override
  State<ViewItemScreen> createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Add Bucket List")));
  }
}
