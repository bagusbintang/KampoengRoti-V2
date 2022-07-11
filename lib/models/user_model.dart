import 'package:equatable/equatable.dart';

import 'user_address_model.dart';

class UserModel extends Equatable {
  int? id;
  String? phone;
  String? name;
  String? username;
  String? email;
  String? profilePictureUrl;
  String? token;
  String? memberNo;
  double? discMember;
  int? active;
  int? verified;
  UserAddressModel? defaulAdress;
  int? isRequestMember;

  UserModel({
    this.id,
    this.phone,
    this.name,
    this.username,
    this.email,
    this.profilePictureUrl,
    this.token,
    this.memberNo,
    this.discMember,
    this.active,
    this.verified,
    this.defaulAdress,
    this.isRequestMember,
  });
  @override
  List<Object?> get props => [
        id,
        phone,
        name,
        username,
        email,
        profilePictureUrl,
        token,
        memberNo,
        discMember,
        active,
        verified,
        defaulAdress,
        isRequestMember,
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['customer_id'],
        phone: json['customer_phone'],
        name: json['customer_name'],
        username: json['customer_name'],
        email: json['customer_email'],
        // profilePictureUrl: json['customer_active'],
        // token: json['id'],
        memberNo: json['customer_memberno'],
        discMember: json['settings_disc_member'] != null
            ? json['settings_disc_member'].toDouble()
            : null,
        active: json['customer_active'],
        verified: json['customer_verified'],
        defaulAdress: json['default_address'] != null
            ? UserAddressModel.fromJson(json['default_address'])
            : null,
        isRequestMember: json['is_request_member'],
      );

  Map<String, dynamic> toJson() => {
        'customer_id': id,
        'customer_phone': phone,
        'customer_name': name,
        'customer_name': username,
        'customer_email': email,
        // '': profilePictureUrl,
        // '': token,
        'customer_memberno': memberNo,
        'settings_disc_member': discMember,
        'customer_active': active,
        'customer_emailverified': verified,
        'default_address': defaulAdress!.toJson(),
        'is_request_member': isRequestMember,
      };
}
