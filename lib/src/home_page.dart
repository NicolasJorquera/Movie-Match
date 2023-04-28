import 'dart:convert';

import 'package:flutter/material.dart';

import 'features/home/home_page.dart';
import 'features/search/search_page.dart';
import 'features/movieMatch/movieMatch_page.dart';
import 'features/user/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<dynamic> dayTrendingMovies = [];

  @override
  Widget build(BuildContext context) {
    final screens = [
      const SearchView(),
      const MovieMatchView(),
      const HomeView(),
      const UsersView()
    ];

    return Scaffold(
        appBar: selectedIndex == 1
            ? null
            : AppBar(
                actions: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    width: 50,
                    child: Ink(
                      decoration: const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/logos/disneyp.png',
                              ),
                              fit: BoxFit.cover)),
                      child: TextButton(
                        child: const Text(''),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    width: 50,
                    child: Ink(
                      decoration: const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/logos/primelogo.png',
                              ),
                              fit: BoxFit.cover)),
                      child: TextButton(
                        child: const Text(''),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    width: 50,
                    child: Ink(
                      decoration: const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/logos/netflix.png',
                              ),
                              fit: BoxFit.cover)),
                      child: TextButton(
                        child: const Text(''),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    width: 50,
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TextButton(
                        child: const Icon(
                          Icons.add,
                          size: 15,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 20, top: 20),
                    child: Ink(
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border(
                                top:
                                    BorderSide(color: Colors.white24, width: 2),
                                left:
                                    BorderSide(color: Colors.white24, width: 2),
                                bottom:
                                    BorderSide(color: Colors.white24, width: 2),
                                right: BorderSide(
                                    color: Colors.white24, width: 2))),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'All',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ],
              ),
        body: Container(
          padding: const EdgeInsets.only(top: 10),
          child: IndexedStack(
            index: selectedIndex,
            children: screens,
          ),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.white),
                activeIcon:
                    Icon(Icons.search, color: Color.fromRGBO(180, 0, 0, 1)),
                label: '',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_rounded, color: Colors.white),
                activeIcon: Icon(Icons.check_circle_rounded,
                    color: Color.fromRGBO(180, 0, 0, 1)),
                label: '',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                activeIcon:
                    Icon(Icons.home, color: Color.fromRGBO(180, 0, 0, 1)),
                label: '',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.white),
                activeIcon:
                    Icon(Icons.person, color: Color.fromRGBO(180, 0, 0, 1)),
                label: '',
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ));
  }
}
