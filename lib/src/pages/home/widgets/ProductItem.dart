import 'package:deersolo/src/constants/api.dart';
import 'package:deersolo/src/models/product.dart';
import 'package:deersolo/src/utils/format.dart';
import 'package:deersolo/src/widgets/image_not_found.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final double maxHeight;
  final Product product;
  final VoidCallback onTap;

  ProductItem(this.maxHeight, this.product, {super.key, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildImage(),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Stack _buildImage() {
    final height = maxHeight * 0.7;
    final productImage = product.image;

    return Stack(children: [
      SizedBox(
        width: double.infinity,
        height: height,
        child: productImage != null && productImage.isNotEmpty
            ? Image.network('${API.IMAGE_URL}/$productImage')
            : ImageNotFound(),
      ),
      if (product.stock! < 1) _buildOutOfStock(),
    ]);
  }

  Expanded _buildInfo() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name as String,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '฿${formatCurrency.format(product.price)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${formatNumber.format(product.stock)} pieces',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Positioned _buildOutOfStock() => Positioned(
        top: 2,
        right: 2,
        child: Card(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              'Out of stock',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      );
}
