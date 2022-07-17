import 'package:flutter/material.dart';
import 'package:news_cubit/controller/cached_helper.dart';
import 'package:news_cubit/controller/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cubit/controller/dio_helper.dart';
import 'package:news_cubit/view/screens/Bussines_screen.dart';
import 'package:news_cubit/view/screens/science_sports.dart';
import 'package:news_cubit/view/screens/general_screen.dart';
import 'package:news_cubit/view/screens/sports_screen.dart';

class AppCubit extends Cubit<NewsAppStates> {
  AppCubit() : super(IntialAppStates());

  static AppCubit get(context) => BlocProvider.of(context);
  static String ApiKey = "30f629ad0f0442fd83588b920a1f39fb";

  int currentIndex = 0;
  int businessSelected = 0;
  bool isDesktop=false;


  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.newspaper),
      label: "General",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),

  ];

  void changBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getBussines();
    if (index == 2) getSports();
    if (index == 3) getScience();
    emit(NewsBottomNavButton());
  }

  List<Widget> screens = [
    const General_screen(),
    const Bussines_screen(),
    const sports_screen(),
    const science_screen(),

  ];
 //https://newsapi.org/v2/everything?q=tesla&apiKey=30f629ad0f0442fd83588b920a1f39fb
  List<dynamic> general = [];
  List<dynamic> bussines = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getGeneral() async {

    emit(LoadingGetGeneralNewsAppStates());

    DioHelper.getDataAPI(
        url: '/v2/top-headlines',
        query: {
          'country':'eg',

          'apiKey':'30f629ad0f0442fd83588b920a1f39fb',

        }).then((value) => general = value.data['articles']);


    emit(GetGeneralNewsAppStates());



  }
  void getBussines() async {

     emit(LoadingGetBusinessNewsAppStates());

    DioHelper.getDataAPI(
        url: '/v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'30f629ad0f0442fd83588b920a1f39fb',

        }).then((value) {
           bussines = value.data['articles'];
           // bussines.forEach((element) {
           //   businessSelected.add(false);
           // });
        });


     emit(GetBusinessNewsAppStates());



  }
  void selectedBussiness (index){
    businessSelected = index;
    emit(SelectedBusinessNewsAppStates());
  }
  void setDesktop(bool value){
    isDesktop= value;
    emit(IsDesktopNewsAppStates());
  }
  void getSports() async {



    emit(LoadingGetSportsNewsAppStates());
    DioHelper.getDataAPI(
        url: '/v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'30f629ad0f0442fd83588b920a1f39fb',

        }).then((value) => sports = value.data['articles']);


    emit(GetSportsNewsAppStates());



  }
  void getScience() async {

    emit(LoadingGetSceinceNewsAppStates());
    DioHelper.getDataAPI(
        url: '/v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'30f629ad0f0442fd83588b920a1f39fb',

        }).then((value) => science = value.data['articles']);


    emit(GetSceinceNewsAppStates());



  }

  void getSearch(String value) async {


    emit(LoadingSearchlNewsAppStates());
    search=[];

    DioHelper.getDataAPI(
        url: '/v2/everything',
        query: {
          'q':value,

          'apiKey':'30f629ad0f0442fd83588b920a1f39fb',

        }).then((value) => search = value.data['articles']);


    emit(SearchNewsAppStates());



  }

  bool isDark=false;
  ThemeMode appMode = ThemeMode.dark;

  void changeAppMode ({bool? fromShared})
  {

    fromShared !=null ? isDark =fromShared :
    isDark = !isDark;
    CachHelper.putData(key: 'isDark', value: isDark).then((value) => emit(ChangeModeNewsAppStates()));

  }

}


class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}