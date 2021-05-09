import 'package:flutter/material.dart';
import 'package:rent_to_own_android_system/services/payment_service.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rent_to_own_android_system/widgets/app_drawer.dart';
// import './existing_card.dart';

class HomeePage extends StatefulWidget {
  static const routeName = '/user-creditcard';
  HomeePage({Key key}) : super(key: key);

  @override
  HomeePageState createState() => HomeePageState();
}

class HomeePageState extends State<HomeePage> {
  onItemPress(BuildContext context, int index) async {
    switch(index) {
      case 0:
        payViaNewCard(context);
        break;
      // case 1:
      //   Navigator.pushNamed(context, ExistingCardPage.routeName);
        
       
      //   break;
    }
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
      message: 'Please wait...'
    );
    await dialog.show();
    var response = await StripeService.payWithNewCard(
      amount: '15000',
      currency: 'USD'
    );
    await dialog.hide();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message),
        duration: new Duration(milliseconds: response.success == true ? 1200 : 3000),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
     
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Bail Payment'),
      ),
      
      // appBar: AppBar(
      //   title: const Text('Your Credit Card'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.add),
      //       onPressed: () {
      //         // Navigator.of(context).pushNamed(EditHouseScreen.routeName);
      //       },
      //     ),
      //   ],
      // ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
          itemBuilder: (context, index) {
            Icon icon;
            Text text;

            switch(index) {
              case 0:
                icon = Icon(Icons.add_circle, color: theme.primaryColor);
                text = Text('Pay');
                break;
              // case 1:
              //   icon = Icon(Icons.credit_card, color: theme.primaryColor);
              //   text = Text('Pay via existing card');
              //   break;
            }

            return InkWell(
              onTap: () {
                onItemPress(context, index);
              },
              child: ListTile(
                title: text,
                leading: icon,
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: theme.primaryColor,
          ),
          itemCount: 2
        ),
      ),
      
    );
  }
}
