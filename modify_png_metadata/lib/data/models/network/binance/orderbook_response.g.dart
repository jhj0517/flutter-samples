// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderbook_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBookResponse _$OrderBookResponseFromJson(Map<String, dynamic> json) =>
    OrderBookResponse(
      lastUpdateId: (json['lastUpdateId'] as num).toDouble(),
      bids: (json['bids'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      asks: (json['asks'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$OrderBookResponseToJson(OrderBookResponse instance) =>
    <String, dynamic>{
      'lastUpdateId': instance.lastUpdateId,
      'bids': instance.bids,
      'asks': instance.asks,
    };
