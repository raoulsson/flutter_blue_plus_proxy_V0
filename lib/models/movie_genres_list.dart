import 'movie_genre.dart';

class MovieGenresList {
  List<MovieGenre> genres = <MovieGenre>[];

  MovieGenresList(this.genres);

  MovieGenre findById(int genre) => genres.firstWhere((g) => g.genre == genre);
}
