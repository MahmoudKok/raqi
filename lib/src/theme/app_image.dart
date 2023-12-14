// ignore_for_file: non_constant_identifier_names

class AppImages {
  static String apple = 'apple.png'.imageAssetPath;
  static String buisness = 'buisness.png'.imageAssetPath;
  static String tesla = 'tesla.png'.imageAssetPath;
  static String wall_street = 'wall_street.png'.imageAssetPath;
  static String error = 'error.png'.imageAssetPath;
  static String no_internet = 'no-connection.png'.imageAssetPath;
  static String empty = 'empty.jpg'.imageAssetPath;
  static String imageHolder = 'imageholder.png'.imageAssetPath;
}

extension ImageExtension on String {
  String get imageAssetPath => 'assets/images/$this';
}
