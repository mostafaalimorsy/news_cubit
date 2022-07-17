import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_cubit/controller/cached_helper.dart';
import 'package:news_cubit/controller/cubit/cubit.dart';
import 'package:news_cubit/controller/cubit/states.dart';
import 'package:news_cubit/controller/dio_helper.dart';

import 'package:news_cubit/view/screens/home_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();



  // bool? isDark = CachHelper.getData(key: 'isDark');

  BlocOverrides.runZoned(() {
    runApp(MyApp());
  },
    blocObserver: MyBlocObserver(),

  );
}

class MyApp extends StatelessWidget {


  // final bool isDark;
  //
  // const MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      AppCubit()
        // ..changeAppMode(fromShared: isDark)
        ..getGeneral()
        ..getBussines()..getBussines()..getBussines()
        ..getSports()
        ..getScience(),
      child: BlocConsumer<AppCubit, NewsAppStates>(

        listener: (BuildContext context, NewsAppStates state) {},
        builder: (BuildContext context, NewsAppStates state) {
          AppCubit getData = AppCubit.get(context);
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    )
                ),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    color: Colors.white,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                    iconTheme: IconThemeData(
                        color: Colors.black
                    )
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 30.0
                )
            ),
            darkTheme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                ),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.light,
                      statusBarColor: HexColor('333739'),
                    ),
                    color: HexColor('333739'),
                    elevation: 0,
                    titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                    iconTheme: const IconThemeData(
                        color: Colors.white
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(

                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: HexColor('333739'),

                )
            ),
            themeMode: getData.isDark ? ThemeMode.dark : ThemeMode.light,
            home: HomeScreen(),
          );
        },
      ),

    );
  }
}
