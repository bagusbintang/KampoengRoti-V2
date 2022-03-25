part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;

  CategorySuccess(this.categories);

  @override
  // TODO: implement props
  List<Object> get props => [categories];
}

class CategoryFailed extends CategoryState {
  final String error;

  CategoryFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
