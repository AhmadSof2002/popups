import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pop_up_ads/components/components.dart';
import 'package:pop_up_ads/cubit/cubit.dart';
import 'package:pop_up_ads/cubit/states.dart';
import 'package:pop_up_ads/modules/ads%20screen/ads_screen.dart';
import 'package:pop_up_ads/modules/ads%20screen/create_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              AppCubit.get(context).changeBottomNavigationBar(index);
            },
            currentIndex: AppCubit.get(context).currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.ad_units_sharp), label: 'my ads'),
            ]),
      ),
    );
  }
}
