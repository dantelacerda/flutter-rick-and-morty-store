import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class WalletView extends StatefulWidget {
  @override
  _WalletViewState createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {

  var currentBalance = 0;
  @override
  Widget build(BuildContext context) {
    return wallet_view();
  }
}


wallet_view() {
  String readRepositories = """
  query ReadRepositories {
    viewer {
    balance,
    name,
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
    // Just like in apollo refetch() could be used to manually trigger a refetch
    builder: (QueryResult result, {VoidCallback refetch}) {
      if (result.errors != null) {
        return Text(result.errors.toString());
      }

      if (result.loading) {
        return Text('Loading');
      }
      var repository = result.data['viewer'];


      return _cardMyWallet(repository);
    },
  );

  return r;
}

Card _cardMyWallet(repository) {
  return Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Image.network("https://www.pngkit.com/png/detail/5-53762_jerry-jerry-smith-rick-and-morty-png.png"),
                ),
                Card(child: _rowName(repository)),
                Card(child: _rowBalance(repository))

              ],
            ),
          ),
        ),
      );
}

Row _rowName(repository) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              repository['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    ],
  );
}

_rowBalance(repository) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Current Schmeckles: ${repository['balance'].toString()}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    ],
  );
}

actual_currency() {
  String readRepositories = """
  query ReadRepositories {
    viewer {
    balance,
    name,
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
    // Just like in apollo refetch() could be used to manually trigger a refetch
    builder: (QueryResult result, {VoidCallback refetch}) {
      if (result.errors != null) {
        return Text(result.errors.toString());
      }

      if (result.loading) {
        return Text('Loading');
      }
      var repository = result.data['viewer'];
      return _drawerBalance(repository);
    },
  );

  return r;
}

Padding _drawerBalance(repository) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Schmeckles: ${repository['balance']}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}

