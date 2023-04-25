import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_movie_ticket/src/core/data/data.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final categories = [
    {'name': 'accion', 'movies': movies},
    {'name': 'aventura', 'movies': movies},
    {'name': 'aventura', 'movies': movies},
    {'name': 'aventura', 'movies': movies},
    {'name': 'aventura', 'movies': movies},
    {'name': 'aventura', 'movies': movies},
    {'name': 'aventura', 'movies': movies},
    {'name': 'aventura', 'movies': movies},
    {'name': 'aventura', 'movies': movies},
    {'name': 'aventura', 'movies': movies},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return buildRow(index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 0);
        },
        itemCount: 20);
  }

  Widget buildCard(int index) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/greta.jpg',
                height: 220,
                width: 140,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 8,
          )
        ],
      );

  Widget buildRow(int index) => Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            'Accion $index',
            style: const TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.left,
          ),
          SizedBox(
              height: 252,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return buildCard(index);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12);
                  },
                  itemCount: 10))
        ],
      );
}
