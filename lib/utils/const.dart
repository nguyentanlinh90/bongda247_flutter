import 'package:flutter/material.dart';

class Const {
  //check mode
  static const bool kReleaseMode =
      bool.fromEnvironment('dart.vm.product', defaultValue: false);

  //routes
  static const String rootRoute = "/root";
  static const String mainRoute = "/main";
  static const String insertMatchRoute = "/insertMatch";

  //strings
  static const String appName = "Bóng Đá Phủi";
  static const String start = "Bắt Đầu";
  static const String signUp = "Đăng Ký";
  static const String countField = "Số lượng sân";
  static const String priceAVG = "Giá trung bình";
  static const String notUpdate = "Chưa cập nhật";
  static const String threeDot = "...";
  static const String selectPhone = "Chọn số để gọi";
  static const String cancel = "Huỷ";
  static const String call = "Gọi";
  static const String end = "Kết thúc";
  static const String contact = "Liên hệ";
  static const String contact_ = "Liên hệ:  ";
  static const String typeField = "Loại sân:  ";
  static const String fivePeoPle = "5 người";
  static const String sevenPeoPle = "7 người";
  static const String elevenPeoPle = "11 người";
  static const String countPlayer = "Số cầu thủ";
  static const String captain = "Đội trưởng:  ";
  static const String area = "Khu vực:  ";
  static const String insertSchedulePlayer = "Thêm lịch đá muốn thi đấu";
  static const String yourName = "Tên của bạn";
  static const String fullName = "Họ và tên";
  static const String nameClub = "Tên đội bóng";
  static const String phoneNumber = "Số điện thoại";
  static const String emailAddress = "Địa chỉ email";
  static const String password = "Mật khẩu";
  static const String createNewAccount = "Tạo tài khoản";
  static const String watchSchedule = "Xem lịch đấu";
  static const String insertSchedule = "Thêm lịch đấu";
  static const String noData = "Không có dữ liệu";
  static const String timeSlot = "Khung thời gian đá được: ";
  static const String timeNote = "(* Giờ kết thúc phải lớn hơn giờ băt đầu)";
  static const String timeSlotStart = "Khung giờ bắt đầu";
  static const String timeSlotEnd = "Khung giờ kết thúc";
  static const String change = "Thay đổi";
  static const String choose = "Chọn";
  static const String or = "Hoặc";
  static const String from = "Từ:  ";
  static const String to = "Đến:  ";
  static const String alert = "Thông báo!";
  static const String timeNotValid = "Thời gian không hợp lệ";
  static const String close = "Đóng";
  static const String yes = "Có";
  static const String no = "Không";
  static const String register = "Đăng ký";
  static const String signIn = "Đăng nhập";
  static const String logout = "Đăng xuất";
  static const String registerFail = "Đăng ký thất bại";
  static const String loginFail = "Đăng nhập thất bại";
  static const String signInWithGoogle = "Đăng nhập với Google";
  static const String signInWithFacebook = "Đăng nhập với Facebook";
  static const String youNeedLogin = "Bạn cần đăng nhập để thực hiện chức năng này";
  static const String youWantSignOut = "Bạn chắc chăn muốn đăng xuất tài khoản này không?";
  static const String insertMatchSuccess = "Thêm lịch thi đấu thành công";
  static const String insertMatchFail = "Có lỗi khi thêm lịch thi đấu";

  //string data
  static const String signInData = "signInData";
  static const String signInSuccess = "signInSuccess";

  //colors
  static List<Color> kitGradients = [
    Colors.blueGrey.shade800,
    Colors.black87,
  ];

  //fonts
  static const String openSansFont = "OpenSans";
  static const String ralewayFont = "Raleway";
  static const String quickBoldFont = "Quicksand_Bold.otf";
  static const String quickNormalFont = "Quicksand_Book.otf";
  static const String quickLightFont = "Quicksand_Light.otf";

  //json
  static const String jsonCity = "assets/json/json_city.json";

  //images
  static const String imageDir = "assets/images";
  static const String icLauncher = "$imageDir/ic_launcher.png";
  static const String icSplash = "$imageDir/ic_splash.png";
  static const String icPlaying = "$imageDir/playing.png";
  static const String icDefault = "$imageDir/default.png";

  //Size
  static const double size_2 = 2.0;
  static const double size_5 = 5.0;
  static const double size_8 = 8.0;
  static const double size_10 = 10.0;
  static const double size_12 = 12.0;
  static const double size_14 = 14.0;
  static const double size_15 = 15.0;
  static const double size_16 = 16.0;
  static const double size_20 = 20.0;
  static const double size_22 = 22.0;
  static const double size_24 = 24.0;
  static const double size_25 = 25.0;
  static const double size_30 = 30.0;
  static const double size_32 = 32.0;
  static const double size_35 = 35.0;
  static const double size_40 = 40.0;
  static const double size_50 = 50.0;
  static const double size_60 = 60.0;
  static const double size_70 = 70.0;
  static const double size_100 = 100.0;

  //SharedPreferences
  static const String seenTutorialPrefs = "seenTutorial";

  //FireBase Collection
  static const String tutorialCollection = "tutorial";
  static const String usersCollection = kReleaseMode ? "users" : "users_dev";
  static const String fieldsCollection = kReleaseMode ? "fields" : "fields";
  static const String matchCollection = kReleaseMode ? "match" : "match_dev";
  static const String scheduleClubCollection =
      kReleaseMode ? "schedule_club" : "dev_schedule_club";
  static const String clubCollection = kReleaseMode ? "clubs" : "dev_clubs";
}
