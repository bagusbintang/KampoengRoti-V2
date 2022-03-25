import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  int? id;
  String? title;
  String? imageUrl;

  BannerModel({
    this.id,
    this.title,
    this.imageUrl,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
      ];

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['banner_id'],
        title: json['banner_title'],
        imageUrl: json['banner_url_photo'],
      );

  Map<String, dynamic> toJson() {
    return {
      'banner_id': id,
      'banner_title': title,
      'banner_url_photo': imageUrl,
    };
  }
}
