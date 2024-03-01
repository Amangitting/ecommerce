import 'package:ecommerce/cubit/product_cubit.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:ecommerce/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryType;
  final List<String>productCategoryList;
  const ProductsByCategoryScreen({super.key, required this.categoryType, required this.productCategoryList});

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  getProductsByCategory() {
    BlocProvider.of<ProductCubit>(context)
        .getProductsByCategory(productsCategory: widget.categoryType);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.categoryType),
          ),
          body: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is ProductByCategoryLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductByCategoryLoadedState) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Products products = state.ProductList[index];
      
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(products: products,productCategoryList: widget.productCategoryList,)));
                        },
                        child: ProductWidget(
                            id: products.id ?? -1,
                            title: products.title.toString(),
                            description: products.description.toString(),
                            price: products.price?.toDouble() ?? 0.0,
                            discountPercentage: products.discountPercentage?.toDouble() ?? 0,
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
                    itemCount: state.ProductList.length);
              } else {
                return SizedBox();
              }
            },
          )),
    );
  }
}
