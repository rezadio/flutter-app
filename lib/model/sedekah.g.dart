// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sedekah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sedekah _$SedekahFromJson(Map<String, dynamic> json) {
  return Sedekah(
    ack: json['ACK'] as String,
    dataList: (json['dataList'] as List<dynamic>)
        .map((e) => DataSedekah.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SedekahToJson(Sedekah instance) => <String, dynamic>{
      'ACK': instance.ack,
      'dataList': instance.dataList,
    };

DataSedekah _$DataSedekahFromJson(Map<String, dynamic> json) {
  return DataSedekah(
    merchantPhone: json['merchantPhone'] as String,
    merchantId: json['merchantId'] as int,
    merchantLogo: json['merchantLogo'] as String?,
    merchantName: json['merchantName'] as String,
    donasiProgramId: json['donasiProgramId'] as int?,
    programName: json['programName'] as String?,
    programLogo: json['programLogo'] as String?,
    programId: json['programId'] as int?,
  );
}

Map<String, dynamic> _$DataSedekahToJson(DataSedekah instance) =>
    <String, dynamic>{
      'merchantPhone': instance.merchantPhone,
      'merchantId': instance.merchantId,
      'merchantLogo': instance.merchantLogo,
      'merchantName': instance.merchantName,
      'donasiProgramId': instance.donasiProgramId,
      'programName': instance.programName,
      'programLogo': instance.programLogo,
      'programId': instance.programId,
    };
