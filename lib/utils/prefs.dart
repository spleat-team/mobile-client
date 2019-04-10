import 'package:shared_preferences/shared_preferences.dart';

final String _kUserPassedIntro = "passedIntro";

  Future<bool> getIfUserPassedIntro() async {
	  final SharedPreferences prefs = await SharedPreferences.getInstance();

  	return prefs.getBool(_kUserPassedIntro) ?? false;
  }

  Future<bool> setIfUserPassedIntro(bool value) async {
	  final SharedPreferences prefs = await SharedPreferences.getInstance();

	  return prefs.setBool(_kUserPassedIntro, value);
  }