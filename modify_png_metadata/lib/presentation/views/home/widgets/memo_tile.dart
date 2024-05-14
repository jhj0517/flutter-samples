import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/models.dart';
import '../../../providers/home_provider.dart';

class MemoTile extends StatelessWidget {
  final Memo memo;

  const MemoTile({
    super.key,
    required this.memo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Name: ${memo.content}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          final homeProvider = Provider.of<HomeProvider>(context, listen: false);
          homeProvider.deleteMemo(memo);
        }
      ),
    );
  }
}