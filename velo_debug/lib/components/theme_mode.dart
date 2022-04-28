import 'package:flutter/material.dart';


const String family = "Futura";

const TextStyle fontStyle = TextStyle(
  fontFamily: family,
  fontWeight: FontWeight.w300,
);
class ThemeProvider extends ChangeNotifier{
  ThemeData current = ThemeModeSet.standard;

  void toggleTheme(ThemeData theme){
    current = theme;
    notifyListeners();
  }
}
class ThemeModeSet{
  static final standard = ThemeData(
    primaryColor: Color(0xFFFFE8D6),
    backgroundColor: Color(0xFF15232B),
    accentColor: Color(0xFFFF4D19),
    textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Color(0xFF333333),
        )
    ),
    primarySwatch: Colors.orange,
  );
  static final pastel = ThemeData(
    primaryColor: Color(0xFFFCFCF0),
    backgroundColor: Color(0xFF969696),
    accentColor: Color(0xFFFFD6A5),
    textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Color(0xFF333333),
        )
    ),
    primarySwatch: Colors.orange,

  );
  static final pip = ThemeData(
    primaryColor: Color(0xFFFCFCF0),
    backgroundColor: Color(0xFFCECEF0),
    accentColor: Color(0xFFF03793),
    textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Color(0xFF333333),
        )
    ),

  );
  static final deuteranopia = ThemeData(
    primaryColor: Color(0xFFF6F8DB),
    backgroundColor: Color(0xFF1A1928),
    accentColor: Color(0xFFBCC928),
    textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Color(0xFF333333),
        )
    ),
    primarySwatch: Colors.orange,
  );
  static final tritopia = ThemeData(
    primaryColor: Color(0xFFFDDDDE),
    backgroundColor: Color(0xFF152727),
    accentColor: Color(0xFFF62F31),
    textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Color(0xFF333333),
        )
    ),
    primarySwatch: Colors.orange,
  );
  static final protanopia = ThemeData(
    primaryColor: Color(0xFFF5F4DA),
    backgroundColor: Color(0xFF1B1B29),
    accentColor: Color(0xFFB1B025),
    textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Color(0xFF333333),
        )
    ),
    primarySwatch: Colors.orange,
  );
  static final proanomaly = ThemeData(
    primaryColor: Color(0xFFFAEFD8),
    backgroundColor: Color(0xFF171E2A),
    accentColor: Color(0xFFDE881F),
    textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Color(0xFF333333),
        )
    ),
    primarySwatch: Colors.orange,
  );
}
