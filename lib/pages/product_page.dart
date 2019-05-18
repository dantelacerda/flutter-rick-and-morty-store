import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {

  final param;
  ProductPage({
    param
  }): this.param = param;

  _ProductPageState createState() => _ProductPageState(param);
}

class _ProductPageState extends State<ProductPage> {

  _ProductPageState(this.param);
  final param;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(param['name'])),
      body: _body(),
    );
  }

  _body() {

    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Image.network(param['image']),
        _rowNameAndLike(),
        _columnCarDescription(),
        ButtonTheme.bar(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY'),
                onPressed: () {
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _rowNameAndLike() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                param['name'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }

  _columnCarDescription() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            param['description'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

}
