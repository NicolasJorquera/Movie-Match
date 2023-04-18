import 'dart:ui';

import 'package:flutter/material.dart';

import 'features/movies/movies_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          
          SizedBox.expand(),
          MoviesPage(),
          SizedBox.expand(),
        ],
      ),
      bottomNavigationBar: ClipRect(
        child: BottomAppBar(
          color: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Center( 
              heightFactor: 1,
              child: TabBar(
                controller: _tabController,
                isScrollable: false,
                unselectedLabelColor: Colors.white,
                indicatorColor: Colors.transparent,
                labelColor: Colors.red[500],
                tabs: const [
                  Tab(icon: Icon(Icons.search )),
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.person)),
                ],
              ),
            )
          )
        )
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
