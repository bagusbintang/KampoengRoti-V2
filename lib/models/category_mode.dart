import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  int? id;
  String? title;
  String? imageUrl;

  CategoryModel({
    this.id,
    this.title,
    this.imageUrl,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        imageUrl,
      ];

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['pcat_id'],
        title: json['pcat_title'],
        imageUrl: json['cat_url_photo'],
      );

  Map<String, dynamic> toJson() {
    return {
      'pcat_id': id,
      'pcat_title': title,
      'cat_url_photo': imageUrl,
    };
  }
}
