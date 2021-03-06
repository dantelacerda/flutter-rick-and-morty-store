import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_morty_store/pages/product_page.dart';
import 'package:rick_morty_store/utils/nav.dart';

class OffersView extends StatefulWidget {
  @override
  _OffersViewState createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  @override
  Widget build(BuildContext context) {
    return offers_view();
  }
}


offers_view() {
  String readRepositories = """
  query ReadRepositories {
    viewer {
    balance,
    id
    offers {
      id,
      price,
     
			product {
        id,
        name,
        description,
        image,
        
      }
    }
  }
  }
""";

  var r = Query(
    options: QueryOptions(
      document: readRepositories, // this is the query string you just created
      variables: {
        'nRepositories': 50,
      },
      pollInterval: 10,
    ),
    builder: (QueryResult result, {VoidCallback refetch}) {
      if (result.errors != null) {
        return Text(result.errors.toString());
      }

      if (result.loading) {
        return Text('Loading');
      }
      List repositories = result.data['viewer']['offers'];


      var currentBalance = result.data['viewer']['balance'];

      return ListView.builder(
          itemCount: repositories.length,
          itemBuilder: (context, index) {
            final repository = repositories[index];

            return _cardOffers(repository, currentBalance, context);
          });
    },
  );

  return r;
}

Card _cardOffers(repository, currentBalance, BuildContext context) {
  return Card(
            child: InkWell(
              onTap: () {
                _onClickDetails(context,
                    repository['product'], currentBalance, repository['price'], repository['id']);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Image.network(repository['product']['image'])),

                    _rowNameAndPrice(repository, currentBalance),

                    //BOTOES EM BAIXO DOS PRODUTOS
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETAILS'),
                            onPressed: () {
                              _onClickDetails(context,
                                  repository['product'], currentBalance, repository['price'], repository['id']);
                            },
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
}

Row _rowNameAndPrice(repository, currentBalance) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              repository['product']['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
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
                "${repository['price'].toString()} USD",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: currentBalance < repository['price'] ? Colors.red : Colors.black,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: currentBalance < repository['price'] ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

void _onClickDetails(BuildContext context, product, currentBalance, price, offerId) {
  push(context, ProductPage(param: product, currentBalance: currentBalance, price: price, offerId: offerId));
}


