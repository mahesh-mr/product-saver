// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_task/controller/add_category_controller.dart';
import 'package:hive_task/model/category_model.dart';
import 'package:hive_task/view/home_view.dart';
import 'package:hive_task/view/style.dart/style.dart';

class SingleItemView extends StatelessWidget {
  SingleItemView({
    Key? key,
    required this.productModel,
    required this.index,
  }) : super(key: key);

// int index;
  ProductModel productModel;
  int index;

  var box = BoxSingleTon.getInstance();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final kwidth = SizedBox(width: width * .08);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Single Item View",
          style: headLine,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Are you sure ?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();

                        List<CategoryModel> categories = box.values.toList();

                        int categoryIndex = categories.indexWhere((element) =>
                            element.categoryNamae == productModel.category);

                        List<ProductModel> products =
                            categories[categoryIndex].category;

                        products.removeAt(index);

                        if (products.isEmpty) {
                          box.deleteAt(categoryIndex);
                        } else {
                          box.putAt(
                            categoryIndex,
                            CategoryModel(
                                category: products,
                                categoryNamae: productModel.category!),
                          );
                        }

                        Get.offAll(const HomeScreen());
                      },
                      child: const Text("Yes"),
                    )
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Container(
            width: double.infinity,
            height: height * .5,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      details(),
                      kwidth,
                      collen(),
                      kwidth,
                      inputs(width, height),
                    ],
                  ),
                  discription(width, height)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//DISCRIPTION=====================================
  Row discription(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Discription",
          style: headLine,
          maxLines: 6,
        ),
        SizedBox(
          width: width * .017,
        ),
        Text(
          ":",
          style: headLine,
        ),
        SizedBox(
          width: width * .02,
        ),
        SizedBox(
          height: height * .37,
          width: width * .5,
          child: Text(
            productModel.disctription!,
            style: headLine,
            maxLines: 6,
          ),
        ),
      ],
    );
  }

//DETAILS=====================================
  Column details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categori",
          style: headLine,
        ),
        Text(
          "Name",
          style: headLine,
        ),
        Text(
          "Price",
          style: headLine,
        ),
      ],
    );
  }

//HEADLINES=====================================================
  Column inputs(width, height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productModel.category!,
          style: headLine,
        ),
        Text(
          productModel.name!,
          style: headLine,
        ),
        Text(
          productModel.price!,
          style: headLine,
        ),
      ],
    );
  }

//DIVIDERS================================================================
  Column collen() {
    return Column(
      children: [
        Text(
          ":",
          style: headLine,
        ),
        Text(
          ":",
          style: headLine,
        ),
        Text(
          ":",
          style: headLine,
        ),
      ],
    );
  }
}
