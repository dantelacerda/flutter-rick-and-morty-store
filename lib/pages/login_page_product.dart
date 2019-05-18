import 'package:flutter/material.dart';
import 'package:rick_morty_store/services/offers_service.dart';
import 'package:rick_morty_store/services/wallet_service.dart';
import 'package:rick_morty_store/utils/prefs.dart';

class LoginPageProduct extends StatefulWidget {
  @override
  _LoginPageProductState createState() => _LoginPageProductState();
}

class _LoginPageProductState extends State<LoginPageProduct>
    with SingleTickerProviderStateMixin<LoginPageProduct> {
  TabController tabController;

  @override
  initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);

    Prefs.getInt("tabIndex").then((idx) {
      tabController.index = idx;
    });


    tabController.addListener(() async {
      int idx = tabController.index;

      Prefs.setInt("tabIndex", idx);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account!"),
        bottom: TabBar(controller: tabController, tabs: [
          Tab(text: "My Wallet", icon: Icon(Icons.info)),
          Tab(text: "Offers", icon: Icon(Icons.local_offer)),
        ]),
      ),

      body: TabBarView(controller: tabController, children: [
        _bodyWallet(context),
        _bodyOffers(context),
      ]),

    );
  }


  _bodyOffers(BuildContext context) {
    return Container(child: OffersView(),);
  }

  _bodyWallet(BuildContext context) {
    return Container(child: WalletView(),);
  }

}
