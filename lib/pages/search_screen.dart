import 'package:flutter/material.dart';
import 'package:movies/pages/details_screan.dart';
import '../services/tmdb_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteMovies;
  final Function toggleFavorite;

  const SearchScreen({super.key, required this.favoriteMovies, required this.toggleFavorite});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<dynamic>>? _searchResults;

  void _searchMovies() {
    setState(() {
      _searchResults = TMDbApi.searchMovies(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchMovies,
                ),
                labelText: 'Search here...',
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                _searchMovies();
              },
            ),
            const SizedBox(height: 10.0),
            _searchResults == null
                ? Container()
                : Expanded(
                    child: FutureBuilder<List<dynamic>>(
                      future: _searchResults,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: SpinKitCircle(
                              color: Colors.white,
                              size: 50.0,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                'Failed to load search results: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final movie = snapshot.data![index];
                              final title = movie['title'] ?? movie['name'];
                              final imageUrl =
                                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
                              final overview =
                                  movie['overview'] ?? 'No overview available';

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
                                          toggleFavorite: widget.toggleFavorite,
                                          isFavorite: widget.favoriteMovies
                                              .contains(movie),
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
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
