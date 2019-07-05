class SoccerFieldModel {
//  String id;
  String address;
  String amountField;
  String countRating;
  String idCity;
  String idDistrict;
  String lat;
  String lng;
  String name;
  String phone;
  String phone2;
  String photoUrl;
  String price;
  String priceMax;
  String rating;

  SoccerFieldModel.fromJson(var value) {
//    this.id = value['id'];
    this.address = value['address'];
    this.amountField = value['amountField'];
    this.countRating = value['countRating'];
    this.idCity = value['idCity'];
    this.idDistrict = value['idDistrict'];
    this.lat = value['lat'];
    this.lng = value['lng'];
    this.name = value['name'];
    this.phone = value['phone'];
    this.phone2 = value['phone2'];
    this.photoUrl = value['photoUrl'];
    this.price = value['price'];
    this.priceMax = value['priceMax'];
    this.rating = value['rating'];
  }
}
