import 'package:kampoeng_roti2/models/contact_us_model.dart';
import 'package:kampoeng_roti2/models/outlet_model.dart';
import 'package:kampoeng_roti2/models/user_address_model.dart';
import 'package:kampoeng_roti2/models/user_model.dart';

class UserSingleton {
  late UserModel user;
  late UserAddressModel address;
  late OutletModel outlet;
  late ContactUsModel contactUs;
  late bool isDeliveryOption;
  // String imageUrl;

  // CategorySingleton({
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // });
  static final UserSingleton _instance = UserSingleton._internal();

  UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }
}
