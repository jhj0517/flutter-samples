import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

part 'orderbook_response.g.dart';

// After specifying [part 'your_response.g.dart'], Run:
// dart pub run build_runner build

/// Example network response data class for the Binance order book. You can change it to your own.
/// API Documentation : https://binance-docs.github.io/apidocs/spot/en/#order-book

@JsonSerializable()
class OrderBookResponse{
  final double lastUpdateId;
  final List<List<String>> bids;
  final List<List<String>> asks;

  OrderBookResponse({
    required this.lastUpdateId,
    required this.bids,
    required this.asks
  });

  factory OrderBookResponse.fromJson(Map<String, dynamic> json) => _$OrderBookResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderBookResponseToJson(this);
}