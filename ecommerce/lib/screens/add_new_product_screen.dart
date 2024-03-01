import 'package:ecommerce/constants/helper_functions.dart';
import 'package:ecommerce/cubit/product_cubit.dart';
import 'package:ecommerce/models/add_product_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/screens/product_screen.dart';
import 'package:ecommerce/widgets/customTextField.dart';
import 'package:ecommerce/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductScreen extends StatefulWidget {
  final Products? products;
  final List<String> productCategoryList;

  const AddProductScreen(
      {super.key, required this.productCategoryList, this.products});
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final ValueNotifier<String> selectedCategory = ValueNotifier('');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.products != null) {
      _titleController.text = widget.products?.title ?? "";
      _descriptionController.text = widget.products?.description ?? "";

      _discountController.text = widget.products!.discountPercentage.toString();

      _ratingController.text = widget.products!.rating.toString();

      _priceController.text = widget.products!.price.toString();

      _stockController.text = widget.products!.stock.toString();

      _brandController.text = widget.products!.brand.toString();
      selectedCategory.value = widget.products!.category!;
    } else {
      selectedCategory.value = widget.productCategoryList[0];
    }
  }

  addProduct({required AddProductModel productModel}) {
    BlocProvider.of<ProductCubit>(context)
        .addProduct(productModel: productModel);
  }

  updateProduct({required AddProductModel productModel}) {
    BlocProvider.of<ProductCubit>(context).updateProduct(
        productModel: productModel, productId: widget.products?.id ?? -1);
  }

  deleteProduct({required Products products}) {
    BlocProvider.of<ProductCubit>(context).deleteProduct(
        products: products, productId: widget.products?.id ?? -1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            widget.products == null
                ? SizedBox()
                : IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Are you sure you want to delete ${widget.products?.title.toString()}",
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: () {
                                    closeScreen(context: context);
                                  },
                                  child: Text("Cancel"),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    deleteProduct(products: widget.products!);
                                  },
                                  child: Text("Yes"),
                                )
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.delete))
          ],
          title: Text('Add Product'),
        ),
        body: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
          if (state is ProductAddedState) {
            CustomToast.showToast(
                "Product Added successfully, but not reflect in actual data as these are dummy apis");

            replaceScreen(
                context: context,
                screen: ProductScreen(
                  newProductId: state.id,
                ));
          }
       else   if (state is ProductUpdatedState) {
            CustomToast.showToast(
                "Product updated successfully, but not reflect in actual data as these are dummy apis");

            replaceScreen(
                context: context,
                screen: ProductScreen(
                  newProductId: state.id,
                ));
          }
       else   if (state is ProductDeletedState) {
            CustomToast.showToast(
                "Product deleted successfully ${state.deletedTime.toString().substring(0, 10)}, but not reflect in actual data as these are dummy apis");

            replaceScreen(context: context, screen: ProductScreen());
          }

          // TODO: implement listener
        }, builder: (context, state) {
          if (state is ProductAddingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    CustomTextField(
                        controller: _titleController,
                        labelText: 'Title',
                        validateText: 'Please enter a title'),
                    // TextFormField(
                    //   controller: _titleController,
                    //   decoration: InputDecoration(labelText: 'Title'),
                    //   validator: (value) {
                    //     if (value?.isEmpty??false) {
                    //       return 'Please enter a title';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    CustomTextField(
                        controller: _descriptionController,
                        labelText: 'Description',
                        maxLine: 4,
                        validateText: 'Please enter a description'),

                    CustomTextField(
                        controller: _discountController,
                        labelText: 'Discount Percentage',
                        keyboardType: TextInputType.number,
                        validateText: 'Please enter a discount'),

                    CustomTextField(
                        controller: _ratingController,
                        labelText: 'Rating',
                        keyboardType: TextInputType.number,
                        validateText: 'Please enter a rating'),
                    CustomTextField(
                        controller: _priceController,
                        labelText: 'Price',
                        keyboardType: TextInputType.number,
                        validateText: 'Please enter a Price'),
                    CustomTextField(
                        controller: _stockController,
                        labelText: 'Stock',
                        keyboardType: TextInputType.number,
                        validateText: 'Please enter a stock quantity'),
                    CustomTextField(
                        controller: _brandController,
                        labelText: 'Brand',
                        validateText: 'Please enter brand name'),

                    ValueListenableBuilder<String>(
                      valueListenable: selectedCategory,
                      builder: (context, state, _) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: .5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                isExpanded: true,
                                value: state,
                                items: widget.productCategoryList.map((e) {
                                  return DropdownMenuItem(
                                      value: e, child: Text(e));
                                }).toList(),
                                onChanged: (value) {
                                  selectedCategory.value = value!;
                                }),
                          ),
                        );
                      },
                    )

                    // TextFormField(
                    //   controller: _categoryController,
                    //   decoration: InputDecoration(labelText: 'Category'),
                    //   validator: (value) {
                    //     if (value?.isEmpty ?? false) {
                    //       return 'Please enter category';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    ,
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Submit the form
                          _submitForm();
                        }
                      },
                      child: widget.products != null
                          ? Text("Update Product")
                          : Text('Add Product'),
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }

  void _submitForm() {
    if (widget.products != null) {
      updateProduct(
          productModel: AddProductModel(
              id: widget.products?.id ?? -1,
              title: _titleController.text,
              description: _descriptionController.text,
              price: int.parse(_priceController.text),
              discountPercentage: _discountController.text.isNotEmpty
                  ? double.parse(_discountController.text)
                  : 0.0,
              rating: _ratingController.text.isNotEmpty
                  ? double.parse(_ratingController.text)
                  : 0.0,
              stock: int.parse(_stockController.text),
              brand: _brandController.text,
              category: selectedCategory.value));
    } else {
      addProduct(
          productModel: AddProductModel(
              title: _titleController.text,
              description: _descriptionController.text,
              price: int.parse(_priceController.text),
              discountPercentage: _discountController.text.isNotEmpty
                  ? double.parse(_discountController.text)
                  : 0.0,
              rating: _ratingController.text.isNotEmpty
                  ? double.parse(_ratingController.text)
                  : 0.0,
              stock: int.parse(_stockController.text),
              brand: _brandController.text,
              category: selectedCategory.value));

      // Here you can handle what to do with the form data
      // For now, you can print it
    }

    TextField({required contr}) {
      return TextFormField(
        controller: _categoryController,
        decoration: InputDecoration(labelText: 'Category'),
        validator: (value) {
          if (value?.isEmpty ?? false) {
            return 'Please enter category';
          }
          return null;
        },
      );
    }
  }
}
