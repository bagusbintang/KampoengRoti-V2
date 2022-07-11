import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  int? id;
  String? title;
  int? status;
  double? price;
  String? imageUrl;
  int? outletStock;

  ProductModel({
    this.id,
    this.title,
    this.status,
    this.price,
    this.imageUrl,
    this.outletStock,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        status,
        price,
        imageUrl,
        outletStock,
      ];

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['plist_id'],
        title: json['plist_title'],
        status: json['plist_status'].toInt(),
        price: json['plist_price'].toDouble(),
        imageUrl: json['prod_url_photo'],
        outletStock: json['poulet_stock'],
      );

  Map<String, dynamic> toJson() {
    return {
      'plist_id': id,
      'plist_title': title,
      'plist_status': status,
      'plist_price': price,
      'prod_url_photo': imageUrl,
      'poulet_stock': outletStock,
    };
  }
}
