class SchedulePlayerModel {
  String id;
  String idCity;
  String idDistrict;
  String startTime;
  String endTime;
  String idPlayer;
  String namePlayer;
  String phonePlayer;
  String photoUrlPlayer;
  String typeField;

  SchedulePlayerModel.fromJson(var value) {
    this.id = value['id'];
    this.idCity = value['idCity'];
    this.idDistrict = value['idDistrict'];
    this.startTime = value['startTime'];
    this.endTime = value['endTime'];
    this.idPlayer = value['idPlayer'];
    this.namePlayer = value['namePlayer'];
    this.phonePlayer = value['phonePlayer'];
    this.photoUrlPlayer = value['photoUrlPlayer'];
    this.typeField = value['typeField'];
  }
}
