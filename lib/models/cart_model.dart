import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  int? id;
  // ProductModel product;
  String? prodTitle;
  double? prodPrice;
  String? prodUrlPhoto;
  String? notes;
  int? quantity;

  CartModel({
    this.id,
    // this.product,
    this.quantity,
    this.prodTitle,
    this.prodPrice,
    this.prodUrlPhoto,
    this.notes,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        // this.product,
        quantity,
        prodTitle,
        prodPrice,
        prodUrlPhoto,
        notes,
      ];

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['shoping_cart_temp_detail_id'],
        // product = catJson[''];
        quantity: json['qty'],
        notes: json['notes'],
        prodTitle: json['plist_title'],
        prodPrice: json['plist_price'].toDouble(),
        prodUrlPhoto: json['prod_url_photo'],
      );

  Map<String, dynamic> toJson() {
    return {
      'shoping_cart_temp_detail_id': id,
      // '': product,
      'qty': quantity,
      'notes': notes,
      'plist_title': prodTitle,
      'plist_price': prodPrice,
      'prod_url_photo': prodUrlPhoto,
    };
  }
}
