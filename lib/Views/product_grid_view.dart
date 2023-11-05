import 'package:flutter/material.dart';
import 'package:leeyet_machine_test/Controllers/user_controller.dart';
import 'package:leeyet_machine_test/Views/user_home_screen.dart';
import 'package:leeyet_machine_test/Views/user_login_screen.dart';
import 'package:leeyet_machine_test/widgets/grid_view_card.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Consumer<UserController>(
        builder: (context, provider, _) {
          return FutureBuilder(
            future: provider.getProducts(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UserLoginScreen(),
                                      ),
                                      (route) => false);
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(fontFamily: 'SofiaPro'),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Welcome, ${provider.userData["firstName"]}',
                            style: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 25),
                          ),
                          const Text(
                            'Pick Your Favourite...',
                            style:
                                TextStyle(fontFamily: 'SofiaPro', fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: 2),
                      itemBuilder: (context, index) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return GridViewCard(
                            productTitle: provider.data["products"][index]
                                ["title"],
                            productImageURL: provider.data["products"][index]
                                ["images"][0],
                            productDescription: provider.data["products"][index]
                                ["description"],
                            productPrice: provider.data["products"][index]
                                ["price"],
                            productRating: provider.data["products"][index]
                                ["rating"],
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => ProductDetailView(
                              //         productTitle: provider.data["products"]
                              //             [index]["title"],
                              //         productImageURL: provider.data["products"]
                              //             [index]["images"][0],
                              //         productDescription:
                              //             provider.data["products"][index]
                              //                 ["description"],
                              //         productBrand: provider.data["products"]
                              //             [index]["brand"],
                              //         productPrice: provider.data["products"]
                              //             [index]["price"],
                              //         productRating: provider.data["products"]
                              //             [index]["rating"]),
                              //   ),
                              // );
                            },
                          );
                        }
                      },
                      itemCount: 4,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomSheet: BottomAppBar(
        color: Colors.grey[200],
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserHomeScreen(),
                ));
              },
              child: const Text(
                'Show more...',
                style: TextStyle(
                    color: Colors.blue, fontFamily: 'SofiaPro', fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
