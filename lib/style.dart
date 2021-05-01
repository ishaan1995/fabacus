import 'dart:ui';

// dark theme
final Color inputBg = HexColor.fromHex('#2B3033');
final Color keysBg = HexColor.fromHex('#202125');
final Color advanceOperatorsBg = HexColor.fromHex('#164EA6');
final Color keys = HexColor.fromHex('#EAEAF0');

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

// dark theme 0x format colors
// const Color inputBg = Color(0x2B3033);
// const Color keysBg = Color(0x202125);
// const Color advanceOperatorsBg = Color(0x164EA6);
// const Color keys = Color(0xEAEAF0);

// light theme
// const Color inputBg = Color(0xFFFFFF);
// const Color keysBg = Color(0xF2F3F5);
// const Color advanceOperatorsBg = Color(0x1973E7);
// const Color keys = Color(0x242527);
