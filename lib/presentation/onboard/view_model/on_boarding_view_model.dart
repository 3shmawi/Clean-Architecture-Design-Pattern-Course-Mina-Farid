import 'dart:async';

import '../../../domain/models.dart';
import '../../_resources/assets_manager.dart';
import '../../_resources/strings_manager.dart';
import '../../base/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controllers outputs
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //OnBoarding ViewModel Inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // view model start your job
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //OnBoarding ViewModel outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // onboarding private functions
  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
      sliderObject: _list[_currentIndex],
      currentIndex: _currentIndex,
      numOfSlides: _list.length,
    ));
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(
          title: AppStrings.onBoardingTitle1,
          image: ImageAssets.onboardingLogo1,
          subTitle: AppStrings.onBoardingSubTitle1,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle2,
          image: ImageAssets.onboardingLogo2,
          subTitle: AppStrings.onBoardingSubTitle2,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle3,
          image: ImageAssets.onboardingLogo3,
          subTitle: AppStrings.onBoardingSubTitle3,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle4,
          image: ImageAssets.onboardingLogo4,
          subTitle: AppStrings.onBoardingSubTitle4,
        ),
      ];
}

// inputs mean that "Orders" that our view model will receive from view
abstract class OnBoardingViewModelInputs {
  int goNext(); // when user clicks on right arrow or swipe left
  int goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);

  // stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  // stream controller output
  Stream<SliderViewObject> get outputSliderViewObject;
}
