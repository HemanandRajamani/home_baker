import 'package:flutter/material.dart';
import 'package:home_baker/providers/products.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;

  ProductGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final productItems = showFavs ? productData.favsOnly : productData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: productItems.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: productItems[i], child: ProductItem()),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 5 / 3,
            mainAxisSpacing: 7.00,
            crossAxisSpacing: 7.00));
  }
}
