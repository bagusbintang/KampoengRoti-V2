import 'package:equatable/equatable.dart';

import 'outlet_model.dart';

class UserAddressModel extends Equatable {
  int? id;
  int? userId;
  String? tagAddress;
  String? personName;
  String? personPhone;
  String? address;
  String? addressDetail;
  String? city;
  String? province;
  String? notes;
  int? defaultAddress;
  double? latitude;
  double? longitude;
  OutletModel? outletModel;

  UserAddressModel({
    this.id,
    this.userId,
    this.tagAddress,
    this.personName,
    this.personPhone,
    this.address,
    this.addressDetail,
    this.city,
    this.province,
    this.notes,
    this.defaultAddress,
    this.latitude,
    this.longitude,
    this.outletModel,
  });
  @override
  List<Object?> get props => [
        id,
        userId,
        tagAddress,
        personName,
        personPhone,
        address,
        addressDetail,
        city,
        province,
        notes,
        defaultAddress,
        latitude,
        longitude,
        outletModel,
      ];

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      UserAddressModel(
        id: json['caddress_id'],
        userId: int.parse(json['caddress_customerid'].toString()),
        tagAddress: json['caddress_tag'],
        personName: json['caddress_name'],
        personPhone: json['caddress_phone'],
        // profilePictureUrl: json['customer_active'],
        // token: json['id'],
        address: json['caddress_address'],
        addressDetail: json['caddress_detail'],
        city: json['caddress_city'],
        province: json['caddress_province'],
        notes: json['caddress_catatan'],
        defaultAddress: json['caddress_default'],
        latitude: json['latitude'] != null ? json['latitude'].toDouble() : 0.0,
        longitude:
            json['longitude'] != null ? json['longitude'].toDouble() : 0.0,
        outletModel: json['outlet_data'] != null
            ? OutletModel.fromJson(json['outlet_data'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'caddress_id': id,
        'caddress_customerid': userId,
        'caddress_tag': tagAddress,
        'caddress_name': personName,
        'caddress_phone': personPhone,
        'caddress_address': address,
        'caddress_detail': addressDetail,
        'caddress_city': city,
        'caddress_province': province,
        'caddress_catatan': notes,
        'caddress_default': defaultAddress,
        'latitude': latitude,
        'longitude': longitude,
        'outletModel': outletModel!.toJson(),
        // 'outlet_data': outletModel != null ? outletModel!.toJson() : null,
      };
}
