import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';

class EmployeeService {
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('karyawan_list');

  Stream<Map<String, String>> getShoppingList() {
    return _database.onValue.map((event) {
      final Map<String, String> items = {};
      DataSnapshot snapshot = event.snapshot;
      print('Snapshot data:${snapshot.value}');
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items[key] = value['name'] as String;
          items[key] = value['position'] as String;

        });
      }
      return items;
    });
  }

  void addEmployeeList(String itemName, itemPosition) {
    _database.push().set({'name': itemName});
    _database.push().set({'position': itemPosition});
  }

  Future<void> removeEmployeeList(String key) async {
    await _database.child(key).remove();
  }
}