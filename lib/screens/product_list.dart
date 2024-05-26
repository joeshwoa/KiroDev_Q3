import 'package:flutter/material.dart';
import 'package:kirodev_q3/componants/product_item.dart';
import 'package:pager/pager.dart';
import '../services/products_service.dart';
import '../models/product.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<Map<String, dynamic>> _productData;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _productData = ProductsService.fetchProducts(_currentPage);
  }

  void _fetchPage(int page) {
    setState(() {
      _currentPage = page;
      _productData = ProductsService.fetchProducts(_currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _productData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!['products'].isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            var products = snapshot.data!['products'] as List<Product>;
            var currentPage = snapshot.data!['currentPage'] as int;
            var numberOfPages = snapshot.data!['numberOfPages'] as int;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) => ProductItem(product: products[index]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Pager(
                      currentPage: currentPage,
                      totalPages: numberOfPages,
                      pageChangeIconColor: Theme.of(context).primaryColor, // edit: change the color to main to be more beautiful
                      numberButtonSelectedColor: Theme.of(context).primaryColor, // edit: change the color to main to be more beautiful
                      onPageChanged: (page) {
                        setState(() {
                          currentPage = page;
                          _fetchPage(currentPage);
                        });
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
