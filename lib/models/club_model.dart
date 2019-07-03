class ClubModel {
  final String id;
  final String idCaptain;
  final String photo;
  final String name;
  final String caption;
  final String email;
  final String phone;
  final String dob;
  final String address;
  final String idDistrict;
  final String idCity;
  final String matchWin;
  final String matchLose;
  final String countRating;
  final String rating;
  final List<dynamic> players;
  final List<dynamic> comments;
  final dynamic user;



  ClubModel.fromJson(Map<String, dynamic> value)
      : this.id = value['id'],
        this.idCaptain = value['idCaptain'],
        this.photo = value['photo'],
        this.name = value['name'],
        this.caption = value['caption'],
        this.email = value['email'],
        this.phone = value['phone'],
        this.dob = value['dob'],
        this.address = value['address'],
        this.idDistrict = value['idDistrict'],
        this.idCity = value['idCity'],
        this.matchWin = value['matchWin'],
        this.matchLose = value['matchLose'],
        this.countRating = value['countRating'],
        this.rating = value['rating'],
        this.players = value['players'],
        this.comments = value['comments'],
        this.user = value['user'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'idCaptain': idCaptain,
        'photo': photo,
        'name': name,
        'caption': caption,
        'email': email,
        'phone': phone,
        'dob': dob,
        'address': address,
        'idDistrict': idDistrict,
        'idCity': idCity,
        'matchWin': matchWin,
        'matchLose': matchLose,
        'countRating': countRating,
        'rating': rating,
        'players': players,
        'comments': comments,
        'user': user
      };

  String amountPlayer;

  setAmountPlayer() async {
    amountPlayer = players.length.toString();
  }
}
