import 'package:flutter/material.dart';
import 'package:leeyet_machine_test/Controllers/user_controller.dart';
import 'package:leeyet_machine_test/Views/product_detail_view.dart';
import 'package:leeyet_machine_test/widgets/list_view_card.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<UserController>(context);
    productsProvider.getProducts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: Consumer<UserController>(builder: (context, provider, _) {
        return FutureBuilder(
          future: provider.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  return ListViewCard(
                    productTitle: provider.data["products"][index]["title"],
                    productImageURL: provider.data["products"][index]["images"]
                        [0],
                    productDescription: provider.data["products"][index]
                        ["description"],
                    productPrice: 100,
                    productRating: provider.data["products"][index]["rating"],
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetailView(
                          productDescription: provider.data["products"][index]
                              ["description"],
                          productImageURL: provider.data["products"][index]
                              ["images"][0],
                          productPrice: provider.data["products"][index]
                              ["price"],
                          productRating: 10,
                          productTitle: provider.data["products"][index]
                              ["title"],
                          productBrand: provider.data["products"][index]
                              ["brand"],
                        ),
                      ));
                    },
                  );
                },
              );
            }
          },
        );
      }),
    );
  }
}
