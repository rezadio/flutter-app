// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    ack: json['ACK'] as String,
    dataMessage: (json['dataMessage'] as List<dynamic>)
        .map((e) => DataMessage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'ACK': instance.ack,
      'dataMessage': instance.dataMessage,
    };

DataMessage _$DataMessageFromJson(Map<String, dynamic> json) {
  return DataMessage(
    img: json['img'] as String,
    statusRead: json['status_read'] as bool,
    statusSend: json['status_send'] as bool,
    title: json['title'] as String,
    body: json['body'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$DataMessageToJson(DataMessage instance) =>
    <String, dynamic>{
      'img': instance.img,
      'status_read': instance.statusRead,
      'status_send': instance.statusSend,
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
    };
