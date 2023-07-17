import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todos/src/models/todo_list.dart';

class SharedPreferencesProvider {
  late SharedPreferences shared;

  Future init() async {
    shared = await SharedPreferences.getInstance();
  }

  Option<String> getString(String key) {
    return optionOf(shared.getString(key));
  }

  Task saveString(String key, String value) {
    return Task(() async {
      await shared.setString(key, value);
    });
  }

  Task removeString(String key) {
    return Task(() async {
      await shared.remove(key);
    });
  }

  Either<String, T> getJson<T>(String key) {
    return optionOf(shared.getString(key))
        .map((String source) {
          try {
            return right((jsonDecode(source)));
          } catch (e) {
            return left(e.toString());
          }
        })
        .getOrElse(() => left('No value for key $key'))
        .fold((l) => left(l), (r) => right(r));
  }

  Task<Either<String, void>> saveJson<T>(String key, T value) {
    return Task(() async {
      try {
        await shared.setString(key, jsonEncode(value));
        return right(null);
      } catch (e) {
        return left(e.toString());
      }
    });
  }
}
