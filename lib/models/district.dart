class DistrictModel {
  final String id;
  final String name;

  DistrictModel({this.id, this.name});

  DistrictModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
