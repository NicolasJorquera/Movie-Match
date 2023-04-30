

import 'package:flutter/material.dart';

import 'features/home/home_page.dart';
import 'features/search/search_page.dart';
import 'features/movieMatch/createOrJoin_widget.dart';
import 'features/user/user_page.dart';
import 'features/selectPlatform/selectPlatform_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int previousSelectedIndex = 0;
  bool allPlatformsSelected = false;
  List<dynamic> dayTrendingMovies = [];

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeView(),
       CreateOrJoinWidget(),
      const SearchView(),
      const UsersView()
    ];

    return Scaffold(
        appBar: selectedIndex == 4
            ? null
            : AppBar(
                bottom: PreferredSize(
                    child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                                child: ShaderMask(
                              shaderCallback: (Rect rect) {
                                return const LinearGradient(
                                  colors: [
                                    Colors.purple,
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.purple
                                  ],
                                  stops: [
                                    0.0,
                                    0.0,
                                    0.95,
                                    1.0
                                  ], // 10% purple, 80% transparent, 10% purple
                                ).createShader(rect);
                              },
                              blendMode: BlendMode.dstOut,
                              child: ListView.separated(
                                  reverse: true,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Image.asset(
                                        'assets/logos/primelogo.png',
                                        fit: BoxFit.cover,
                                        color: allPlatformsSelected
                                            ? Color.fromRGBO(0, 0, 0, 0.5)
                                            : Colors.transparent,
                                        colorBlendMode: BlendMode.darken,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 0.1,
                                    );
                                  },
                                  itemCount: 10),
                            )),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Card(
                                color: Colors.white24,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  child: const Icon(
                                    Icons.add,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectPlatformView()),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Card(
                                  color: allPlatformsSelected
                                      ? const Color.fromRGBO(180, 0, 0, 1)
                                      : Colors.black,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: allPlatformsSelected
                                              ? const Color.fromRGBO(
                                                  180, 0, 0, 1)
                                              : Colors.white24,
                                          width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        allPlatformsSelected =
                                            !allPlatformsSelected;
                                      });
                                    },
                                    child: const Text(
                                      'All',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              width: 12,
                            )
                          ],
                        )),
                    preferredSize: const Size.fromHeight(0)),
              ),
        body: Container(
          padding: const EdgeInsets.only(top: 10),
          child: IndexedStack(
            index: selectedIndex,
            children: screens,
          ),
        ),
        bottomNavigationBar: selectedIndex > 3
            ? null
            : Theme(
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
                      previousSelectedIndex = selectedIndex;
                      selectedIndex = value;
                    });
                  },
                  elevation: 0,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home, color: Colors.white),
                      activeIcon:
                          Icon(Icons.home, color: Color.fromRGBO(180, 0, 0, 1)),
                      label: '',
                      backgroundColor: Colors.transparent,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.flash_on, color: Colors.white),
                      activeIcon: Icon(Icons.flash_on,
                          color: Color.fromRGBO(180, 0, 0, 1)),
                      label: '',
                      backgroundColor: Colors.transparent,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search, color: Colors.white),
                      activeIcon: Icon(Icons.search,
                          color: Color.fromRGBO(180, 0, 0, 1)),
                      label: '',
                      backgroundColor: Colors.transparent,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person, color: Colors.white),
                      activeIcon: Icon(Icons.person,
                          color: Color.fromRGBO(180, 0, 0, 1)),
                      label: '',
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ));
  }
}
