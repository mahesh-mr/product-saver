import 'package:flutter/material.dart';
import 'package:hive_task/view/style.dart/style.dart';

class GlassModel extends StatelessWidget {
  const GlassModel({ Key? key,required this.height ,required this.widget}) : super(key: key);
final double height;
final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
                border: Border.all(color: white, width: 2),
                borderRadius: BorderRadius.circular(20),
                color: black.withOpacity(.2)),
                child: widget,
          ));
  }
}
