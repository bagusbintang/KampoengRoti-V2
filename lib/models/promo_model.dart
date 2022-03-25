import 'package:equatable/equatable.dart';

class PromoModel extends Equatable {
  int? id;
  String? title;
  String? desc;
  double? discount;
  double? minTrans;
  double? maxDisc;
  DateTime? start;
  DateTime? end;
  String? imageUrl;
  int? promoType;

  PromoModel({
    this.id,
    this.title,
    this.desc,
    this.discount,
    this.minTrans,
    this.maxDisc,
    this.start,
    this.end,
    this.imageUrl,
    this.promoType,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        desc,
        discount,
        minTrans,
        maxDisc,
        start,
        end,
        imageUrl,
        promoType,
      ];

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
        id: json['voucher_id'],
        title: json['voucher_title'],
        desc: json['voucher_desc'],
        discount: json['voucher_discount'].toDouble(),
        minTrans: json['voucher_minimum'].toDouble(),
        maxDisc: json['voucher_maximum'].toDouble(),
        start: DateTime.parse(json['voucher_start'].toString()),
        end: DateTime.parse(json['voucher_end'].toString()),
        imageUrl: json['voucher_url_photo'],
        promoType: json['voucher_type'].toInt(),
      );

  Map<String, dynamic> toJson() {
    return {
      'plist_id': id,
      'plist_title': title,
      'voucher_desc': desc,
      'voucher_discount': discount,
      'voucher_minimum': minTrans,
      'voucher_maximum': maxDisc,
      'voucher_start': start,
      'voucher_end': end,
      'voucher_url_photo': imageUrl,
      'voucher_type': promoType,
    };
  }
}
