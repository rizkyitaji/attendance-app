import 'package:attendance/providers/login_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'router/router.dart' as RouterGen;
import 'services/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: blue,
          backgroundColor: Color(0xFFFBFCFD),
          bottomAppBarColor: Color(0xFFBD202E),
          scaffoldBackgroundColor: Color(0xFFFBFCFD),
          appBarTheme: AppBarTheme(
            titleTextStyle: fontWhite18,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            color: blue,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10),
              minimumSize: Size(120, 40),
              primary: blue,
              onPrimary: white,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
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
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: white,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black45,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusColor: blue,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[300]!,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[300]!,
              ),
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
          hintColor: Colors.black45,
        ),
        onGenerateRoute: RouterGen.Router.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Absensi Online',
      ),
    );
  }
}
