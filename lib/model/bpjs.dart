import 'package:json_annotation/json_annotation.dart';

part 'bpjs.g.dart';

@JsonSerializable()
class BPJS {
  final String tagihan;
  final String nama;
  final String biayaAdmin;
  final String hargaCetak;
  @JsonKey(name: 'ACK')
  final String ack;
  final String idTrx;
  final String reffId;
  final String periode;
  final String? idPelanggan;
  final String? namaAlias;

  BPJS(
      {required this.tagihan,
      required this.nama,
      required this.biayaAdmin,
      required this.hargaCetak,
      required this.ack,
      required this.idTrx,
      required this.reffId,
      required this.periode,
      this.idPelanggan,
      this.namaAlias});

  BPJS copyWith({required String idPelanggan, String? namaAlias}) => BPJS(
      tagihan: tagihan,
      nama: nama,
      biayaAdmin: biayaAdmin,
      hargaCetak: hargaCetak,
      ack: ack,
      idTrx: idTrx,
      reffId: reffId,
      periode: periode,
      idPelanggan: idPelanggan,
      namaAlias: namaAlias);

  factory BPJS.fromJson(Map<String, dynamic> json) => _$BPJSFromJson(json);
  Map<String, dynamic> toJson() => _$BPJSToJson(this);
}
