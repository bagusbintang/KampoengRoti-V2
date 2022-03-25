import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kampoeng_roti2/models/category_mode.dart';
import 'package:kampoeng_roti2/services/category_service.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void fetchCategories(int outletId) async {
    try {
      emit(CategoryLoading());
      List<CategoryModel> categories =
          await CategoryService().getCategory(outletId: outletId);
      emit(CategorySuccess(categories));
    } catch (e) {
      emit(
        CategoryFailed(e.toString()),
      );
    }
  }
}
