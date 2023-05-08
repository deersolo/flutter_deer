import 'package:deersolo/src/models/post.dart';
import 'package:deersolo/src/models/product.dart';
import 'package:deersolo/src/pages/home/widgets/ProductItem.dart';
import 'package:deersolo/src/services/network_service.dart';
import 'package:flutter/material.dart';

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  final _spacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: NetworkService().getAllProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product>? product = snapshot.data;
          if (product == null) {
            return Container(
              margin: EdgeInsets.only(top: 22),
              alignment: Alignment.topCenter,
              child: Text('No Data'),
            );
          }
          return RefreshIndicator(
              onRefresh: () async {
                setState(() {

                });
              },
              child: _buildProductGridView(product));
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  GridView _buildProductGridView(List<Product> product) {
    return GridView.builder(
      padding: EdgeInsets.only(
          left: _spacing, right: _spacing, top: _spacing, bottom: 150),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: _spacing,
        mainAxisSpacing: _spacing,
      ),
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return ProductItem(constraints.maxHeight, product: product[index],);
        },
      ),
      itemCount: product.length,
    );
  }
}
