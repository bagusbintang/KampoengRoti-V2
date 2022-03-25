import 'package:equatable/equatable.dart';

class InvoiceDetailModel extends Equatable {
  int? id;
  String? title;
  double? price;
  int? qty;
  double? subTotal;
  String? imageUrl;

  InvoiceDetailModel({
    this.id,
    this.title,
    this.price,
    this.qty,
    this.subTotal,
    this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        price,
        qty,
        subTotal,
        imageUrl,
      ];

  factory InvoiceDetailModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailModel(
        id: json['idetail_plistid'],
        title: json['plist_title'],
        price: json['idetail_price'].toDouble(),
        qty: json['idetail_qty'],
        subTotal: json['idetail_subtotal'].toDouble(),
        imageUrl: json['prod_url_photo'],
      );

  Map<String, dynamic> toJson() {
    return {
      'idetail_plistid': id,
      'plist_title': title,
      'idetail_price': price,
      'idetail_qty': qty,
      'idetail_subtotal': subTotal,
      'prod_url_photo': imageUrl,
    };
  }
}
