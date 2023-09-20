import 'package:flutter/material.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/screens/home_screen.dart';
import 'package:followme/screens/profile_screen.dart';
import 'package:followme/utilities/widgets/map_widget.dart';
import 'package:followme/utilities/widgets/submitRouteScreen/route_map.dart';

import '../icons.dart';

class ScreenContainer extends StatefulWidget {
  const ScreenContainer({Key? key}) : super(key: key);

  @override
  _ScreenContainerState createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {
  int _selectedIndex = 1;
  //add pages here
  final List<Widget> _widgetOptions = [
    HomeScreen(),
    MapWidget(routeId: "", showSearchBar: true),
    ProfileScreen()
  ];

  final List<String> _widgetTitles = [
    'Home',
    'Map',
    'Profile'
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.circle, size: 10.0,),
          title: Text(_widgetTitles.elementAt(_selectedIndex), style: Theme.of(context).textTheme.headline1,),
          backgroundColor: Colors.white,
          foregroundColor: FollowMeColors.primaryColor,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 5,
          backgroundColor: Colors.white,
          items: [
            const BottomNavigationBarItem(
                label: "Home", icon: Icon(MyFlutterApp.home_icon)),
            BottomNavigationBarItem(
                label: "Places",
                activeIcon: Image.asset("assets/icons/place_icon_fill.png",
                    height: 55.0),
                icon: Image.asset("assets/icons/place_icon.png", height: 55.0)),
            const BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(MyFlutterApp.profile_icon_outlined)),
          ],
          onTap: _onTap,
          currentIndex: _selectedIndex,
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RouteSelectionWidget()));
                },
                child: Icon(Icons.add),
              )
            : Container(),
        body: _widgetOptions.elementAt(_selectedIndex));
  }
}