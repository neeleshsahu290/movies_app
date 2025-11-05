enum RequestStatus { loading, loaded, error }

enum GetAllRequestStatus { loading, loaded, error, fetchMoreError }

enum WatchlistRequestStatus { empty, loading, loaded, error }

enum BookmarkStatus { none, added, removed, exists }

enum MoviesCategory {
  nowPlaying("now_playing"),
  popular("popular"),
  topRated("top_rated");

  final String value;
  const MoviesCategory(this.value);
}
