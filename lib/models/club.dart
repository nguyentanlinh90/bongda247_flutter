class ClubModel {
  final String id;
  final String user;
  final String photo;
  final String name;
  final String captionName;
  final String email;
  final String phone;
  final String dob;
  final String address;
  final String idCity;
  final String idDistrict;
  final String matchWin;
  final String matchLose;
  final String countRating;
  final String rating;
  final List<dynamic> players;
  final List<dynamic> comments;

  ClubModel(
      {this.id,
      this.user,
      this.photo,
      this.name,
      this.captionName,
      this.email,
      this.phone,
      this.dob,
      this.address,
      this.idCity,
      this.idDistrict,
      this.matchWin,
      this.matchLose,
      this.countRating,
      this.rating,
      this.players,
      this.comments});

  ClubModel.fromJson(Map<dynamic, dynamic> value)
      : this.id = value['id'],
        this.user = value['user'],
        this.photo = value['photo'],
        this.name = value['name'],
        this.captionName = value['captionName'],
        this.email = value['email'],
        this.phone = value['phone'],
        this.dob = value['dob'],
        this.address = value['address'],
        this.idCity = value['idCity'],
        this.idDistrict = value['idDistrict'],
        this.matchWin = value['matchWin'],
        this.matchLose = value['matchLose'],
        this.countRating = value['countRating'],
        this.rating = value['rating'],
        this.players = value['players'],
        this.comments = value['comments'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user,
        'photo': photo,
        'name': name,
        'captionName': captionName,
        'email': email,
        'phone': phone,
        'dob': dob,
        'address': address,
        'idCity': idCity,
        'idDistrict': idDistrict,
        'matchWin': matchWin,
        'matchLose': matchLose,
        'countRating': countRating,
        'rating': rating,
        'players': players,
        'comments': comments
      };

//  setAmountPlayer() async {
//    amountPlayer = players.length.toString();
//    amountPlayer = '2';
//  }
}
