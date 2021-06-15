class MovieResponse {
  List<Movie> results;

  MovieResponse({this.results});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Movie>();
      json['results'].forEach((v) {
        results.add(new Movie.fromJson(v));
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

class Movie {
  int id;
  String title;
  String body;

  Movie({
    this.id,
    this.title,
    this.body,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': body,
      'title': title,
    };
  }
}
