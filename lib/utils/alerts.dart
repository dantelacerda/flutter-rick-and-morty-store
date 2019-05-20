import 'package:flutter/material.dart';
import 'package:rick_morty_store/pages/initial_page_product.dart';
import 'package:rick_morty_store/utils/nav.dart';

alert(BuildContext context, String title, String msg) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

alertWIthHomeButton(BuildContext context, String title, String msg) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                push(context, InitialPageProduct());
              },
            )
          ],
        );
      });
}
