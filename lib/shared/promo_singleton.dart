import 'package:kampoeng_roti2/models/promo_model.dart';

class PromoSingleton {
  late PromoModel promo = PromoModel();
  late bool fromPaymentPage = false;
  // late bool isLoggin;
  // String imageUrl;

  // CategorySingleton({
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // });
  static final PromoSingleton _instance = PromoSingleton._internal();

  PromoSingleton._internal();

  factory PromoSingleton() {
    return _instance;
  }
}
