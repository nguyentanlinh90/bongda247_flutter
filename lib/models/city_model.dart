class CityModel {
  final String id;
  final String name;
  final List<dynamic> districts;

  CityModel(this.id, this.name, this.districts);

  CityModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        districts = json['districts'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'districts': districts,
      };
}
