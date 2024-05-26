import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kirodev_q3/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  // edit: add padding to the card
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: product.imageCover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            ListTile(
              title: Text(product.title),
              subtitle: Text(product.description),
            ),
            Text('Price: \$${product.price}'),
            Text('Sold: ${product.sold}'),
            Text('Ratings: ${product.ratingsAverage} (${product.ratingsQuantity} ratings)'),
          ],
        ),
      ),
    );
  }
}
