import 'package:flutter/material.dart';

class ListViewCard extends StatelessWidget {
  final String productTitle;
  final String productImageURL;
  final String productDescription;
  final int productPrice;
  final num productRating;
  final Function onTap;
  const ListViewCard({
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
        height: height / 5,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: height / 10,
                    width: height / 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(productImageURL),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          productTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          productDescription,
                          style: const TextStyle(
                              color: Colors.grey, fontFamily: 'SofiaPro'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
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
                    onTap: () {
                      onTap();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View details',
                          style: TextStyle(
                              color: Colors.blue, fontFamily: 'SofiaPro'),
                        ),
                        Icon(
                          Icons.navigate_next_sharp,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
