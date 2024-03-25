import 'package:flutter/material.dart';
import 'package:movies/ui/firstpage/Home.dart';
import 'package:movies/ui/tab_favourit/favourite-tab.dart';
import 'package:movies/ui/tab_moves/moves-tab.dart';
import 'package:movies/ui/tab_search/search-tab.dart';
import 'package:movies/utils/app-color.dart';

class Homescreen extends StatefulWidget {
  static const String routeName = "home";
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentTabIndex=0;
 Widget body=Home();
 List<Widget>tabs=[Home(),Search(),Movies(),Favorite()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
    body: body,
      bottomNavigationBar: buildBottomNavigationBar(),

    );
  }

  Widget buildBottomNavigationBar() => Theme(
    data: ThemeData(canvasColor: AppColors.gray),
    child: BottomNavigationBar(

      items: [
        buildBottomNavigationBarItem(Icons.home,"Home"),
        buildBottomNavigationBarItem(Icons.search,"Search"),
        buildBottomNavigationBarItem(Icons.movie,"Movie"),
        buildBottomNavigationBarItem(Icons.list_alt,"watch list"),


      ],
      selectedItemColor: AppColors.yellow,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: currentTabIndex,
      unselectedItemColor: AppColors.unselecteditem,
      onTap: (index){
        currentTabIndex=index;
        body = tabs[index];
        setState(() { });
      },
    ),
  );
  BottomNavigationBarItem buildBottomNavigationBarItem(IconData iconData,String label) =>
      BottomNavigationBarItem(icon:Icon(iconData),label: label);
}
