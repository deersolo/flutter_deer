import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final double maxHeight;

  const ProductItem(this.maxHeight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildImage(),
          _buildInfo(),
        ],
      ),
    );
  }

  Image _buildImage() {
    final height = maxHeight * 0.7;
    final productImage =
        'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png';
    return Image.network(productImage, height: height);
  }

  Expanded _buildInfo() => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$4444'),
                  Text('2222 pieces'),
                ],
              )
            ],
          ),
    ),
  );
}
