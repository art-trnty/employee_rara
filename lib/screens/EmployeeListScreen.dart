import 'package:employee_rara/services/EmployeeService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPosition = TextEditingController();
  final EmployeeService _employeeService = EmployeeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Karyawan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllerName,
                    decoration:
                    const InputDecoration(hintText: 'Nama Karyawan'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _controllerPosition,
                    decoration:
                    const InputDecoration(hintText: 'Position Karyawan'),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _employeeService.addEmployeeList(_controllerName.text,_controllerPosition.text);
                    _controllerName.clear();
                    _controllerPosition.clear();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _employeeService.getShoppingList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, String> items = snapshot.data!;
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final key = items.keys.elementAt(index);
                      final item = items[key];
                      return ListTile(
                        title: Text(item!),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _employeeService.removeEmployeeList(key);
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}