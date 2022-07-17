import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_cubit/view/widget/bulid_artical_item.dart';
import 'package:news_cubit/view/widget/divider.dart';

Widget ArticalConditionalBuilder (list , context) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (BuildContext context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>  buildArticalItem(list [index] , context, index) ,
      separatorBuilder: (context , index) => MyDivider(),
      itemCount: list.length)  ,
  fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),);