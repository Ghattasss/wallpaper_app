import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/cubits/categorycubit/category_cubit.dart';
import 'package:wallpaper_app/cubits/homecubit/home_cubit.dart';
import 'package:wallpaper_app/pages/home_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => HomeCubit()..getTrendingWallpapers(),
      ),
      BlocProvider(
        create: (context) => CategoryCubit(),
      ),
    ],
    child: WallpaperApp(),
  ));
}

class WallpaperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: WallpaperHome(),
    );
  }
}
//wvq8Er2DAxJHrHpIDGKfMUnh4viXWOtc1O2TxUxZAQ9tqqreAzawiY86
