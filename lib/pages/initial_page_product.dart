import 'package:flutter/material.dart';
import 'package:rick_morty_store/pages/drawer_list_lateral.dart';
import 'package:rick_morty_store/services/offers_service.dart';
import 'package:rick_morty_store/services/wallet_service.dart';
import 'package:rick_morty_store/utils/prefs.dart';

class InitialPageProduct extends StatefulWidget {
  @override
  _InitialPageProductState createState() => _InitialPageProductState();
}

class _InitialPageProductState extends State<InitialPageProduct>
    with SingleTickerProviderStateMixin<InitialPageProduct> {
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
        title: Text("Intergalatic Store!"),
        bottom: TabBar(controller: tabController, tabs: [
          Tab(text: "My Wallet", icon: Icon(Icons.info)),
          Tab(text: "Offers", icon: Icon(Icons.local_offer)),
        ]),
      ),

      body: TabBarView(controller: tabController, children: [
        _bodyWallet(context),
        _bodyOffers(context),
      ]),

        drawer: DrawerListLateral()

    );
  }


  _bodyOffers(BuildContext context) {
    return Container(child: OffersView(),);
  }

  _bodyWallet(BuildContext context) {
    return Container(child: WalletView(),);
  }

}
