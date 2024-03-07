import 'package:arosaje_flutter/widgets/ville_widget.dart';
import 'package:flutter/material.dart';
import 'package:arosaje_flutter/pages/plante_page.dart';
import 'package:arosaje_flutter/header.dart'; // Import the header widget

class VillesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Header(
          onHeaderLinkTap: (String text) {
            if (text == 'Plantes') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlantesPage()),
              );
            } else if (text == 'Villes') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VillesPage()),
              );
            } else if (text == 'Message') {
              // Add your logic for the "Message" link here.
            }
          },
        ),
      ),
      body: Container(
        child: VillesListWidget(),
      ),
    );
  }
}