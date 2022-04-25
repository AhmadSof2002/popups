abstract class AppStates {}

class InitialAppState extends AppStates {}

class SocialGetUserLoadingState extends AppStates {}

class SocialGetUserSuccessState extends AppStates {}

class SocialGetUserErrorState extends AppStates {
  String? error;
  SocialGetUserErrorState(this.error);
}

class CreateAdLoadingAppState extends AppStates {}

class CreateAdSuccessAppState extends AppStates {}

class CreateAdErrorAppState extends AppStates {
  String? error;
  CreateAdErrorAppState(this.error);
}

class GetAllAdsLoadingAppState extends AppStates {}

class AdDeleteLoadingState extends AppStates {}

class AdDeleteSuccessState extends AppStates {}

class AdDeleteErrorState extends AppStates {}

class GetAllAdsSuccessAppState extends AppStates {}

class GetAllAdsErrorAppState extends AppStates {
  String? error;
  GetAllAdsErrorAppState(this.error);
}

class AdUpdateLoadingState extends AppStates {}

class AdUpdateSuccessState extends AppStates {}

class AdUpdateErrorState extends AppStates {}

class ChangeNavBottomSuccessState extends AppStates {}

class GetAllMyAdsLoadingAppState extends AppStates {}

class GetAllMyAdsSuccessAppState extends AppStates {}

class GetAllMyAdsErrorAppState extends AppStates {}
