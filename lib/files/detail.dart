import 'package:flutter/material.dart';
import 'package:xweather/files/detail_body.dart';

class Detail extends StatefulWidget {
  late final info;
  Detail({required this.info});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: detailBody(widget.info),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.favorite_border_outlined),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
