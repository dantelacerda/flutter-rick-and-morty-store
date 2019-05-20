import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_morty_store/utils/alerts.dart';
import 'package:rick_morty_store/utils/constants.dart';

class ProductPage extends StatefulWidget {

  final param;
  final currentBalance;
  final price;
  final offerId;

  ProductPage({
    param, currentBalance, price, offerId
  }):
        this.param = param, this.currentBalance = currentBalance, this.price = price, this.offerId = offerId;

  _ProductPageState createState() => _ProductPageState(param, currentBalance, price, offerId);
}

class _ProductPageState extends State<ProductPage> {

  _ProductPageState(this.param, this.currentBalance, this.price, this.offerId);
  final param;
  final currentBalance;
  final price;
  final offerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(param['name'])),
      body: _body(context),
    );
  }

  _body(BuildContext context) {

    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Image.network(param['image']),
        _rowNameAndLike(),
        _columnCarDescription(),
        Container( child:_buyOffer(context, offerId)),
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  "${price.toString()} USD",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
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

  _buyOffer(BuildContext context, offerId) {

    String offer = """
  mutation MutationRoot {
    purchase(offerId: "$offerId") {
      success,
      errorMessage,
      customer {
        balance,
        name
      }
    }
  }
""";

    var m = Mutation(
      options: MutationOptions(
        document: offer, // this is the mutation string you just created
      ),


      builder: (
          RunMutation runMutation,
          QueryResult result,
          ) {

        return ButtonTheme.bar(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY'),
                onPressed: () => runMutation({
                        'starrableId': Constants.GRAPHQL_ENDPOINT,
              }),
              ),
            ],
          ),
        );
      },
      // you can update the cache based on results
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      // or do something with the result.data on completion
      onCompleted: (dynamic resultData) {
        verifyReturn(resultData['purchase']['errorMessage'], context);
      },
    );

    return m;
  }

  verifyReturn(String errorMessage, BuildContext context) {
    if(errorMessage == null) {
      alertWIthHomeButton(context, "Sucess", "Yay! You bought it!");
    } else if(errorMessage == Constants.OFFER_EXPIRED) {
      alertWIthHomeButton(context, "Offer Expired", "This offer has Expired!");
    } else if(errorMessage == Constants.NOT_ENOUGH_MONEY) {
      alertWIthHomeButton(context, "Insufficient Funds", Constants.NOT_ENOUGH_MONEY);
    }

  }
}
