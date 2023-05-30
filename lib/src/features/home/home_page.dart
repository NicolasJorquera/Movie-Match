import 'package:flutter/material.dart';
import 'widget/movieInfo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'movies/home_page_movies.dart';
import 'series/home_page_series.dart';

class HomeView extends StatefulWidget {
  List<dynamic> genresMovies = [];
  List<dynamic> genresSeries = [];
  Function refreshMovies;
  Function refreshSeries;
  HomeView({super.key, required this.genresMovies, required this.genresSeries, required this.refreshMovies, required this.refreshSeries});

  @override
  State<HomeView> createState() => _HomeViewState(genresMovies, genresSeries, refreshMovies, refreshSeries);
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  List<dynamic> genresSeries;
  List<dynamic> genresMovies;
  Function refreshMovies;
  Function refreshSeries;
  final user = FirebaseAuth.instance.currentUser!;
  late final TabController _tabController;

  _HomeViewState(this.genresMovies, this.genresSeries, this.refreshMovies, this.refreshSeries) {
    this.genresMovies = genresMovies;
    this.genresSeries = genresSeries;
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  // @override
  // void setState(fn) {
  //   if(mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.white,
          indicatorColor: const Color.fromRGBO(180, 0, 0, 1),
          tabs: const [
            Tab(
              child: Text(
                'Movies',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                'Series',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              HomeViewMovies(genres: widget.genresMovies, refreshMovies: widget.refreshMovies,),
              HomeViewSeries(genres: widget.genresSeries, refreshSeries: widget.refreshSeries,)
            ],
          ),
        )
      ],
    );
  }
}
