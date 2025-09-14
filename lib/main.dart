

// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'firebase_options.dart';
// // import 'src/app.dart';

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// //   await Hive.initFlutter();
// //   // Open boxes
// //   await Hive.openBox('cart');
// //   await Hive.openBox('wishlist');
// //   await Hive.openBox('cache');

// //   runApp(const MyApp());
// // }


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'firebase_options.dart';
// import 'src/app.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   // Set transparent status bar
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarIconBrightness: Brightness.dark, // Dark icons for light background
//   ));

//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await Hive.initFlutter();
//   // Open boxes
//   await Hive.openBox('cart');
//   await Hive.openBox('wishlist');
//   await Hive.openBox('cache');

//   runApp(const MyApp());
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set transparent status bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  // Open boxes
  await Hive.openBox('cart');
  await Hive.openBox('wishlist');
  await Hive.openBox('cache');

  runApp(const MyApp());
}