class CategorySingleton {
  late int id;
  late String title;
  late int outletId;
  // String imageUrl;

  // CategorySingleton({
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // });
  static final CategorySingleton _instance = CategorySingleton._internal();

  CategorySingleton._internal();

  factory CategorySingleton() {
    return _instance;
  }
}
