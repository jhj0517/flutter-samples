import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/home_provider.dart';
import '../../../../data/models/models.dart';

class MemoInputField extends StatefulWidget {
  const MemoInputField({super.key});

  @override
  MemoInputFieldState createState() => MemoInputFieldState();
}

class MemoInputFieldState extends State<MemoInputField> {
  final _memoController = TextEditingController();

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _memoController,
      decoration: InputDecoration(
          labelText: 'Enter Your Memo',
          suffixIcon: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (_memoController.text.isNotEmpty) {
                final homeProvider = Provider.of<HomeProvider>(context, listen: false);
                homeProvider.addMemo(Memo(
                    content: _memoController.text,
                    isImportant: false  // Assuming 'isImportant' is a field you want to include
                ));
                _memoController.clear();
              }
            },
          )
      ),
    );
  }
}