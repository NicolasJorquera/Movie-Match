import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_movie_ticket/src/core/constants/app_colors.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

import 'widgets/createOrJoin/create_widget.dart';
import 'widgets/createOrJoin/join_widget.dart';

class CreateOrJoinWidget extends StatefulWidget {
  const CreateOrJoinWidget({super.key});

  @override
  State<CreateOrJoinWidget> createState() => _CreateOrJoinWidgetState();
}

class _CreateOrJoinWidgetState extends State<CreateOrJoinWidget>
    with SingleTickerProviderStateMixin {
  int currentStep = 0;
  late final TabController _tabController;

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
          indicatorColor: Color.fromRGBO(180, 0, 0, 1),
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
              CreateWidget(),
              JoinWidget(),
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
