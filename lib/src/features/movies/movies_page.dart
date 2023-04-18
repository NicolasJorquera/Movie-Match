import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicator: const DotIndicator(),
          tabs: const [
            Tab(text: 'Movie'),
            Tab(text: 'Series'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          MoviesView(),
          SizedBox.expand(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
