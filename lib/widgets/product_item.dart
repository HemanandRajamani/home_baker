import 'package:flutter/material.dart';
import 'package:home_baker/providers/cart.dart';
import 'package:provider/provider.dart';

import '../screens/product/product_details_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);

    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductDetailsScreen.routeName,
                  arguments: product.id,
                );
              },
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            footer: Consumer<Product>(
              //builder: (ctx, product, child) => IconButton(
              builder: (ctx, product, _) => GridTileBar(
                //use consumer if you dont want all parts to load
                leading: IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () {
                    product.toggleFavoriteStatus();
                  },
                  color: Theme.of(context).accentColor,
                ),
                backgroundColor: Colors.black54,
                title: Text(
                  product.title,
                  textAlign: TextAlign.center,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.shopping_cart_rounded),
                  onPressed: () {
                    cart.addItem(product.id, product.title, product.price);

                    product.toggleShoppingCartStatus();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added item to cart!',
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            cart.removeItem(product.id);
                          },
                        ),
                      ),
                    );
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
            )));
  }
}
