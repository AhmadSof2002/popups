import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pop_up_ads/components/constants.dart';
import 'package:pop_up_ads/cubit/cubit.dart';
import 'package:pop_up_ads/cubit/states.dart';
import 'package:pop_up_ads/layout/home_layout.dart';
import 'package:pop_up_ads/modules/ads%20screen/ads_screen.dart';
import 'package:pop_up_ads/modules/ads%20screen/create_screen.dart';
import 'package:pop_up_ads/modules/login/login_screen.dart';
import 'package:pop_up_ads/modules/register/register_screen.dart';
import 'package:pop_up_ads/network/local/cache_helper.dart';
import 'package:pop_up_ads/styles/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = HomeLayout();
  } else {
    widget = LoginScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getAllAds()
        ..getAllIds()
        ..getAllMyAds(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: startWidget,
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/home': (context) => const AdsScreen(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/second': (context) => const CreateAdScreen(),
            '/homeLayout': (context) => const HomeLayout()
          },
        ),
      ),
    );
  }
}
