import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cubit/controller/cubit/cubit.dart';
import 'package:news_cubit/controller/cubit/states.dart';
import 'package:news_cubit/view/widget/articalConditionalBuilder.dart';

class Search_screen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, NewsAppStates>(
      listener: (BuildContext context, NewsAppStates state) {},
      builder: (BuildContext context, NewsAppStates state) {
        var list = AppCubit
            .get(context)
            .search;
        return Scaffold(
          appBar: AppBar(


          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0,bottom: 20.0),
                child: TextFormField(
                  onChanged: (value){

                    AppCubit.get(context).getSearch(value);



                  },
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "search must not be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration:  InputDecoration(
                      hintText:" Type your text to Search",

                      label:Text("Search",style: Theme.of(context).textTheme.bodyText1,),
                      prefix: const Icon (Icons.search),
                  ),
                ),
              ),
              Expanded(child: ArticalConditionalBuilder(list, context)),
            ],
          ),
        );
      },);
  }
}
