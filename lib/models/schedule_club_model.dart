class ScheduleClubModel {
  String id;
  String idClub;
  String idCaptain;
  String idCity;
  String idDistrict;
  String startTime;
  String endTime;
  String nameClub;
  String phone;
  String photoUrl;
  String typeField;

  ScheduleClubModel.fromJson(var value) {
    this.id = value['id'];
    this.idClub = value['idClub'];
    this.idCaptain = value['idCaptain'];
    this.idCity = value['idCity'];
    this.idDistrict = value['idDistrict'];
    this.startTime = value['startTime'];
    this.endTime = value['endTime'];
    this.nameClub = value['nameClub'];
    this.phone = value['phone'];
    this.photoUrl = value['photoUrl'];
    this.typeField = value['typeField'];
  }
}
