import 'package:flutter/material.dart';
import 'package:leeyet_machine_test/widgets/list_view_card.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListViewCard(
          productTitle: 'Product Title',
          productDescription: 'Product Desc',
          productImageURL: 'ImageURL',
          productPrice: 100,
          productRating: 10,
          onTap: (){},
        ),
      ),
    );
  }
}
