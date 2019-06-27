class MatchModel {
  String idCreate;
  String typeMatch;
  String typeField;
  String city;
  String district;
  String from;
  String to;
  String name;
  String phone;
  String photo;

  MatchModel(this.idCreate, this.typeMatch, this.typeField, this.city,
      this.district, this.from, this.to, this.name, this.phone, this.photo);

  MatchModel.fromJson(var value) {
    this.idCreate = value['idCreate'];
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
      "idCreate": idCreate,
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

class EnumTypeMatch {
  final _value;

  const EnumTypeMatch._internal(this._value);

  toString() => _value;

  static const player = const EnumTypeMatch._internal('1');
  static const club = const EnumTypeMatch._internal('2');
}
