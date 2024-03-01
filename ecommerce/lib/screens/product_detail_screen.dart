import 'package:ecommerce/constants/helper_functions.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/screens/add_new_product_screen.dart';
import 'package:ecommerce/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Products products;
  final List<String> productCategoryList;
  const ProductDetailScreen({super.key, required this.products,required this.productCategoryList});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        openScreen(context: context, screen: AddProductScreen(productCategoryList: widget.productCategoryList,products: widget.products,));
      },child: Icon(Icons.edit),),
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                        controller: controller,
                        itemCount: widget.products.images?.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.products.images?[index] ?? "",
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.contain,
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          controller.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      MaterialButton(
                        onPressed: () {
                            controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  )
                ],
              ),
              ProductWidget(
                  id: widget.products.id ?? -1,
                  title: widget.products.title.toString(),
                  description: widget.products.description.toString(),
                  price: widget.products.price?.toDouble() ?? 0.0,
                  discountPercentage: widget.products.discountPercentage?.toDouble() ?? 0,
                  rating: widget.products.rating?.toDouble() ?? 0,
                  stock: widget.products.stock ?? 0,
                  brand: widget.products.brand.toString(),
                  category: widget.products.category.toString(),
                  thumbnail: widget.products.thumbnail.toString(),
                  images: widget.products.images ?? []),
            ],
          ),
        ));
  }
}
