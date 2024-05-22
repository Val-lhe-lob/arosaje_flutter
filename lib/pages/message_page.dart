import 'package:flutter/material.dart';
import 'package:arosaje_flutter/widgets/message_widget.dart';
import 'package:arosaje_flutter/pages/ville_page.dart';
import 'package:arosaje_flutter/header.dart';
import 'package:arosaje_flutter/pages/connexion_page.dart'; 
import 'package:arosaje_flutter/pages/inscription_page.dart'; 

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomHeader(),
      ),
      body: Container(
        child: MessagesListWidget(),
      ),
    );
  }
}
