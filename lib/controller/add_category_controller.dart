

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:hive_task/model/category_model.dart';

class AddCategoriesController extends GetxController {
  final box = Hive.box<CategoryModel>(boxname);
  // RxList<CategoryModel> categorimodel = <CategoryModel>[].obs;
  // RxList<ProductModel> products = <ProductModel>[].obs;

  String? categoryValue;
  List<String> categoryItems = [
    'Fruits',
    'Vegitables',
    'Furniture',
    'Electronics',
  ];

  dropdownChanging(
    String value,
  ) {
    categoryValue = value;
    update();
  }
}
