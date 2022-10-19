import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(name: 'ACK')
  final String ack;
  final List<DataMessage> dataMessage;

  Message({required this.ack, required this.dataMessage});
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class DataMessage {
  final String img;
  @JsonKey(name: 'status_read')
  final bool statusRead;
  @JsonKey(name: 'status_send')
  final bool statusSend;
  final String title;
  final String body;
  final String type;

  DataMessage(
      {required this.img,
      required this.statusRead,
      required this.statusSend,
      required this.title,
      required this.body,
      required this.type});
  factory DataMessage.fromJson(Map<String, dynamic> json) =>
      _$DataMessageFromJson(json);
  Map<String, dynamic> toJson() => _$DataMessageToJson(this);
}
