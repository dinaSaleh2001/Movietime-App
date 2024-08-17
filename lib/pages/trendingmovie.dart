
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies/pages/details_screan.dart';
import 'package:movies/services/tmdb_api.dart';

class TrendingMoviesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteMovies;
  final Function toggleFavorite;

  const TrendingMoviesScreen(
      {super.key, required this.favoriteMovies, required this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: TMDbApi.getTrending(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitCircle(
              color: Colors.white,
              size: 50.0,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
                'Failed to load trending movies and shows: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final movie = snapshot.data![index];
              final title = movie['title'] ?? movie['name'];
              final imageUrl =
                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
              final overview = movie['overview'] ?? 'No overview available';

              return Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: ListTile(
                  leading: Image.network(imageUrl),
                  title: Text(title),
                  subtitle: Text(overview.length > 50
                      ? overview.substring(0, 50) + '...'
                      : overview),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          movie: movie,
                          toggleFavorite: toggleFavorite,
                          isFavorite: favoriteMovies.contains(movie),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
