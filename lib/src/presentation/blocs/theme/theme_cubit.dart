import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final box = await Hive.openBox('settings');
    final isDarkMode = box.get('isDarkMode', defaultValue: false) as bool;
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newTheme);
    final box = await Hive.openBox('settings');
    await box.put('isDarkMode', newTheme == ThemeMode.dark);
  }
}