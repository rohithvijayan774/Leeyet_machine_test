import 'package:flutter/material.dart';

class ProductDetailView extends StatelessWidget {
  final String productTitle;
  final String productImageURL;
  final String productDescription;
  final String productBrand;
  final int productPrice;
  final double productRating;

  const ProductDetailView(
      {super.key,
      required this.productTitle,
      required this.productImageURL,
      required this.productDescription,
      required this.productBrand,
      required this.productPrice,
      required this.productRating});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(color: Colors.white),
          ),
          Positioned(
            top: 25,
            child: Stack(
              children: [
                Container(
                  height: height / 2.5,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage(productImageURL),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 30,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_sharp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: height / 1.8,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              productTitle,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '\$ $productPrice',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            productRating.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        productDescription,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontFamily: 'SofiaPro'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black)),
                            onPressed: () {},
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'SofiaPro'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
