import 'package:flutter/material.dart';
import 'package:movies/utils/app-color.dart';

import '../../../utils/app_theme.dart';

class Search extends StatelessWidget {
  static const String routeName = "search";
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
          ),
          child: const SearchBar(
            backgroundColor: MaterialStatePropertyAll(Color(0xff514F4F)),
                shape: MaterialStatePropertyAll(StadiumBorder(side: BorderSide(width: 1,color: Colors.white))),
                surfaceTintColor: MaterialStatePropertyAll(AppColors.white),
                leading: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.search,color: AppColors.white,),
                  ],
                ),
            hintText: "Search",
            hintStyle: MaterialStatePropertyAll(TextStyle(color: AppColors.black)),
            ),
        ),
        Spacer(),
        Center(child: Image.asset("assets/Group 22.png")),
        Spacer()
      ],
    );
  }
}
