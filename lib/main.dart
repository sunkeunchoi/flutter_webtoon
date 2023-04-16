import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Movie>> popular;

  late final Future<List<Movie>> nowPlaying;

  late final Future<List<Movie>> upcoming;
  @override
  void initState() {
    super.initState();
    popular = ApiServices.getPopularMovies();
    upcoming = ApiServices.getUpcomingMovies();
    nowPlaying = ApiServices.getNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const SectionTitle(title: "Popular Movies"),
                const SizedBox(height: 20),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Movie> movies = snapshot.data as List<Movie>;
                      return SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 20),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final Movie movie = movies[index];
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      movieId: movie.id,
                                      movieType: MovieType.popular,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    MovieImageCard(
                                      movie: movie,
                                      movieType: MovieType.popular,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                  future: popular,
                ),
                const SizedBox(height: 20),
                const SectionTitle(title: "Now in Cinemas"),
                const SizedBox(height: 20),
                FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<Movie> movies = snapshot.data as List<Movie>;
                        return SizedBox(
                          height: 300,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 20),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                final Movie movie = movies[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailScreen(
                                          movieId: movie.id,
                                          movieType: MovieType.nowPlaying,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      MovieImageCard(
                                        movie: movie,
                                        movieType: MovieType.nowPlaying,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: MovieType.nowPlaying.width,
                                        child: Text(
                                          movie.title,
                                          softWrap: true,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: -1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                    future: nowPlaying),
                const SizedBox(height: 20),
                const SectionTitle(title: "Coming Soon"),
                const SizedBox(height: 20),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Movie> movies = snapshot.data as List<Movie>;
                      return SizedBox(
                        height: 350,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 20),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final Movie movie = movies[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                        movieId: movie.id,
                                        movieType: MovieType.upcoming,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    MovieImageCard(
                                      movie: movie,
                                      movieType: MovieType.upcoming,
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: MovieType.upcoming.width,
                                      child: Text(
                                        movie.title,
                                        softWrap: true,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                  future: upcoming,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  final MovieType movieType;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
    required this.movieType,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late final Future<MovieDetail?> movieDetail;

  @override
  void initState() {
    super.initState();
    movieDetail = ApiServices.getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          leadingWidth: double.infinity,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const TextWithBorder(
                text: "<   Back to list",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: movieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final MovieDetail? movieDetail = snapshot.data;
                if (movieDetail == null) {
                  return const Center(child: Text("Movie not found"));
                }
                return Hero(
                  tag: "${widget.movieType.name}-${movieDetail.id}",
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: MediaQuery.of(context).size.aspectRatio,
                        child: Image.network(
                          movieDetail.posterPath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MovieTitleText(text: movieDetail.title),
                                const SizedBox(height: 10),
                                // Star rating widget here
                                Row(
                                  children: [
                                    for (var i = 0; i < 5; i++) ...[
                                      Icon(
                                        Icons.star,
                                        color: i < movieDetail.voteAverage / 2
                                            ? Colors.yellow
                                            : Colors.white,
                                      ),
                                      const SizedBox(width: 3),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 10),
                                TextWithBorder(
                                  text:
                                      "${movieDetail.runtimeString} | ${movieDetail.genresString}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MovieOverviewText(text: movieDetail.overview),
                                // const SizedBox(height: 20),
                                // const BuyTicketButton()
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}

class TextWithBorder extends StatelessWidget {
  const TextWithBorder({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = Colors.black.withOpacity(0.5),
          ),
        ),
        Text(
          text,
          softWrap: true,
          style: style.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class MovieOverviewText extends StatelessWidget {
  const MovieOverviewText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  final TextStyle style = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -1,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = Colors.black.withOpacity(0.5),
          ),
        ),
        Text(
          text,
          softWrap: true,
          style: style.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class MovieTitleText extends StatelessWidget {
  const MovieTitleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  final TextStyle style = const TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w800,
    height: 1,
    letterSpacing: -1,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 5
              ..color = Colors.black.withOpacity(0.5),
          ),
        ),
        Text(
          text,
          style: style.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class BuyTicketButton extends StatelessWidget {
  const BuyTicketButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Center(
            child: Text(
              "Buy ticket",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                height: 1.5,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum MovieType {
  popular,
  upcoming,
  nowPlaying;

  double get width {
    switch (this) {
      case MovieType.popular:
        return 300;
      case MovieType.nowPlaying:
        return 200;
      case MovieType.upcoming:
        return 180;
    }
  }

  double get height {
    switch (this) {
      case MovieType.popular:
        return 200;
      case MovieType.nowPlaying:
        return 200;
      case MovieType.upcoming:
        return 240;
    }
  }

  double get aspectRatio {
    switch (this) {
      case MovieType.popular:
        return 3 / 2;
      case MovieType.nowPlaying:
        return 1;
      case MovieType.upcoming:
        return 3 / 4;
    }
  }
}

class MovieImageCard extends StatelessWidget {
  final Movie movie;
  final MovieType movieType;
  const MovieImageCard({
    Key? key,
    required this.movie,
    required this.movieType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${movieType.name}-${movie.id}",
      child: Container(
        width: movieType.width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: AspectRatio(
          aspectRatio: movieType.aspectRatio,
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class ApiServices {
  static String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static Future<List<Movie>> getPopularMovies() async {
    try {
      final url = Uri.parse("$baseUrl/popular");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return MovieResponse.fromMap(json).results;
      } else {
        throw Exception("Failed to load getPopularMovies");
      }
    } on Exception catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final url = Uri.parse("$baseUrl/now-playing");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return MovieResponse.fromMap(json).results;
      } else {
        throw Exception("Failed to load getNowPlayingMovies");
      }
    } on Exception catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<List<Movie>> getUpcomingMovies() async {
    try {
      final url = Uri.parse("$baseUrl/coming-soon");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return MovieResponse.fromMap(json).results;
      } else {
        throw Exception("Failed to load getUpcomingMovies");
      }
    } on Exception catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<MovieDetail?> getMovieDetail(int id) async {
    try {
      final url = Uri.parse("$baseUrl/movie?id=$id");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return MovieDetail.fromMap(json);
      } else {
        throw Exception("Failed to load getMovieDetail");
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}

class MovieResponse {
  final List<Movie> results;
  MovieResponse({required this.results});
  factory MovieResponse.fromMap(Map<String, dynamic> map) {
    return MovieResponse(
      results: List<Movie>.from(map["results"]?.map((x) => Movie.fromMap(x))),
    );
  }
}

class Movie {
  final int id;
  final String backdropPath;
  final double popularity;
  final String posterPath;
  final String title;

  const Movie({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.posterPath,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'].toInt(),
      backdropPath:
          "https://image.tmdb.org/t/p/w500${map['backdrop_path'].toString()}",
      popularity: map['popularity'].toDouble(),
      posterPath:
          "https://image.tmdb.org/t/p/w500${map['poster_path'].toString()}",
      title: map['title'],
    );
  }
}

class MovieDetail {
  final int id;
  final String backdropPath;
  final String posterPath;
  final String homepage;
  final String overview;
  final double voteAverage;
  final String title;
  final int runtime;
  final List<Genres> genres;
  const MovieDetail({
    required this.backdropPath,
    required this.homepage,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.runtime,
    required this.genres,
  });
  String get runtimeString {
    return "${runtime ~/ 60}h ${runtime % 60}m";
  }

  String get genresString {
    return genres.map((e) => e.name).join(", ");
  }

  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    return MovieDetail(
        id: map['id'].toInt(),
        backdropPath:
            "https://image.tmdb.org/t/p/w500${map['backdrop_path'].toString()}",
        posterPath:
            "https://image.tmdb.org/t/p/w500${map['poster_path'].toString()}",
        homepage: map['homepage'],
        overview: map['overview'],
        voteAverage: map['vote_average'].toDouble(),
        title: map['title'],
        runtime: map['runtime'],
        genres: List<Genres>.from(
          map['genres'].map(
            (x) => Genres.fromMap(x),
          ),
        ));
  }
}

class Genres {
  final int id;
  final String name;

  const Genres({
    required this.id,
    required this.name,
  });

  factory Genres.fromMap(Map<String, dynamic> map) {
    return Genres(
      id: map['id'],
      name: map['name'],
    );
  }
}
