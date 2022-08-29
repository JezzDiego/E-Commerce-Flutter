import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/user.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<User> _users = [];
  late UserDataSource userDataSource;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUsers();
  }

  Future getUsers() async {
    var data = await FirebaseFirestore.instance.collection("users").get();

    setState(() {
      _users = List.from(data.docs.map((doc) {
        return User.fromSnapshot(doc);
      }));
      userDataSource = UserDataSource(users: _users);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Expanded(
        child: SfDataGrid(
          source: userDataSource,
          columns: <GridColumn>[
            GridColumn(
                columnName: 'name',
                label: Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Name',
                    ))),
            GridColumn(
                columnName: 'email',
                label: Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Email'))),
            GridColumn(
                columnName: 'phoneNumber',
                width: 120,
                label: Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.centerLeft,
                    child: Text('PhoneNumber'))),
          ],
        ),
      ),
    ));
  }
}

class UserDataSource extends DataGridSource {
  UserDataSource({required List<User> users}) {
    _users = users
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(
                  columnName: 'phoneNumber', value: e.phoneNumber),
            ]))
        .toList();
  }

  List<DataGridRow> _users = [];

  @override
  List<DataGridRow> get rows => _users;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'email' ||
                dataGridCell.columnName == 'name')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
