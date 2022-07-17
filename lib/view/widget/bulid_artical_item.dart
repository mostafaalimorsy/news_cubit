

import 'package:flutter/material.dart';
import 'package:news_cubit/controller/cubit/cubit.dart';
import 'package:news_cubit/view/screens/webView_Screen.dart';

Widget buildArticalItem (artical , context, index ) => Container(
  color: AppCubit.get(context).businessSelected == index && AppCubit.get(context).isDesktop  ? Colors.grey.shade200 : null,
  child:   InkWell(
    onTap: (){
      AppCubit.get(context).selectedBussiness(index);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => WebViewScreen(artical['url'])),
      // );

    },
    child:   Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          //image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage( artical['urlToImage'] == null ? 'https://www.naplesgarden.org/wp-content/themes/naples_botanical/img/notfound.jpg' :
                        '${artical['urlToImage']}'),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${artical['title']}",
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${artical['publishedAt']}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);