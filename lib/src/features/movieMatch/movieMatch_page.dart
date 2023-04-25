import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_movie_ticket/src/core/data/data.dart';

class MovieMatchView extends StatefulWidget {
  const MovieMatchView({super.key});

  @override
  State<MovieMatchView> createState() => _MovieMatchViewState();
}

class _MovieMatchViewState extends State<MovieMatchView> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AppinioSwiper(
        loop: true,
        cardsCount: 3,
        cardsBuilder: (BuildContext context, int index){
          final movie = movies[index];
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
              image: DecorationImage(
                image: AssetImage(movie.image),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}