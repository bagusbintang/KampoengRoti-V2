import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/invoice_detail_model.dart';

class InvoiceModel extends Equatable {
  int? iHeaderId;
  String? iHeaderNo;
  int? customerId;
  String? iHeaderName;
  String? iHeaderPhone;
  String? iHeaderAddress;
  DateTime? iHeaderDelivTime;
  double? iHeaderOngkir;
  double? iHeaderPromoDisc;
  double? iHeaderMemberDisc;
  double? iHeaderTotal;
  double? iHeaderGrandTotal;
  String? iHeaderStatus;
  String? iHeaderDelivMethod;
  List<InvoiceDetailModel>? invDetail;
  String? iStatus;
  String? iDelivery;

  InvoiceModel({
    this.iHeaderId,
    this.iHeaderNo,
    this.customerId,
    this.iHeaderName,
    this.iHeaderAddress,
    this.iHeaderPhone,
    this.iHeaderDelivTime,
    this.iHeaderOngkir,
    this.iHeaderPromoDisc,
    this.iHeaderMemberDisc,
    this.iHeaderTotal,
    this.iHeaderGrandTotal,
    this.iHeaderStatus,
    this.iHeaderDelivMethod,
    this.invDetail,
    this.iStatus,
    this.iDelivery,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        iHeaderId,
        iHeaderNo,
        customerId,
        iHeaderName,
        iHeaderAddress,
        iHeaderPhone,
        iHeaderDelivTime,
        iHeaderOngkir,
        iHeaderPromoDisc,
        iHeaderMemberDisc,
        iHeaderTotal,
        iHeaderGrandTotal,
        iHeaderStatus,
        iHeaderDelivMethod,
        invDetail,
        iStatus,
        iDelivery,
      ];
  factory InvoiceModel.fromJson(Map<String, dynamic> inJson) => InvoiceModel(
        iHeaderId: inJson['iheader_id'],
        iHeaderNo: inJson['iheader_no'],
        customerId: inJson['iheader_customerid'],
        iHeaderName: inJson['iheader_name'],
        iHeaderAddress: inJson['iheader_address'],
        iHeaderPhone: inJson['iheader_phone'],
        iHeaderDelivTime: DateTime.parse(inJson['iheader_deliverytime']),
        iHeaderOngkir: double.parse(inJson['iheader_ongkir'].toString()),
        iHeaderPromoDisc:
            double.parse(inJson['iheader_promodiscount'].toString()),
        iHeaderMemberDisc:
            double.parse(inJson['iheader_memberdiscount'].toString()),
        iHeaderTotal: double.parse(inJson['iheader_total'].toString()),
        iHeaderGrandTotal:
            double.parse(inJson['iheader_grandtotal'].toString()),
        iHeaderStatus: inJson['str_status'],
        iHeaderDelivMethod: inJson['str_delivery_method'],
        invDetail: inJson['InvoiceDetail']
            .map<InvoiceDetailModel>(
                (invDetail) => InvoiceDetailModel.fromJson(invDetail))
            .toList(),
        iStatus: inJson['iheader_status'],
        iDelivery: inJson['iheader_delivery'],
      );

  Map<String, dynamic> toJson() {
    return {
      'iheader_id': iHeaderId,
      'iheader_no': iHeaderNo,
      'iheader_customerid': customerId,
      'iheader_name': iHeaderName,
      'iheader_address': iHeaderAddress,
      'iheader_phone': iHeaderPhone,
      'iheader_deliverytime': iHeaderDelivTime.toString(),
      'iheader_ongkir': iHeaderOngkir,
      'iheader_promodiscount': iHeaderPromoDisc,
      'iheader_memberdiscount': iHeaderMemberDisc,
      'iheader_total': iHeaderTotal,
      'iheader_grandtotal': iHeaderGrandTotal,
      'str_status': iHeaderStatus,
      'str_delivery_method': iHeaderDelivMethod,
      'InvoiceDetail':
          invDetail!.map((invDetail) => invDetail.toJson()).toList(),
      'iheader_status': iStatus,
      'iheader_delivery': iDelivery,
    };
  }
}
