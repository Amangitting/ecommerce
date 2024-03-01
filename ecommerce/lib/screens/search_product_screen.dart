import 'package:ecommerce/cubit/product_cubit.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:ecommerce/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeachProductScreen extends StatefulWidget {
  final List<String> productCategoryList;
  const SeachProductScreen({super.key, required this.productCategoryList});

  @override
  State<SeachProductScreen> createState() => _SeachProductScreenState();
}

class _SeachProductScreenState extends State<SeachProductScreen> {
  List<Products> products_list = [];

  final TextEditingController searchController = TextEditingController();

  getProductBySearch({required String seachingText}) {
    BlocProvider.of<ProductCubit>(context)
        .getProductsBySearch(seachingText: seachingText);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  onSubmitted: (value) {
                    getProductBySearch(seachingText: value);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder()),
                ),
              ),
              BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductBySearchLoadedState) {
                    products_list = state.ProductList;
                  }
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is ProductBySearchLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductBySearchErrorState) {
                    return Text("not found");
                  }
                  return ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Products products = products_list[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                        productCategoryList:
                                            widget.productCategoryList,
                                        products: products)));
                          },
                          child: ProductWidget(
                              id: products.id ?? -1,
                              title: products.title.toString(),
                              description: products.description.toString(),
                              price: products.price?.toDouble() ?? 0.0,
                              discountPercentage:
                                  products.discountPercentage?.toDouble() ?? 0,
                              rating: products.rating?.toDouble() ?? 0,
                              stock: products.stock ?? 0,
                              brand: products.brand.toString(),
                              category: products.category.toString(),
                              thumbnail: products.thumbnail.toString(),
                              images: products.images ?? []),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: products_list.length);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
