import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(widget.productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 6,
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                    child: Text(
                      '${widget.price.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              title: Text(widget.title),
              subtitle: Text(
                'Total: \Rs.${(widget.price * widget.quantity).toStringAsFixed(2)}',
              ),
              trailing: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.quantity != 0
                      ? new IconButton(
                          icon: new Icon(Icons.remove_circle_rounded),
                          onPressed: () => setState(() =>
                              Provider.of<Cart>(context, listen: false)
                                  .decrementQuantity(widget.productId)),
                        )
                      : new Container(),
                  new Text(widget.quantity.toString()),
                  new IconButton(
                      icon: new Icon(Icons.add_circle_rounded),
                      onPressed: () => setState(() =>
                          Provider.of<Cart>(context, listen: false)
                              .increaseQuantity(widget.productId)))
                ],
              )),
        ),
      ),
    );
  }
}
