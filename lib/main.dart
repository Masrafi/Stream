import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamHome(),
    );
  }
}

class StreamHome extends StatefulWidget {
  @override
  _StreamHomeState createState() => _StreamHomeState();
}

class _StreamHomeState extends State<StreamHome> {
  final StreamController _streamController = StreamController();

  addData() async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      _streamController.sink.add(i);
    }
  }

  Stream<int> numberStream() async* {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: StreamBuilder(
          stream: addData(),
          builder: (context, snapshop) {
            if (snapshop.hasError) {
              return Text("Hey there is some error");
            } else if (snapshop.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Text(
              "${snapshop.data}",
              style: Theme.of(context).textTheme.displayLarge,
            );
          },
        ),
      ),
    );
  }
}
