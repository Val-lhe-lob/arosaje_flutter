import 'package:flutter/material.dart';
import 'package:arosaje_flutter/widgets/message_widget.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MessagesListWidget(),
    );
  }
}
