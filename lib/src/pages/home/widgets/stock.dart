import 'package:deersolo/src/pages/home/widgets/ProductItem.dart';
import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, BoxConstraints constraints) {

          return ProductItem(constraints.maxHeight);
        },
      ),
      itemCount: 5,
    );
  }
}
