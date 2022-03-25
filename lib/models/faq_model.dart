import 'package:equatable/equatable.dart';

class FaqModel extends Equatable {
  int? id;
  bool? isExpanded;
  int? number;
  String? title;
  String? desc;

  FaqModel({
    this.id,
    this.number,
    this.title,
    this.desc,
    this.isExpanded = false,
  });
  @override
  List<Object?> get props => [
        number,
        title,
        desc,
        isExpanded,
      ];

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json['faq_id'],
        title: json['faq_title'],
        desc: json['faq_desc'],
        number: json['faq_no'],
      );

  Map<String, dynamic> toJson() {
    return {
      'plist_id': id,
      'plist_title': title,
      'plist_desc': desc,
      'plist_no': number,
    };
  }
}
