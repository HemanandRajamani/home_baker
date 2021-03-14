import 'package:flutter/material.dart';
import 'package:home_baker/providers/cart.dart';
import 'package:home_baker/providers/products.dart';
import 'package:home_baker/screens/cart/cart_screen.dart';
import 'package:home_baker/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../../widgets/product_grid.dart';
import '../../widgets/badge.dart';
import '../../models/filter_options.dart';

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showFavs = false;

  @override
  Widget build(BuildContext context) {
    final List<String> productData = Provider.of<Products>(context).titles;
    final itemCount = Provider.of<Cart>(
      context,
    ).itemCount;
    return Scaffold(
        appBar: AppBar(
          title: (Text("Home Baker")),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search(productData));
              },
              icon: Icon(Icons.search),
            ),
            Consumer<Cart>(
              builder: (ctx, cart, ch) =>
                  Badge(child: ch, value: itemCount.toString()),
              child: IconButton(
                icon: Icon(Icons.shopping_basket_rounded),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  print(selectedValue);
                  setState(() {
                    if (selectedValue == FilterOptions.FAVOURITES) {
                      showFavs = true;
                    } else {
                      showFavs = false;
                    }
                  });
                },
                icon: Icon(
                  Icons.more_vert,
                ),
                itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text('Favorites'),
                        value: FilterOptions.FAVOURITES,
                      ),
                      PopupMenuItem(
                        child: Text('Show All'),
                        value: FilterOptions.SHOW_ALL,
                      ),
                    ])
          ],
        ),
        drawer: AppDrawer(),
        body: ProductGrid(this.showFavs));
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Vanilla", "Cup Cake", "Chocolate"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
