import 'package:flutter/material.dart';
import 'package:rick_morty_store/services/wallet_service.dart';

class DrawerListLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: 250,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Jerry Smith"),
                accountEmail: Text("jerrylovesbetty@rick.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://www.pngkit.com/png/detail/5-53762_jerry-jerry-smith-rick-and-morty-png.png"),
                  backgroundColor: Colors.white70,
                ),
              ),
              actual_currency(),
            ],
          )
      ),
    );
  }
}
