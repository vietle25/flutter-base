import 'package:flutter/material.dart';

class Colors {
  // Method get color from hex
  static Color getColorFromHex(String value) => _HexColor(value);

  // Color
  static const Color primary = Color(0xFF5436a1);
  static const Color primaryGradient = Color.fromRGBO(224, 107, 14, 0.7);
  static const Color orangeLight = Color(0xFFE78D45);
  static const Color black = Color(0xFF000000);
  static const Color blackLight = Color(0x8A000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteLight = Color.fromRGBO(255, 255, 255, 0.6);
  static const Color red = Color(0xFFFF0000);
  static const Color redLight = Color(0xFFE77878);
  static const Color blue = Color(0xFF0000FF);
  static const Color blueLight = Color(0xFF0091EA);
  static const Color green = Color(0xFF4CAF50);
  static const Color orangeDark = Color(0xFFF76B22);
  static const Color transparent = Color(0x00000000);
  static const Color background = Color(0xFF161B22);
  static const Color text = Color(0xffe5e5e5); // Color text default
  // static const Color textLight = Color(0xFF808992); // Using for text light
  static const Color textGrey =
      Color.fromRGBO(0, 0, 0, 0.38); // Using for text light
  static const Color textPlaceHolder =
      Color.fromRGBO(162, 162, 162, 0.7); // Text for input
  static const Color textLabel = Color(0xFF9E9E9E); // label text input
  static const Color shadow = Color.fromRGBO(158, 158, 158, 0.4);
  static const Color dark35Percent = Color(0x59000000);
  static const Color greyLight = Color(0xFFB3B3B3);
  static const Color darkGrey = Color(0xFF232933);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color disabled =
      Color.fromRGBO(0, 0, 0, 0.04); // Color text default
  static const Color bgMessageNo = Color(0xFFFDC991);
  static const Color bgAvatarChat = Color(0xFF044077);
  static const Color grey600 = Color.fromRGBO(212, 212, 212, 0.17);
  static const Color grey700 = Color(0xff444444);
  static const Color blue800 = Color(0xff162330);
  static const Color grey50 = Color(0xFFF2F2F2);
  static const Color grey200 = Color(0xFFD9D9D9);
  static const Color grey400 = Color(0xFF9D9D9D);
  static const Color grey500 = Color(0xFF7e7e7e);
  static const Color grey100 = Color(0xFFE9E9E9);
  static const Color blue50 = Color(0xFFE6E9F3);
  static const Color orange = Color(0xFFFF6600);
  static const Color orange500 = Color(0xFFF58D47);

  static const primaryLight = Color(0xFF2884a9);
  static const primaryDark = Color(0xFF1a6a8b);

  static const buttonDark = Color(0xff124e67);

  static const backgroundLight = Color(0xFFF5F5F7);
  static const backgroundDark = Color(0xFF1C2834);

  static const textLight = Color(0xFF262626);
  static const textDark = Color(0xFFF8F9FA);

  static const textHolderLight = Color.fromRGBO(162, 162, 162, 0.7);
  static const textHolderDark =
      Color.fromRGBO(215, 215, 215, 0.7019607843137254);

  static const blueGrey200 = Color(0xFF5B7482);
  static const blueGrey400 = Color(0xFF4B6472);
  static const blueGrey500 = Color(0xFF344855);
  static const blueGrey600 = Color(0xFF243845);
  static const blueGrey800 = Color(0xFF222F33);
}

// Parse hex to color.
class _HexColor extends Color {
  static int _getColorFromHex(hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  _HexColor(value) : super(_getColorFromHex(value));
}
