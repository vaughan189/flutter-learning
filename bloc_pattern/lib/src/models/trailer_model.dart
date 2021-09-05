class TrailerModel {
  int id;
  List<Result> results = [];

  TrailerModel({required this.id, required this.results});

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    List<Result> temp = [];
    for (int i = 0; i < json['results'].length; i++) {
      Result result = Result(json['results'][i]);
      temp.add(result);
    }
    return TrailerModel(
      id: json['id'],
      results: temp,
    );
  }

  List<Result> get getResults => results;
  int get getId => id;
}

class Result {
  String? id;
  String? iso_639_1;
  String? iso_3166_1;
  String? key;
  late String name;
  String? site;
  int? size;
  String? type;

  Result(result) {
    id = result['id'];
    iso_639_1 = result['iso_639_1'];
    iso_3166_1 = result['iso_3166_1'];
    key = result['key'];
    name = result['name'];
    site = result['site'];
    size = result['size'];
    type = result['type'];
  }

  String? get getId => id;

  String? get getIso_639_1 => iso_639_1;

  String? get getIso_3166_1 => iso_3166_1;

  String? get getKey => key;

  String? get getName => name;

  String? get getSite => site;

  int? get getSize => size;

  String? get getType => type;
}
