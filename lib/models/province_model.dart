import 'package:equatable/equatable.dart';

class ProvinceModel extends Equatable {
  int? id;
  String? provinceName;

  ProvinceModel({
    this.id,
    this.provinceName,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        provinceName,
      ];

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        id: json['province_id'],
        provinceName: json['province_title'],
      );

  Map<String, dynamic> toJson() {
    return {
      'province_id': id,
      'province_title': provinceName,
    };
  }
}
