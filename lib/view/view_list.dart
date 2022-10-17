
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_task/controller/add_category_controller.dart';
import 'package:hive_task/model/category_model.dart';

import 'package:hive_task/view/single_view.dart';
import 'package:hive_task/view/style.dart/style.dart';

class ViewList extends StatelessWidget {
  ViewList({required this.products, required this.categorys, Key? key})
      : super(key: key);
  AddCategoriesController addCategoriesController =
      Get.put(AddCategoriesController());

  List<ProductModel> products;
  CategoryModel categorys;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_outlined)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            categorys.categoryNamae,
            style: headLine,
          ),
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  onTap: () {
                    Get.to(SingleItemView(
                      productModel: products[index],
                      index: index,
                    ));
                  },
                  title: Text(
                    products[index].name!,
                    style: subLine,
                  ),
                  subtitle: Text(
                    products[index].disctription!,
                    style: subLine,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    products[index].price!,
                    style: subLine,
                  ),
                ),
              ),
            );
          },
        ));
  }
}
