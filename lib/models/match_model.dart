class MatchModel {
  String id;
  String idUser;
  String typeMatch;
  String typeField;
  String city;
  String district;
  String from;
  String to;
  String name;
  String phone;
  String photo;

  MatchModel(this.id,this.idUser, this.typeMatch, this.typeField, this.city,
      this.district, this.from, this.to, this.name, this.phone, this.photo);

  MatchModel.fromJson(var value) {
    this.id = value['id'];
    this.idUser = value['idUser'];
    this.typeMatch = value['typeMatch'];
    this.typeField = value['typeField'];
    this.city = value['city'];
    this.district = value['district'];
    this.from = value['from'];
    this.to = value['to'];
    this.name = value['name'];
    this.phone = value['phone'];
    this.photo = value['photo'];
  }

  toJson() {
    return {
      "id": id,
      "idUser": idUser,
      "typeMatch": typeMatch,
      "typeField": typeField,
      "city": city,
      "district": district,
      "from": from,
      "to": to,
      "name": name,
      "phone": phone,
      "photo": photo
    };
  }
}
