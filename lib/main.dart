import 'dart:io';
import 'package:attendance/providers/absent_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'providers/attendance_provider.dart';
import 'providers/user_provider.dart';
import 'router/router.dart' as RouterGen;
import 'services/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? null
        : FirebaseOptions(
            apiKey: "AIzaSyDf7TmkYnENtzK7ur4uCoQdXrOSUW7_dBY",
            authDomain: "sdn-sukakerta-03.firebaseapp.com",
            appId: "1:839385234241:web:a387327c8f7992c5a2ffc0",
            storageBucket: "sdn-sukakerta-03.appspot.com",
            messagingSenderId: "839385234241",
            projectId: "sdn-sukakerta-03",
            measurementId: "G-Y83KX13012",
          ),
  );
  initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
        ChangeNotifierProvider(create: (_) => AbsentProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: blue,
          backgroundColor: Color(0xFFFBFCFD),
          bottomAppBarColor: Color(0xFFBD202E),
          scaffoldBackgroundColor: Color(0xFFFBFCFD),
          fontFamily: GoogleFonts.poppins().fontFamily,
          appBarTheme: AppBarTheme(
            titleTextStyle: poppinsWhitew600.copyWith(fontSize: 18),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            iconTheme: IconThemeData(color: white),
            centerTitle: true,
            color: blue,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10),
              minimumSize: Size(120, 40),
              primary: blue,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
              textStyle: poppinsWhitew500.copyWith(fontSize: 16),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10),
              minimumSize: Size(120, 40),
              primary: blue,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
              side: BorderSide(color: blue),
              textStyle: poppinsBluew500.copyWith(fontSize: 16),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: white,
            contentPadding: EdgeInsets.all(12),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[400],
            ),
            floatingLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: blue,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blue),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: blue),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: red),
            ),
          ),
          hintColor: Colors.grey[400],
        ),
        onGenerateRoute: RouterGen.Router.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Absensi Online',
      ),
    );
  }
}
