import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovieInfoPage extends StatefulWidget {
  final dynamic movie;
  const MovieInfoPage({super.key, required this.movie});
  @override
  _MovieInfoPageState createState() => _MovieInfoPageState(movie);
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  final dynamic movie;
  _MovieInfoPageState(this.movie);

  static const image_url = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: Color.fromRGBO(180, 0, 0, 1),
                  secondary: Color.fromRGBO(180, 0, 0, 1))),
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.network(
                        image_url + movie['backdrop_path'],
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.22,
                    right: MediaQuery.of(context).size.width * 0.85,
                    child: BackButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.22,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                      primary: Color.fromRGBO(180, 0, 0, 1),
                                      secondary:
                                          Color.fromRGBO(180, 0, 0, 1))),
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Text(
                                      movie['title'] == null
                                          ? movie['name']
                                          : movie['title'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          overflow: TextOverflow.fade),
                                    ),
                                  ]),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              movie['vote_average'].toString() + '/10',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 5,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              movie['genre_ids'].toString(),
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  movie['overview'],
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Cast',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 200,
                  child: Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                              primary: Color.fromRGBO(180, 0, 0, 1),
                              secondary: Color.fromRGBO(180, 0, 0, 1))),
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const Card(
                              color: Colors.white24,
                              child: SizedBox(
                                height: 200,
                                width: 130,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemCount: 20))),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.white24,
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Related',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 200,
                  child: Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                              primary: Color.fromRGBO(180, 0, 0, 1),
                              secondary: Color.fromRGBO(180, 0, 0, 1))),
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const Card(
                              color: Colors.white24,
                              child: SizedBox(
                                height: 200,
                                width: 130,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemCount: 20))),
            ],
          ),
        ));
  }
}
