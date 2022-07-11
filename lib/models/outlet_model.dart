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
  int? delivStart;
  int? delivEnd;
  int? pickUpStart;
  int? pickUpEnd;
  int? minOrder;

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
    this.delivStart,
    this.delivEnd,
    this.pickUpStart,
    this.pickUpEnd,
    this.minOrder,
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
        delivStart,
        delivEnd,
        pickUpStart,
        pickUpEnd,
        minOrder,
      ];

  factory OutletModel.fromJson(Map<String, dynamic> json) => OutletModel(
        id: json['outlet_id'],
        cityId: json['outlet_cityid'],
        title: json['outlet_title'],
        address: json['outlet_address'],
        phone: json['outlet_phone'],
        // profilePictureUrl: json['customer_active'],
        // token: json['id'],
        latitude: json['outlet_latitude'] != null
            ? double.parse(json['outlet_latitude'].toString())
            : null,
        longitude: json['outlet_longitude'] != null
            ? double.parse(json['outlet_longitude'].toString())
            : null,
        url: json['outlet_map'],
        distance: json['distance_in_km'] != null
            ? json['distance_in_km'].toDouble()
            : null,
        delivStart: json['outlet_delivery_start'] != null
            ? json['outlet_delivery_start'].toInt()
            : null,
        delivEnd: json['outlet_delivery_end'] != null
            ? json['outlet_delivery_end'].toInt()
            : null,
        pickUpStart: json['outlet_pickup_start'] != null
            ? json['outlet_pickup_start'].toInt()
            : null,
        pickUpEnd: json['outlet_pickup_end'] != null
            ? json['outlet_pickup_end'].toInt()
            : null,
        minOrder: json['outlet_minimal_order'] != null
            ? json['outlet_minimal_order'].toInt()
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
      'outlet_delivery_start': delivStart,
      'outlet_delivery_end': delivEnd,
      'outlet_pickup_start': pickUpStart,
      'outlet_pickup_end': pickUpEnd,
      'outlet_minimal_order': minOrder,
    };
  }
}
