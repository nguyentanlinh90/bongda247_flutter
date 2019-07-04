class ClubModel {
  final String id;

//  String idCaptain;
  final String photo;
  final String name;

  String captionName;

//  String email;
  final String phone;

//  String dob;
//  String address;
  final String idCity;
  final String idDistrict;

//  String matchWin;
//  String matchLose;
//  String countRating;
//  String rating;
//  List<dynamic> players;
//  List<dynamic> comments;
//  dynamic user;

  ClubModel(this.id, this.photo, this.name, this.captionName, this.phone,
      this.idCity, this.idDistrict);

  ClubModel.fromJson(Map<String, dynamic> value)
      : this.id = value['id'],
//        this.idCaptain = value['idCaptain'],
        this.photo = value['photo'],
        this.name = value['name'],
        this.captionName = value['captionName'],
//        this.email = value['email'],
        this.phone = value['phone'],
//        this.dob = value['dob'],
//        this.address = value['address'],
        this.idCity = value['idCity'],
        this.idDistrict = value['idDistrict'];

//        this.matchWin = value['matchWin'],
//        this.matchLose = value['matchLose'],
//        this.countRating = value['countRating'],
//        this.rating = value['rating'],
//        this.players = value['players'],
//        this.comments = value['comments'],
//        this.user = value['user'];

  Map<String, dynamic> toJson() => {
        'id': id,
//        'idCaptain': idCaptain,
        'photo': photo,
        'name': name,
        'captionName': captionName,
//        'email': email,
        'phone': phone,
//        'dob': dob,
//        'address': address,
        'idCity': idCity,
        'idDistrict': idDistrict
//        'matchWin': matchWin,
//        'matchLose': matchLose,
//        'countRating': countRating,
//        'rating': rating,
//        'players': players,
//        'comments': comments,
//        'user': user
      };

  String amountPlayer;

  setAmountPlayer() async {
//    amountPlayer = players.length.toString();
    amountPlayer = '2';
  }
}
