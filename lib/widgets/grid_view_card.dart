import 'package:flutter/material.dart';

class GridViewCard extends StatelessWidget {
  final String productTitle;
  final String productImageURL;
  final String productDescription;
  final int productPrice;
  final double productRating;
  final Function onTap;
  const GridViewCard({
    super.key,
    required this.productTitle,
    required this.productImageURL,
    required this.productDescription,
    required this.productPrice,
    required this.productRating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: height / 3,
        width: width / 2.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: width,
                height: height / 7,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(productImageURL),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                productTitle,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 15),
              ),
              Text(
                productDescription,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'SofiaPro',
                    fontSize: 15,
                    color: Colors.grey),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        productRating.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: onTap(),
                    child: const Text(
                      'Details...',
                      style:
                          TextStyle(color: Colors.blue, fontFamily: 'SofiaPro'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
