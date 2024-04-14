import 'package:flutter/material.dart';


AppBar header(){
  
}

class Header extends StatelessWidget {
  final Function(String) onHeaderLinkTap;
  final VoidCallback? onProfileTap;

  const Header({
    required this.onHeaderLinkTap,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/image/logo.png',
            width: 50,
            height: 50,
          ),
          Row(
            children: [
              HeaderLink(
                text: 'Plantes',
                onPressed: () {
                  onHeaderLinkTap('Plantes');
                },
              ),
              SizedBox(width: 2),
              HeaderLink(
                text: 'Villes',
                onPressed: () {
                  onHeaderLinkTap('Villes');
                },
              ),
              SizedBox(width: 2),
              HeaderLink(
                text: 'Message',
                onPressed: () {
                  onHeaderLinkTap('Message');
                },
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: onProfileTap,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(2.0),
        child: Container(
          color: Colors.black,
          height: 1,
        ),
      ),
    );
  }
}

class HeaderLink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const HeaderLink({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

