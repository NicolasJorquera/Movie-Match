import 'package:flutter/material.dart';

import 'widgets/createOrJoin/create_widget.dart';
import 'widgets/createOrJoin/join_widget.dart';
import 'widgets/movieCards/movieTinder_widget.dart';

class CreateOrJoinWidget extends StatefulWidget {
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  List<dynamic> genres = [];
  CreateOrJoinWidget(
      {super.key, required this.platformsSelected, required this.providers, required this.genres});

  @override
  State<CreateOrJoinWidget> createState() =>
      _CreateOrJoinWidgetState(platformsSelected, providers, genres);
}

class _CreateOrJoinWidgetState extends State<CreateOrJoinWidget>
    with SingleTickerProviderStateMixin {
  int currentStep = 0;
  List<dynamic> genres = [];
  late final TabController _tabController;
  List<dynamic> platformsSelected;
  List<dynamic> providers;
  _CreateOrJoinWidgetState(this.platformsSelected, this.providers, this.genres);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
                'Create',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                'Join',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              CreateWidget(
                platformsSelected: widget.platformsSelected,
                providers: widget.providers,
                genres: widget.genres,
              ),
              JoinWidget(
                platformsSelected: widget.platformsSelected,
                providers: widget.providers,
              ),
            ],
          ),
        )
      ],
    );
  }

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: const Text(
              'Platforms',
              style: TextStyle(color: Colors.white),
            ),
            content: Container()),
        Step(
            isActive: currentStep >= 1,
            title: const Text('Genres', style: TextStyle(color: Colors.white)),
            content: Container()),
        Step(
            isActive: currentStep >= 2,
            title:
                const Text('Other step', style: TextStyle(color: Colors.white)),
            content: Container()),
      ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
