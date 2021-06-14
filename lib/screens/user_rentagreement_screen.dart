import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/houses.dart';
import '../widgets/user_rentagreement_item.dart';
import '../widgets/app_drawer.dart';
import 'edit_rentagreement_screen.dart';

class UserRentAgreementScreen extends StatelessWidget {
  static const routeName = '/user-rentagreement';

  Future<void> _refreshAgreement(BuildContext context) async {
    await Provider.of<Houses>(context, listen: false)
        .fetchAndRentAgreement(true);
  }

  

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    print('rebuilding...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Rent Agreement'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditRentAgreementScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshAgreement(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshAgreement(context),
                    child: Consumer<Houses>(
                      builder: (ctx, agreementData, _) => Padding(
                            padding: EdgeInsets.all(8),
                            child: ListView.builder(
                              itemCount: agreementData.itemsa.length,
                              itemBuilder: (_, i) => Column(
                                    children: [
                                      UserRentAgreementItem(
                                        agreementData.itemsa[i].id,
                                        agreementData.itemsa[i].rentername,
                                        agreementData.itemsa[i].houseno,
                                        agreementData.itemsa[i].date,
                                      ),
                                      Divider(),
                                    ],
                                  ),
                            ),
                          ),
                    ),
                  ),
      ),
    );
  }
}
