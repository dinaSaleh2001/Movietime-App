
import 'package:flutter/material.dart';
import 'package:movies/main.dart';
import 'package:movies/pages/contact_us.dart';
import 'package:movies/pages/favorites_screen.dart';
import 'package:movies/pages/people_screen.dart';
import 'package:movies/pages/search_screen.dart';
import 'package:movies/pages/trendingmovie.dart';
import 'package:movies/services/tmdb_api.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<dynamic>> trendingMovies;
  List<Map<String, dynamic>> favoriteMovies = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    trendingMovies = TMDbApi.getTrending();
  }

  void toggleFavorite(Map<String, dynamic> movie) {
    setState(() {
      if (favoriteMovies.contains(movie)) {
        favoriteMovies.remove(movie);
      } else {
        favoriteMovies.add(movie);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? currentScreen;
    if (_selectedIndex == 0) {
      currentScreen = TrendingMoviesScreen(
        toggleFavorite: toggleFavorite,
        favoriteMovies: favoriteMovies,
      );
    } else if (_selectedIndex == 1) {
      currentScreen = FavoritesScreen(
        toggleFavorite: toggleFavorite,
        favoriteMovies: favoriteMovies,
      );
    } else {
      currentScreen = const PersonListPage();
    }

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ),
              accountEmail: null,
              accountName: null,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: ListTile(
                  title: const Text('Home', style: TextStyle(fontSize: 20)),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.home,
                      size: 29,
                    ),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const contact_us(),
                  ),
                );
              },
              child: ListTile(
                  title:
                      const Text('Contact Us', style: TextStyle(fontSize: 20)),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const contact_us(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.phone,
                      size: 29,
                    ),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: ListTile(
                  title: const Text(
                    'Exit',
                    style: TextStyle(fontSize: 20),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      size: 29,
                    ),
                  )),
            ),
            const SizedBox(
              height: 150,
            ),
            const Divider(
              thickness: 4,
              color: Colors.blue,
              endIndent: 20,
              indent: 20,
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                    height: 40,
                    width: 40,
                    "data:image/jpeg;base64,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"),
                Image.network(
                    height: 40,
                    width: 40,
                    "https://i0.wp.com/escuelawalterschmidt.com/wp-content/uploads/2020/10/900px-facebook_f_logo_2019.svg_-1.png?ssl=1"),
                Image.network(
                    height: 40,
                    width: 40,
                    "https://th.bing.com/th/id/OIP.ho1dc1a3VpPFl1Fy3pv5vAHaHZ?w=203&h=202&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
                Image.network(
                    height: 40,
                    width: 40,
                    "data:image/jpeg;base64,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")
              ],
            ),
          ],
        )),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              icon: const Icon(Icons.brightness_4_rounded),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                        toggleFavorite: toggleFavorite,
                        favoriteMovies: favoriteMovies,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.search))
          ],
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Enjoy your watching movies',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        body: currentScreen,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Trending',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'People',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff3282B8),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
