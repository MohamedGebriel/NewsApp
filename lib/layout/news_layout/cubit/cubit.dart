import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/states.dart';


import '../../../models/business_screen.dart';
import '../../../models/science_screen.dart';
import '../../../models/sports_screen.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';



class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsInitialState());

  bool isDark = false;

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_outlined),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_esports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // if(index==1)
    //   getSports();
    // if(index==2)
    //   getScience();
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '3ddaba5f7bbd4fc3aa15c0398e4ad074'
      }).then((value) {
        business = value.data["articles"];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        emit(NewsGetBusinessErrorState(error));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '3ddaba5f7bbd4fc3aa15c0398e4ad074'
      }).then((value) {
        sports = value.data["articles"];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '3ddaba5f7bbd4fc3aa15c0398e4ad074'
      }).then((value) {
        science = value.data["articles"];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    if (search.isEmpty) {
      DioHelper.getData(
              url: '/v2/everything',
              query: {'q': value, 'apiKey': '3ddaba5f7bbd4fc3aa15c0398e4ad074'})
          .then((value) {
        search = value.data["articles"];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        emit(NewsGetSearchErrorState(error));
      });
    } else {
      emit(NewsGetSearchSuccessState());
    }
  }


  void changeMode({bool? fromShared}) {
  if (fromShared != null) {
  isDark = fromShared;
  emit(AppChangeModeState());
  } else {
  isDark = !isDark;
  CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
  emit(AppChangeModeState());
  });
  }
  }
/* bool isDark = false;
  void changeMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }*/

  }


