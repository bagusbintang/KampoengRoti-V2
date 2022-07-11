import 'package:equatable/equatable.dart';

class ContactUsModel extends Equatable {
  int? id;
  String? whatsapp;
  String? phone;
  String? email;

  ContactUsModel({
    this.id,
    this.whatsapp,
    this.phone,
    this.email,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        whatsapp,
        phone,
        email,
      ];

      factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        id: json['contact_id'],
        whatsapp: json['contact_whatsapp'],
        phone: json['contact_phone'],
        email: json['contact_email'],
        
      );

  Map<String, dynamic> toJson() {
    return {
      'contact_id': id,
      'contact_whatsapp': whatsapp,
      'contact_phone': phone,
      'contact_email': email,
    };
  }
}
