import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
   final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  const ProductWidget({super.key, required this.id, required this.title, required this.description, required this.price, required this.discountPercentage, required this.rating, required this.stock, required this.brand, required this.category, required this.thumbnail, required this.images});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  thumbnail,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 16),
                Text(
                  'Price: \$${price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Discount: ${discountPercentage.toStringAsFixed(2)}%',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Rating: $rating',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Stock: $stock',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Brand: $brand',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Category: $category',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
          

           
                // SizedBox(
                //   height: MediaQuery.of(context).size.width,
                //   width: MediaQuery.of(context).size.width,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: images.length,
                //     shrinkWrap: true,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(right: 8.0),
                //         child: Image.network(
                //           images[index],
                //           height: 50,
                //   width: MediaQuery.of(context).size.width,
                //           fit: BoxFit.contain,
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
  
  }
}