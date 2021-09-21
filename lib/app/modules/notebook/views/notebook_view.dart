import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notebook_controller.dart';

class NotebookView extends GetView<NotebookController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotebookView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotebookView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
