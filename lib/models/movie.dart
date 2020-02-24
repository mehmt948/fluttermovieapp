class Movie {
  String posterPath;
  int id;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie(
      {this.posterPath,
      this.id,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    id = json['id'];
    title = json['title'];
    voteAverage = json['vote_average'].toDouble();
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
