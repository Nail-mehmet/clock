

import 'package:clocker/Components/color.dart';
import 'package:clocker/Screens/Homepage/Home_page.dart';
import 'package:clocker/Screens/Favorites/favorites.dart';
import 'package:clocker/Screens/Messages/messages.dart';
import 'package:clocker/Screens/Profile/profile.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    List<IconData> listOfIcons = [
      Icons.home_rounded,
      Icons.favorite_rounded,
      Icons.message,
      Icons.person_rounded,
    ];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Sayfalar Stack içinde arka arkaya yerleştiriliyor
          Offstage(
            offstage: currentIndex != 0,
            child: HomePage(),
          ),
          Offstage(
            offstage: currentIndex != 1,
            child: FavoritesScreen(),
          ),
          Offstage(
            offstage: currentIndex != 2,
            child: MessagesScreen(),
          ),
          Offstage(
            offstage: currentIndex != 3,
            child: ProfilePage(),
          ),
          // Bottom Navigation Bar en üste yerleştiriliyor
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.all(20),
              height: size.width * .155,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: size.width * .024),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        margin: EdgeInsets.only(
                          bottom: index == currentIndex ? 0 : size.width * .029,
                          right: size.width * .0422,
                          left: size.width * .0422,
                        ),
                        width: size.width * .128,
                        height: index == currentIndex ? size.width * .014 : 0,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                      ),
                      Icon(
                        listOfIcons[index],
                        size: size.width * .076,
                        color: index == currentIndex
                            ? primaryColor
                            : secondaryColor,
                      ),
                      SizedBox(height: size.width * .03),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
