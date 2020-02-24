import 'package:movie_gallery/models/movie.dart';

class Movies {
  List<Movie> results;

  Movies({this.results});

  Movies.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Movie>();
      json['results'].forEach((v) {
        if(v['overview'] != ""){
          results.add(new Movie.fromJson(v));
        }

      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

