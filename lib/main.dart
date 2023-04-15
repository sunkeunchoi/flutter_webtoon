// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Popular Movies"),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Movie> movies = snapshot.data as List<Movie>;
                    return SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final Movie movie = movies[index];
                            return Text(movie.title);
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
              const Text("Now in Cinemas"),
              FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Movie> movies = snapshot.data as List<Movie>;
                      return SizedBox(
                        height: 300,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final Movie movie = movies[index];
                              return Text(movie.title);
                            },
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                  future: nowPlaying),
              const Text("Coming Soon"),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Movie> movies = snapshot.data as List<Movie>;
                    return SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final Movie movie = movies[index];
                            return Text(movie.title);
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

String imageUrl(String path) => "https://image.tmdb.org/t/p/w500$path";

class MovieDetail {
  final bool adult;
  final String backdropPath;
  final BelongsToCollection belongsToCollection;
  final int budget;
  final List<Genres> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompanies> productionCompanies;
  final List<ProductionCountries> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguages> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final int voteAverage;
  final int voteCount;

  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    return MovieDetail(
      adult: map['adult'] as bool,
      backdropPath: map['backdropPath'] as String,
      belongsToCollection: BelongsToCollection.fromMap(
          map['belongsToCollection'] as Map<String, dynamic>),
      budget: map['budget'] as int,
      genres: List<Genres>.from(
        (map['genres'] as List<int>).map<Genres>(
          (x) => Genres.fromMap(x as Map<String, dynamic>),
        ),
      ),
      homepage: map['homepage'] as String,
      id: map['id'] as int,
      imdbId: map['imdbId'] as String,
      originalLanguage: map['originalLanguage'] as String,
      originalTitle: map['originalTitle'] as String,
      overview: map['overview'] as String,
      popularity: map['popularity'] as double,
      posterPath: map['posterPath'] as String,
      productionCompanies: List<ProductionCompanies>.from(
        (map['productionCompanies'] as List<int>).map<ProductionCompanies>(
          (x) => ProductionCompanies.fromMap(x as Map<String, dynamic>),
        ),
      ),
      productionCountries: List<ProductionCountries>.from(
        (map['productionCountries'] as List<int>).map<ProductionCountries>(
          (x) => ProductionCountries.fromMap(x as Map<String, dynamic>),
        ),
      ),
      releaseDate: map['releaseDate'] as String,
      revenue: map['revenue'] as int,
      runtime: map['runtime'] as int,
      spokenLanguages: List<SpokenLanguages>.from(
        (map['spokenLanguages'] as List<int>).map<SpokenLanguages>(
          (x) => SpokenLanguages.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: map['status'] as String,
      tagline: map['tagline'] as String,
      title: map['title'] as String,
      video: map['video'] as bool,
      voteAverage: map['voteAverage'] as int,
      voteCount: map['voteCount'] as int,
    );
  }
}

class BelongsToCollection {
  final int id;
  final String name;
  final String posterPath;
  final String backdropPath;

  const BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  factory BelongsToCollection.fromMap(Map<String, dynamic> map) {
    return BelongsToCollection(
      id: map['id'] as int,
      name: map['name'] as String,
      posterPath: map['posterPath'] as String,
      backdropPath: map['backdropPath'] as String,
    );
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
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}

class ProductionCompanies {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  const ProductionCompanies({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompanies.fromMap(Map<String, dynamic> map) {
    return ProductionCompanies(
      id: map['id'] as int,
      logoPath: map['logoPath'] as String,
      name: map['name'] as String,
      originCountry: map['originCountry'] as String,
    );
  }
}

class ProductionCountries {
  final String iso31661;
  final String name;

  const ProductionCountries({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountries.fromMap(Map<String, dynamic> map) {
    return ProductionCountries(
      iso31661: map['iso31661'] as String,
      name: map['name'] as String,
    );
  }
}

class SpokenLanguages {
  final String englishName;
  final String iso6391;
  final String name;

  const SpokenLanguages({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguages.fromMap(Map<String, dynamic> map) {
    return SpokenLanguages(
      englishName: map['englishName'] as String,
      iso6391: map['iso6391'] as String,
      name: map['name'] as String,
    );
  }
}

class MovieResponse {
  final Dates? dates;
  final int page;
  final List<Movie> results;
  final int? totalPages;
  final int? totalResults;
  const MovieResponse({
    this.dates,
    required this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieResponse.fromMap(Map<String, dynamic> map) {
    return MovieResponse(
      dates: map['dates'] != null
          ? Dates.fromMap(map['dates'] as Map<String, dynamic>)
          : null,
      page: map['page'] as int,
      results: List<Movie>.from(
        (map['results'] as List<dynamic>).map<Movie>(
          (x) => Movie.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalPages: map['totalPages'] != null ? map['totalPages'] as int : null,
      totalResults:
          map['totalResults'] != null ? map['totalResults'] as int : null,
    );
  }
}

class Dates {
  final String maximum;
  final String minimum;
  const Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromMap(Map<String, dynamic> map) {
    return Dates(
      maximum: map['maximum'] as String,
      minimum: map['minimum'] as String,
    );
  }
}

class Movie {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double? voteAverage;
  final int? voteCount;

  const Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      adult: map['adult'] as bool,
      backdropPath: map['backdropPath'].toString(),
      genreIds: map['genreIds'] != null ? List<int>.from(map['genreIds']) : [],
      id: map['id'] as int,
      originalLanguage: map['originalLanguage'].toString(),
      originalTitle: map['originalTitle'].toString(),
      overview: map['overview'].toString(),
      popularity: map['popularity'] as double,
      posterPath: map['posterPath'].toString(),
      releaseDate: map['releaseDate'].toString(),
      title: map['title'].toString(),
      video: map['video'] as bool,
      voteAverage: map['voteAverage'] != null
          ? double.tryParse(map['voteAverage'])
          : null,
      voteCount:
          map['voteCount'] != null ? int.tryParse(map['voteCount']) : null,
    );
  }
}
