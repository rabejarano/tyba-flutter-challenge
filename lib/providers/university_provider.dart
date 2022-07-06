import 'package:flutter/material.dart';
import 'package:tyba_flutter_challenge/models/university.dart';
import 'package:tyba_flutter_challenge/services/university.dart';

class UniversityProvider extends ChangeNotifier {
  List<University> universities = [];
  late String error;

  Future fetchUniversities() async {
    try {
      universities = await getUniversities();
    } catch (e) {
      e.toString();
    }
    notifyListeners();
  }
}
