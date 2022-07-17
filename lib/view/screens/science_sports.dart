import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cubit/controller/cubit/cubit.dart';
import 'package:news_cubit/controller/cubit/states.dart';
import 'package:news_cubit/view/widget/articalConditionalBuilder.dart';
import 'package:responsive_builder/responsive_builder.dart';

class science_screen extends StatelessWidget {
  const science_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, NewsAppStates>(
      listener: (BuildContext context, NewsAppStates state) {},
      builder: (BuildContext context, NewsAppStates state) {
        var list = AppCubit.get(context).science;
        return ScreenTypeLayout(
          breakpoints: ScreenBreakpoints(desktop: 600, tablet: 300, watch: 300),
          mobile: Builder(
              builder: (context) {
                AppCubit.get(context).setDesktop(false);
                return ArticalConditionalBuilder(list, context);

              }
          ),
          desktop: Builder(
              builder: (context) {
                AppCubit.get(context).setDesktop(true);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: ArticalConditionalBuilder(list, context)),
                    Expanded(child:Container(
                      color: Colors.grey.shade200,
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Text("${list[AppCubit.get(context).businessSelected]['description']}" ,
                          style: TextStyle(
                              fontSize: 20
                          ),),
                      ),
                    )),
                  ],
                );
              }
          ),
        );
      },
    );
  }
}
