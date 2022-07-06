class University {
  String alphaTwocode;
  List<dynamic> domains;
  List<dynamic> webPages;
  String country;
  String? stateProvidence;
  String? imageUrl;
  String? name;
  int? numbersOfStudents;

  University(
      {required this.alphaTwocode,
      required this.webPages,
      required this.domains,
      required this.country,
      required this.name,
      required this.stateProvidence});

  factory University.fromJson(Map data) {
    return University(
        alphaTwocode: data["alpha_two_code"],
        stateProvidence: data["state-province"],
        country: data["country"],
        webPages: data["web_pages"],
        name: data["name"],
        domains: data["domains"]);
  }
}
