import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Card',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MovieCard(),
    );
  }
}

class MovieCard extends StatefulWidget {
  const MovieCard({Key? key}) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  int _current = 0;
  dynamic _selectedIndex = {};

  final CarouselController _carouselController = CarouselController();

  final List<dynamic> _movies = [
    {
      'title': 'Batman 2022',
      'image':
          'https://i0.wp.com/batman-news.com/wp-content/uploads/2021/10/The-Batman-2022-Teaser-Poster-Batman-01.jpg?quality=80&strip=info&ssl=1',
      'description': 'The best movie'
    },
    {
      'title': 'Reminiscence',
      'image':
          'https://i1.wp.com/teaser-trailer.com/wp-content/uploads/Reminiscence-movie-poster.jpg?ssl=1',
      'description': 'The best movie'
    },
    {
      'title': 'The Squid Game',
      'image':
          'https://w0.peakpx.com/wallpaper/114/378/HD-wallpaper-squid-game-netflix-electric-blue-magenta-squid-game.jpg',
      'description': 'The best series'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedIndex.length > 0
          ? FloatingActionButton(
              onPressed: () async {
                await Flushbar(
                  title: 'Follow me for more tips!',
                  margin: const EdgeInsets.all(10),
                  borderRadius: BorderRadius.circular(20),
                  flushbarPosition: FlushbarPosition.TOP,
                  message: 'The source code in the description!',
                  duration: const Duration(seconds: 3),
                ).show(context);
              },
              child: const Icon(Icons.arrow_forward_ios),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          '@flutter_aha',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox.expand(
        child: CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
                height: 550.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.70,
                enlargeCenterPage: true,
                pageSnapping: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: _movies.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedIndex == movie) {
                          _selectedIndex = {};
                        } else {
                          _selectedIndex = movie;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: _selectedIndex == movie
                              ? Border.all(color: Colors.red.shade500, width: 3)
                              : null,
                          boxShadow: _selectedIndex == movie
                              ? [
                                  BoxShadow(
                                      color: Colors.red.shade100,
                                      blurRadius: 30,
                                      offset: const Offset(0, 10))
                                ]
                              : [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 5))
                                ]),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 450,
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  movie['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              movie['title'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              movie['description'],
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList()),
      ),
    );
  }
}
