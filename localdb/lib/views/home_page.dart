import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../localdb/my_db.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late MyDB db;
  List<User> _users = [];

  // Text Editing Controllers for user input
  final _userNameController = TextEditingController();
  final _userIdController = TextEditingController();
  final _profileURLController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = context.read<MyDB>();
    _getUsers();
  }

  Future<void> _getUsers() async {
    _users = await db.getAllUsers();
    setState(() {});
  }

  Future<void> _addUser() async {
    final user = User(
      userId: _userIdController.text,
      name: _userNameController.text,
      profileUrl: _profileURLController.text,
      isSubscribed: false,
    );

    await db.insertUser(user);
    // refresh Users
    _getUsers();

    // Clear text fields after successful insertion (optional)
    _userIdController.text = '';
    _userNameController.text = '';
    _profileURLController.text = '';
  }

  Future<void> _deleteUser(User user) async {
    await db.deleteUser(user);
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Database Example'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          // User input section
          TextField(
            controller: _userNameController,
            decoration: const InputDecoration(labelText: 'User Name'),
          ),
          TextField(
            controller: _userIdController,
            decoration: const InputDecoration(labelText: 'User ID'),
          ),
          TextField(
            controller: _profileURLController,
            decoration: const InputDecoration(labelText: 'Profile URL'),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: _addUser,
            child: const Text('Add User'),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  title: Text('Name: ${user.name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('ID: ${user.userId}'),
                      Text('Profile URL: ${user.profileUrl}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteUser(user)
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

