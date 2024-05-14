import 'package:flutter/material.dart';

import '../../data/models/models.dart';
import '../../data/repositories/memo_repository.dart';
import '../../data/repositories/binance_repository.dart';

class HomeProvider extends ChangeNotifier {

  HomeProvider({
    required this.memoRepository,
    required this.binanceRepository
  });

  final MemoRepository memoRepository;
  final BinanceRepository binanceRepository;

  List<Memo> _memos = [];
  List<Memo> get memos => _memos;

  OrderBookResponse? _response;
  OrderBookResponse? get response => _response;

  Future<void> readMemos() async {
    _memos = await memoRepository.readMemos();
    notifyListeners();
  }

  Future<void> addMemo(Memo memo) async {
    await memoRepository.addMemo(memo);
    _memos.add(memo);
    notifyListeners();
  }

  Future<void> deleteMemo(Memo memo) async {
    await memoRepository.deleteMemo(memo);
    _memos.remove(memo);
    notifyListeners();
  }

  Future<void> updateMemo(Memo memo) async {
    await memoRepository.updateMemo(memo);
    int index = _memos.indexWhere((m) => m.id == memo.id);
    if (index != -1) {
      _memos[index] = memo;
    }
    notifyListeners();
  }

  Future<void> fetchOrderBook({required String symbol, int? limit}) async{
    _response = await binanceRepository.fetchOrderBooks(symbol: symbol, limit: limit);
    notifyListeners();
  }
}