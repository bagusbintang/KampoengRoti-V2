import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  int? id;
  String? cityName;

  CityModel({
    this.id,
    this.cityName,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        cityName,
      ];

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['city_id'],
        cityName: json['city_title'],
      );

  Map<String, dynamic> toJson() {
    return {
      'city_id': id,
      'city_title': cityName,
    };
  }
}
