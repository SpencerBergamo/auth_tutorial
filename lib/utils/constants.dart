import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constants {
  static const boundryEdges = EdgeInsets.symmetric(horizontal: 20.0);
  static const TextStyle errorStyle =
      TextStyle(color: Colors.red, fontSize: 14.0);
  static const TextStyle linkStyle =
      TextStyle(color: Colors.blue, fontSize: 16.0);

  static const searchIcon = FaIcon(FontAwesomeIcons.magnifyingGlass);
  static const drawerIcon = FaIcon(FontAwesomeIcons.bars);
  static const folderIcon = FaIcon(FontAwesomeIcons.folder);
  static const qrCodeIcon = FaIcon(FontAwesomeIcons.qrcode);
  static const photoIcon = FaIcon(FontAwesomeIcons.image);
  static const profileIcon = FaIcon(
    FontAwesomeIcons.user,
    size: 100,
  );

  // Textfield icons
  static const emailIcon = FaIcon(
    FontAwesomeIcons.envelope,
    size: 20,
  );
  static const passwordIcon = FaIcon(
    FontAwesomeIcons.lock,
    size: 20,
  );
  static const nameIcon = FaIcon(
    FontAwesomeIcons.user,
    size: 20,
  );
  static const usernameIcon = FaIcon(
    FontAwesomeIcons.person,
    size: 20,
  );
  static const phoneIcon = FaIcon(
    FontAwesomeIcons.phone,
    size: 20,
  );
  static const eyeShow = FaIcon(
    FontAwesomeIcons.eye,
    size: 20,
  );
  static const eyeHide = FaIcon(
    FontAwesomeIcons.eyeSlash,
    size: 20,
  );

  static Image appIcon = Image.asset('lib/presentation/images/s-logo-2.png',
      height: 100, width: 100);
  static Image appleIcon =
      Image.asset('lib/presentation/images/apple.png', height: 40, width: 40);
  static Image googleIcon =
      Image.asset('lib/presentation/images/google.png', height: 40, width: 40);
}
