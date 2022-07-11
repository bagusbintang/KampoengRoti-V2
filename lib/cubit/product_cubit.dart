import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/product_model.dart';
import 'package:kampoeng_roti2/services/product_services.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void searchProducts({
    required int outletId,
    required String search,
  }) async {
    try {
      emit(ProductLoading());
      List<ProductModel> products = await ProductService().getSearchProduct(
        outletId: outletId,
        search: search,
      );
      emit(ProductSearchSuccess(products));
    } catch (e) {
      print(e.toString());
      emit(
        ProductFailed(e.toString()),
      );
    }
  }

  void fetchProducts({
    required int catId,
    required int outletId,
    String search = 'all',
  }) async {
    try {
      emit(ProductLoading());
      List<ProductModel> products = await ProductService().getProduct(
        catId: catId,
        outletId: outletId,
        search: search,
      );
      emit(ProductSuccess(products));
    } catch (e) {
      emit(
        ProductFailed(e.toString()),
      );
    }
  }

  void fetchNewProducts(
    int outletId,
  ) async {
    try {
      emit(ProductLoading());
      List<ProductModel> products = await ProductService().getNewProduct(
        outletId: outletId,
      );
      emit(ProductSuccess(products));
    } catch (e) {
      emit(
        ProductFailed(e.toString()),
      );
    }
  }
}
