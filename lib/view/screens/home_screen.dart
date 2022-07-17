import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cubit/controller/cubit/cubit.dart';
import 'package:news_cubit/controller/cubit/states.dart';
import 'package:news_cubit/view/screens/Search_Screen.dart';
import 'package:news_cubit/view/widget/navigatorto_widget.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, NewsAppStates>(
      listener: (BuildContext context, NewsAppStates state) {},
      builder: (BuildContext context, NewsAppStates state) {
        AppCubit getData = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("News App"),
            actions: [
              IconButton(onPressed: ()
              {

                nevigateTo(context , Search_screen());



              },
                  icon: const Icon(Icons.search)),
              IconButton(onPressed: (){
                getData.changeAppMode();

              },
                  icon: const Icon(Icons.brightness_4_outlined))
            ],
          ),
          body: getData.screens[getData.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: getData.bottomItems,
            currentIndex: getData.currentIndex,
            onTap: (index) {
              getData.changBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
