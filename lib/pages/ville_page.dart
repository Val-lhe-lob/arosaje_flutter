import 'package:flutter/material.dart';
import 'package:arosaje_flutter/widgets/ville_widget.dart';
class VillesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Villes'),
      ),
      body: VillesListWidget(),
    );
  }
}