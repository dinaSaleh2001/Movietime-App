class Person {
  final int id;
  final String name;
  final String profilePath;
  final List<dynamic> knownFor;

  Person({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.knownFor,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      knownFor: json['known_for'],
    );
  }
}

class PersonResponse {
  final List<Person> results;

  PersonResponse({required this.results});

  factory PersonResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Person> personList = list.map((i) => Person.fromJson(i)).toList();

    return PersonResponse(results: personList);
  }
}