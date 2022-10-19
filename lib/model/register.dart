class Register {
  final String message;
  final String ack;
  final String? idReg;

  Register({required this.message, required this.ack, this.idReg});

  factory Register.fromJson(Map<String, dynamic> json) =>
      Register(message: json['pesan'], ack: json['ACK'], idReg: json['id_reg']);
}


