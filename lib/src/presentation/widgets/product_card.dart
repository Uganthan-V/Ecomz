

import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final img = product.images.isNotEmpty ? product.images.first.toString() : null;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: img != null ? ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), child: Image.network(img, width: double.infinity, fit: BoxFit.cover)) : Container()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text('\$${product.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Rating: ${product.rating}', style: const TextStyle(fontSize: 12)),
          ]),
        )
      ]),
    );
  }
}