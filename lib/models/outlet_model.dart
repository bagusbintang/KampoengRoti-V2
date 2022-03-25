import 'package:equatable/equatable.dart';

class OutletModel extends Equatable {
  int? id;
  int? cityId;
  String? title;
  String? address;
  String? phone;
  double? latitude;
  double? longitude;
  String? url;
  double? distance;

  OutletModel({
    this.id,
    this.cityId,
    this.title,
    this.address,
    this.phone,
    this.latitude,
    this.longitude,
    this.url,
    this.distance,
  });
  @override
  List<Object?> get props => [
        id,
        cityId,
        title,
        address,
        phone,
        latitude,
        longitude,
        url,
        distance,
      ];

  factory OutletModel.fromJson(Map<String, dynamic> json) => OutletModel(
        id: json['outlet_id'],
        cityId: json['outlet_cityid'],
        title: json['outlet_title'],
        address: json['outlet_address'],
        phone: json['outlet_phone'],
        // profilePictureUrl: json['customer_active'],
        // token: json['id'],
        latitude: double.parse(json['outlet_latitude'].toString()),
        longitude: double.parse(json['outlet_longitude'].toString()),
        url: json['outlet_map'],
        distance: json['distance_in_km'] != null
            ? json['distance_in_km'].toDouble()
            : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'outlet_id': id,
      'outlet_cityid': cityId,
      'outlet_title': title,
      'outlet_address': address,
      'outlet_phone': phone,
      'outlet_map': url,
      'outlet_latitude': latitude,
      'outlet_longitude': longitude,
      'distance_in_km': distance,
    };
  }
}
