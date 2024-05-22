import 'package:flutter/material.dart';
import 'package:arosaje_flutter/widgets/plante_widget.dart';
import 'package:arosaje_flutter/pages/ville_page.dart';
import 'package:arosaje_flutter/pages/message_page.dart';
import 'package:arosaje_flutter/header.dart'; // Importez le fichier contenant CustomHeader
import 'package:arosaje_flutter/pages/connexion_page.dart'; 
import 'package:arosaje_flutter/pages/inscription_page.dart'; 

class PlantesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomHeader(),
      ),
      body: Container(
        child: PlantesListWidget(),
      ),
    );
  }
}
