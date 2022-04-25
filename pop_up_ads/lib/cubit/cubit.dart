import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pop_up_ads/components/constants.dart';
import 'package:pop_up_ads/cubit/states.dart';
import 'package:pop_up_ads/models/ad_model.dart';
import 'package:pop_up_ads/models/user_model.dart';
import 'package:pop_up_ads/modules/ads%20screen/ads_screen.dart';
import 'package:pop_up_ads/modules/ads%20screen/myads_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  List<AdModel>? allAds = [];
  String? id;
  int currentIndex = 0;

  List<Widget> screens = [
    AdsScreen(),
    MyAdsScreen(),
  ];

  void changeBottomNavigationBar(int index) {
    if (index == 1) {
      getAllMyAds();
    }
    currentIndex = index;
    emit(ChangeNavBottomSuccessState());
  }

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
      print(userModel?.uId);
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void createAd(
      {required String? title,
      required String? description,
      required String? price,
      String? publisherId}) {
    emit(CreateAdLoadingAppState());

    docId = FirebaseFirestore.instance.collection('ads').doc().id;
    AdModel model = AdModel(
        title: title,
        text: description,
        price: price,
        publisherId: userModel?.uId,
        adId: docId);

    FirebaseFirestore.instance
        .collection('ads')
        .doc(docId)
        .set(model.toMap())
        .then((value) {
      getAllAds();
      getAllMyAds();

      emit(CreateAdSuccessAppState());
    }).catchError((error) {
      emit(CreateAdErrorAppState(error.toString()));
    });
  }

  List<String> adsId = [];

  void getAllIds() {
    adsId = [];
    FirebaseFirestore.instance.collection('ads').get().then((value) {
      value.docs.forEach((element) {
        adsId.add(element.id);
      });
      print(adsId[0]);
    });
  }

  void getAllAds() {
    allAds = [];
    emit(GetAllAdsLoadingAppState());

    FirebaseFirestore.instance.collection('ads').get().then((value) {
      value.docs.forEach((element) {
        allAds?.add(AdModel.fromJson(element.data()));
      });
      emit(GetAllAdsSuccessAppState());

      print(allAds![0].text);
    }).catchError((error) {
      emit(GetAllAdsErrorAppState(error.toString()));
    });
  }

  List<AdModel> myAds = [];
  void getAllMyAds() {
    myAds = [];
    emit(GetAllMyAdsLoadingAppState());

    FirebaseFirestore.instance.collection('ads').get().then((value) {
      value.docs.forEach((element) {
        if (element.data().containsValue(userModel?.uId)) {
          myAds.add(AdModel.fromJson(element.data()));
        }
      });
      emit(GetAllMyAdsSuccessAppState());
    }).catchError((error) {
      emit(GetAllMyAdsErrorAppState());
    });
  }

  void deleteAd(String adId) async {
    emit(AdDeleteLoadingState());
    var collection = FirebaseFirestore.instance.collection('ads');
    var snapshot = await collection.where('adId', isEqualTo: adId).get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete().then((value) {
        getAllAds();
        emit(AdDeleteSuccessState());
      }).catchError((error) {
        emit(AdDeleteErrorState());
      });
    }
  }

  void updateAd(
      {String? title, String? text, String? price, int? index, adId}) {
    emit(AdUpdateLoadingState());
    AdModel model = AdModel(
        price: price,
        title: title,
        text: text,
        publisherId: userModel?.uId,
        adId: adId);

    FirebaseFirestore.instance
        .collection('ads')
        .doc(adId)
        .update(model.toMap())
        .then((value) {
      print('user updated');
      getAllAds();
      emit(AdUpdateSuccessState());
    }).catchError((error) {
      emit(AdUpdateErrorState());
    });
  }
}
