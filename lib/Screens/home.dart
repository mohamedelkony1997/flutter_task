// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter_task/Screens/Profile.dart';
import 'package:flutter_task/Screens/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
   
  }
  @override
  Widget build(BuildContext context) {
      return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 248, 245, 245),
        extendBody: true,
        bottomNavigationBar: CircleNavBar(
          activeIcons: const [

            Icon(
              Icons.person,
              color: Colors.white,
            ),
            Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
          ],
          inactiveIcons: [
         
            Text(
              "Profile",
              style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            Text(
              "DashBoard",
              style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
          color: Color(0xff6c63ff),
          height: 60,
          circleWidth: 60,
          activeIndex: tabIndex,
          onTap: (index) {
            tabIndex = index;
            pageController.jumpToPage(tabIndex);
          },
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          shadowColor: Colors.deepPurple,
          elevation: 10,
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (v) {
            tabIndex = v;
          },
          children: [Profile(),DashBoard()],
        ),
      ),
    );
  }
}