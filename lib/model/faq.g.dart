// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqResponse _$FaqResponseFromJson(Map<String, dynamic> json) {
  return FaqResponse(
    ack: json['ACK'] as String,
    pesan: json['pesan'] as String,
    data: (json['data'] as List<dynamic>)
        .map((e) => Faq.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FaqResponseToJson(FaqResponse instance) =>
    <String, dynamic>{
      'ACK': instance.ack,
      'pesan': instance.pesan,
      'data': instance.data,
    };

Faq _$FaqFromJson(Map<String, dynamic> json) {
  return Faq(
    id: json['id'] as int,
    urutan: json['urutan'] as int,
    pertanyaan: json['pertanyaan'] as String,
    jawaban: json['jawaban'] as String,
  );
}

Map<String, dynamic> _$FaqToJson(Faq instance) => <String, dynamic>{
      'id': instance.id,
      'urutan': instance.urutan,
      'pertanyaan': instance.pertanyaan,
      'jawaban': instance.jawaban,
    };
