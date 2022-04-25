import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pop_up_ads/components/components.dart';
import 'package:pop_up_ads/cubit/cubit.dart';
import 'package:pop_up_ads/cubit/states.dart';
import 'package:pop_up_ads/layout/home_layout.dart';
import 'package:pop_up_ads/modules/ads%20screen/ads_screen.dart';
import 'package:pop_up_ads/modules/login/loginCubit/states.dart';

class UpdateAdScreen extends StatefulWidget {
  String? adId;
  UpdateAdScreen({Key? key, this.adId}) : super(key: key);

  @override
  State<UpdateAdScreen> createState() => _UpdateAdScreenState();
}

class _UpdateAdScreenState extends State<UpdateAdScreen> {
  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var descController = TextEditingController();
    var priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create your ad'),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AdUpdateSuccessState) {
            navigateAndFinish(context, HomeLayout());
          }
        },
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please fill this required fields',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 35,
              ),
              defaultTextFormField(
                  hintText: 'title',
                  label: 'title',
                  controller: titleController),
              SizedBox(
                height: 15,
              ),
              defaultTextFormField(
                  hintText: 'description',
                  hintColor: Colors.black,
                  label: 'description',
                  controller: descController),
              SizedBox(
                height: 15,
              ),
              defaultTextFormField(
                  hintText: 'price',
                  label: 'price',
                  controller: priceController),
              SizedBox(
                height: 15,
              ),
              defaultButton(
                  function: () {
                    AppCubit.get(context).updateAd(
                        title: titleController.text,
                        text: descController.text,
                        price: priceController.text,
                        adId: widget.adId);
                  },
                  text: 'Update Ad')
            ],
          ),
        ),
      ),
    );
  }
}
