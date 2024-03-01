import 'package:ecommerce/constants/helper_functions.dart';
import 'package:ecommerce/cubit/product_cubit.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/screens/add_new_product_screen.dart';
import 'package:ecommerce/screens/product_detail_screen.dart';
import 'package:ecommerce/screens/products_by_category_screen.dart';
import 'package:ecommerce/screens/search_product_screen.dart';
import 'package:ecommerce/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  final int? newProductId;
  const ProductScreen({super.key, this.newProductId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductCategoryLoadedState) {
          productsCategory = state.ProductCategoryList;
        }
      },
      child: Container(),
    );
    getProduct();
    getProductCategory();
  }

  getProduct() {
    BlocProvider.of<ProductCubit>(context).getProduct();
  }

  getProductCategory() {
    BlocProvider.of<ProductCubit>(context).getProductCategory();
  }

  List<String> productsCategory = [];
  List<Products> products_list = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              openScreen(
                  context: context,
                  screen:
                      AddProductScreen(productCategoryList: productsCategory));
            },
            child: Icon(Icons.add),
          ),
          drawer: Drawer(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text("Categories"),
                  ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(),
                        );
                      },
                      itemCount: productsCategory.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            openScreen(
                                context: context,
                                screen: ProductsByCategoryScreen(
                                    productCategoryList: productsCategory,
                                    categoryType: productsCategory[index]));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              productsCategory[index],
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          )),
          appBar: AppBar(
            title: Text("Products"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    onTap: () {
                      openScreen(
                          context: context,
                          screen: SeachProductScreen(
                            productCategoryList: productsCategory,
                          ));
                    },
                    decoration: InputDecoration(
                        hintText: "Search Products",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder()),
                  ),
                ),
                BlocConsumer<ProductCubit, ProductState>(
                  listener: (context, state) {
                    if (state is ProductCategoryLoadedState) {
                      productsCategory = state.ProductCategoryList ?? [];
                      setState(() {});
                    }
                    if (state is ProductLoadedState) {
                      products_list = state.ProductList;
                      // if(widget.newProductId!=null){
                      //   products_list=[];
                      //   state.ProductList.forEach((element) {
                      //     if(element.id==widget.newProductId)
                      //     products_list.add(element);
                      //   });

                      // }
                    }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is ProductLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ProductErrorState) {
                      return SizedBox();
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
                                          productCategoryList: productsCategory,
                                          products: products)));
                            },
                            child: ProductWidget(
                                id: products.id ?? -1,
                                title: products.title.toString(),
                                description: products.description.toString(),
                                price: products.price?.toDouble() ?? 0.0,
                                discountPercentage:
                                    products.discountPercentage?.toDouble() ??
                                        0,
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
          )),
    );
  }
}
