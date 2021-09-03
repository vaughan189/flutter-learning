class ItemModel {
  int page;
  int totalResults;
  int totalPages;
  List<Result> results;

  ItemModel(
      {required this.page,
      required this.totalResults,
      required this.totalPages,
      required this.results});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    List<Result> tempResult = [];
    for (int i = 0; i < json['results'].length; i++) {
      Result result = Result(json['results'][i]);
      tempResult.add(result);
    }
    return ItemModel(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: tempResult,
    );
  }

  List<Result> get allResults => results;

  int get totalNumberOfPages => totalPages;

  int get totalNumberOfResults => totalResults;

  int get pageNumber => page;
}

class Result {
  int? voteCount;
  int? id;
  bool? hasVideo;
  dynamic voteAverage;
  String? title;
  double? popularity;
  String? posterPath;
  String? originalLanguage;
  String? originalTitle;
  List<int> genreIds = [];
  String? backdropPath;
  bool? isAdult;
  String? overview;
  String? releaseDate;

  Result(result) {
    voteCount = result['vote_count'];
    id = result['id'];
    hasVideo = result['video'];
    voteAverage = result['vote_average'];
    title = result['title'];
    popularity = result['popularity'];
    posterPath = result['poster_path'];
    originalLanguage = result['original_language'];
    originalTitle = result['original_title'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      genreIds.add(result['genre_ids'][i]);
    }
    backdropPath = result['backdrop_path'];
    isAdult = result['adult'];
    overview = result['overview'];
    releaseDate = result['release_date'];
  }

  String? get getReleaseDate => releaseDate;

  String? get getOverview => overview;

  bool? get getIsAdult => isAdult;

  String? get getBackdropPath => backdropPath;

  List<int> get getGenreIds => genreIds;

  String? get getOriginalTitle => originalTitle;

  String? get getOriginalLanguage => originalLanguage;

  String? get getPosterPath => posterPath;

  double? get getPopularity => popularity;

  String? get getTitle => title;

  double? get getVoteAverage => voteAverage;

  bool? get getVideo => hasVideo;

  int? get getId => id;

  int? get getVoteCount => voteCount;
}
