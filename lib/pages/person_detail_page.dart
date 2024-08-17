import 'package:flutter/material.dart';
import '../model/person_model.dart';

class PersonDetailPage extends StatelessWidget {
  final Person person;

  const PersonDetailPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: person.profilePath.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${person.profilePath}',
                        height: 300,
                      )
                    : const Icon(Icons.person, size: 100),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Name: ${person.name}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Known For:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...person.knownFor.map((item) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    ListTile(
                      title: Text(
                          'title :${item['title'] ?? item['name'] ?? 'Unknown'}'),
                      subtitle: Text(
                          'mediatype : ${item['media_type'] ?? 'Unknown'}'),
                      leading: Image(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${item['poster_path']}')),
                    ),
                    Text(
                        //item['backdrop_path']

                        '-> overview :${item['overview'] ?? item['overview'] ?? 'Unknown'}'),
                    Text(
                        '-> language :${item['original_language'] ?? item['original_language'] ?? 'Unknown'}'),
                    Text(
                        '-> popularity :${item['popularity'] ?? item['popularity'] ?? 'Unknown'}'),
                    Text(
                        '-> release_date :${item['release_date'] ?? item['release_date'] ?? 'Unknown'}'),
                    Text(
                        '-> vote_average :${item['vote_average'] ?? item['vote_average'] ?? 'Unknown'}'),
                    const Divider(
                      thickness: 4,
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
