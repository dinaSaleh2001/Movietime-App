import 'package:flutter/material.dart';
import 'package:movies/pages/details_screan.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteMovies;
  final Function toggleFavorite;

  const FavoritesScreen(
      {super.key, required this.favoriteMovies, required this.toggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = favoriteMovies[index];
          final title = movie['title'] ?? movie['name'];
          final imageUrl =
              'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
          final overview = movie['overview'] ?? 'No overview available';

          return Card(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: ListTile(
              leading: Image.network(imageUrl),
              title: Text(title),
              subtitle: Text(overview.length > 50
                  ? overview.substring(0, 50) + '...'
                  : overview),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  toggleFavorite(movie);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(
                      movie: movie,
                      toggleFavorite: toggleFavorite,
                      isFavorite: true,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
