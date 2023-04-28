import 'package:flutter/material.dart';

import 'package:flutter_movie_ticket/src/core/constants/constants.dart';
import 'package:flutter_movie_ticket/src/core/data/models/movies.dart';

class MovieDateCard extends StatelessWidget {
  const MovieDateCard({
    Key? key,
    required this.date,
    required this.isSelected,
  }) : super(key: key);

  final MovieDate date;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: isSelected ? Color.fromRGBO(180, 0, 0, 1) : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Color.fromRGBO(180, 0, 0, 1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${date.day} ${date.month}',
            style: TextStyle(
                color:
                    isSelected ? Colors.white70 : Color.fromRGBO(180, 0, 0, 1)),
          ),
          const SizedBox(height: 5),
          Text(
            date.hour,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Color.fromRGBO(180, 0, 0, 1),
            ),
          ),
        ],
      ),
    );
  }
}
