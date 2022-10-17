import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(0)
  String categoryNamae;
  @HiveField(1)
  List<ProductModel> category;

  CategoryModel({
    required this.category,
    required this.categoryNamae,
  });
}

String boxname = 'category';

//========================================================
//product model class====================================

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  String? category;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? price;
  @HiveField(3)
  String? disctription;
  ProductModel(
      {required this.category,
      required this.name,
      required this.price,
      required this.disctription});
}

class BoxSingleTon {
  static Box<CategoryModel> getInstance() {
    return Hive.box<CategoryModel>(boxname);
  }
}
