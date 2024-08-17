import 'package:flutter/material.dart';
import 'package:movies/services/tmdb_api.dart';
import '../model/person_model.dart';
import 'person_detail_page.dart';

class PersonListPage extends StatefulWidget {
  const PersonListPage({super.key});

  @override
  _PersonListPageState createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  late Future<PersonResponse> futurePersons;

  @override
  void initState() {
    super.initState();
    futurePersons = ApiService().fetchTrendingPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PersonResponse>(
        future: futurePersons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.results.length,
              itemBuilder: (context, index) {
                final person = snapshot.data!.results[index];
                return SizedBox(
                  height: 90,
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: ListTile(
                      leading: person.profilePath.isNotEmpty
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w500${person.profilePath}')
                          : const Icon(Icons.person),
                      title: Text(person.name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PersonDetailPage(person: person),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load data'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
