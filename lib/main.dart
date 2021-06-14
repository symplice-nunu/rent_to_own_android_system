import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_to_own_android_system/screens/homee.dart';
import './screens/splash_screen.dart';
import 'screens/houses_overview_screen.dart';
import 'screens/house_detail_screen.dart';
import 'providers/houses.dart';
import './providers/auth.dart';
import 'screens/user_houses_screen.dart';
import 'screens/user_rentagreement_screen.dart';
import 'screens/edit_house_screen.dart';
import 'screens/edit_rentagreement_screen.dart';
import './screens/auth_screen.dart';
import './helpers/custom_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Houses>(
          // ignore: deprecated_member_use
          builder: (ctx, auth, previousHouses) => Houses(
            auth.token,
            auth.userId,
            previousHouses == null ? [] : previousHouses.items,
            previousHouses == null ? [] : previousHouses.itemsa,
          ),
        ),
        // ChangeNotifierProvider.value(
        //   value: Cart(),
        // ),
        // ignore: missing_required_param
        // ChangeNotifierProxyProvider<Auth, Orders>(
        //   // ignore: deprecated_member_use
        //   builder: (ctx, auth, previousOrders) => Orders(
        //     auth.token,
        //     auth.userId,
        //     previousOrders == null ? [] : previousOrders.orders,
        //   ),
        // ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Rent To Own Android System',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          home: auth.isAuth
              ? HousesOverviewScreen()
              : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
            authResultSnapshot.connectionState ==
                ConnectionState.waiting
                ? SplashScreen()
                : AuthScreen(),
          ),
          routes: {
            HouseDetailScreen.routeName: (ctx) => HouseDetailScreen(),
            UserHousesScreen.routeName: (ctx) => UserHousesScreen(),
            UserRentAgreementScreen.routeName: (ctx) => UserRentAgreementScreen(),
            EditHouseScreen.routeName: (ctx) => EditHouseScreen(),
            EditRentAgreementScreen.routeName: (ctx) => EditRentAgreementScreen(),
            HomeePage.routeName: (ctx) => HomeePage(),
          },
        ),
      ),
    );
  }
}
