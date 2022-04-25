import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pop_up_ads/components/components.dart';
import 'package:pop_up_ads/cubit/cubit.dart';
import 'package:pop_up_ads/cubit/states.dart';
import 'package:pop_up_ads/models/ad_model.dart';
import 'package:pop_up_ads/modules/ads%20screen/create_screen.dart';
import 'package:pop_up_ads/modules/ads%20screen/update_screen.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      key: UniqueKey(),
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: true,
          fallback: (context) => CircularProgressIndicator(),
          builder: (context) => Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAdScreen()))
                    .then((value) {});
              },
              child: Icon(Icons.add),
            ),
            body: ListView.separated(
                key: UniqueKey(),
                itemBuilder: (context, index) {
                  return widgetBuildAdItem(
                      AppCubit.get(context).allAds![index], UniqueKey(), index);
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: AppCubit.get(context).allAds!.length),
          ),
        );
      },
    );
  }

  widgetBuildAdItem(AdModel model, key, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              key: key,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              height: 125,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  key: key,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.title}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('${model.text}',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text('${model.price}'),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).deleteAd(model.adId!);
                },
                icon: Icon(Icons.delete)),
            Align(
              alignment: AlignmentDirectional(0.8, 15),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateAdScreen(adId: model.adId)))
                        .then((value) {});
                  },
                  icon: Icon(Icons.edit)),
            ),
          ],
        ),
      );
}
