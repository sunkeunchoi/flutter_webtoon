String imageUrl(String path) => "https://image.tmdb.org/t/p/w500$path";

class MovieDetail {
  final bool adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
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
  final double? voteAverage;
  final int voteCount;

  MovieDetail({
    required this.adult,
    required this.backdropPath,
    this.belongsToCollection,
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
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      belongsToCollection: map['belongs_to_collection'] == null
          ? null
          : BelongsToCollection.fromMap(
              map['belongsToCollection'] as Map<String, dynamic>),
      budget: map['budget'],
      genres: List<Genres>.from(
        map['genres'].map(
          (x) => Genres.fromMap(x),
        ),
      ),
      homepage: map['homepage'],
      id: map['id'],
      imdbId: map['imdb_id'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      productionCompanies: List<ProductionCompanies>.from(
        map['production_companies'].map(
          (x) => ProductionCompanies.fromMap(x),
        ),
      ),
      productionCountries: List<ProductionCountries>.from(
        map['production_countries'].map<ProductionCountries>(
          (x) => ProductionCountries.fromMap(x),
        ),
      ),
      releaseDate: map['release_date'],
      revenue: map['revenue'],
      runtime: map['runtime'],
      spokenLanguages: List<SpokenLanguages>.from(
        map['spoken_languages'].map(
          (x) => SpokenLanguages.fromMap(x),
        ),
      ),
      status: map['status'],
      tagline: map['tagline'],
      title: map['title'],
      video: map['video'],
      popularity: map['popularity']?.toDouble(),
      voteAverage: map['vote_average']?.ToDouble(),
      voteCount: map['vote_count'],
    );
  }
}

class BelongsToCollection {
  final int id;
  final String name;
  final String posterPath;
  final String? backdropPath;

  const BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    this.backdropPath,
  });

  factory BelongsToCollection.fromMap(Map<String, dynamic> map) {
    return BelongsToCollection(
      id: map['id'],
      name: map['name'],
      posterPath: map['poster_path'],
      backdropPath: map['backdrop_path'],
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
      logoPath: map['logo_path'] as String,
      name: map['name'] as String,
      originCountry: map['origin_country'] as String,
    );
  }
}

class ProductionCountries {
  final String? iso31661;
  final String name;

  const ProductionCountries({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountries.fromMap(Map<String, dynamic> map) {
    return ProductionCountries(
      iso31661: map['iso31661'],
      name: map['name'],
    );
  }
}

class SpokenLanguages {
  final String englishName;
  final String? iso6391;
  final String name;

  const SpokenLanguages({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguages.fromMap(Map<String, dynamic> map) {
    return SpokenLanguages(
      englishName: map['english_name'] as String,
      iso6391: map['iso6391'],
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
      totalPages: map['total_pages'] != null ? map['total_pages'] as int : null,
      totalResults:
          map['total_results'] != null ? map['total_results'] as int : null,
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
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String? originalLanguage;
  final String? originalTitle;
  final String overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String title;
  final bool video;
  final double? voteAverage;
  final int? voteCount;

  const Movie({
    required this.adult,
    required this.genreIds,
    required this.id,
    this.originalLanguage,
    this.originalTitle,
    required this.overview,
    this.releaseDate,
    required this.title,
    required this.video,
    this.backdropPath,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      adult: map['adult'] as bool,
      genreIds: List<int>.from(map['genre_ids']?.map((x) => x as int) ?? []),
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      releaseDate: map['release_date'],
      backdropPath: map['backdrop_path'],
      title: map['title'],
      id: map['id'] as int,
      video: map['video'] as bool,
      popularity: map['popularity']?.toDouble(),
      voteAverage: map['vote_average']?.toDouble(),
      voteCount: map['vote_count']?.toInt(),
    );
  }
}
