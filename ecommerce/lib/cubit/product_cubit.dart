import 'dart:ffi';

import 'package:ecommerce/models/add_product_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

//////////////////////////////////////////////////////
///for All products
///
class ProductLoadedState extends ProductState {
  final List<Products> ProductList;
  // final List<String> ? productCategoryList;

  ProductLoadedState({required this.ProductList});
}

class ProductLoadingState extends ProductState {}

class ProductErrorState extends ProductState {}

///////////////////////////////////////////////////
///for product categories
///
class ProductCategoryLoadedState extends ProductState {
  final List<String> ProductCategoryList;

  ProductCategoryLoadedState({required this.ProductCategoryList});
}

class ProductCategoryLoadingState extends ProductState {}

class ProductCategoryErrorState extends ProductState {}

////////////////////////////////////////////////////////////
///products by category
///
class ProductByCategoryLoadedState extends ProductState {
  final List<Products> ProductList;
  // final List<String> ? productCategoryList;

  ProductByCategoryLoadedState({required this.ProductList});
}

class ProductByCategoryLoadingState extends ProductState {}

class ProductByCategoryErrorState extends ProductState {}

////////////////////////////////////////////////////////
///productby search
class ProductBySearchLoadedState extends ProductState {
  final List<Products> ProductList;
  // final List<String> ? productCategoryList;

  ProductBySearchLoadedState({required this.ProductList});
}

class ProductBySearchLoadingState extends ProductState {}

class ProductBySearchErrorState extends ProductState {}

///////////////////////////////////////////////////////////
///AddProduct
class ProductAddedState extends ProductState {
  final int id;

  ProductAddedState({required this.id});
}

class ProductAddingState extends ProductState {}

class ProductAddingErrorState extends ProductState {}

///////////////////////////////////////////////////////
///product updation
class ProductUpdatedState extends ProductState {
  final int id;

  ProductUpdatedState({required this.id});
}

class ProductUpdatingState extends ProductState {}

class ProductUpdatingErrorState extends ProductState {}
/////////////////////////////////////////////////////
///product deletion
class ProductDeletedState extends ProductState {

  final String deletedTime;

  ProductDeletedState({required this.deletedTime});
}

///////////////////////////////////////////////////////////
///cubit

class ProductCubit extends Cubit<ProductState> {
  ProductRepository productRepository = ProductRepository();
  ProductCubit() : super(ProductInitialState());

  getProduct() async {
    emit(ProductLoadingState());

    productRepository.getProduct().then((value) {
      emit(ProductLoadedState(
        ProductList: value.products ?? [],
      ));
    }).onError((error, stackTrace) {
      emit(ProductErrorState());
    });
    // await productRepository.getProductCategory().then((prouctCategoryList) {
    // }).onError((error, stackTrace) {
    //   emit(ProductErrorState());
    // });
  }

  getProductsByCategory({required String productsCategory}) async {
    emit(ProductByCategoryLoadingState());
    await productRepository
        .getProductsByCategory(productsCategory: productsCategory)
        .then((value) {
      emit(ProductByCategoryLoadedState(ProductList: value.products ?? []));
    });
  }

  getProductsBySearch({required String seachingText}) async {
    emit(ProductBySearchLoadingState());
    await productRepository
        .getProductsBySearch(seachingText: seachingText)
        .then((value) {
      emit(ProductBySearchLoadedState(ProductList: value.products ?? []));
    });
  }

  getProductCategory() async {
    emit(ProductLoadingState());

    await productRepository.getProductCategory().then((value) {
      emit(ProductCategoryLoadedState(ProductCategoryList: value));
    }).onError((error, stackTrace) {
      emit(ProductCategoryErrorState());
    });
  }

  addProduct({required AddProductModel productModel}) async {
    emit(ProductAddingState());

    await productRepository
        .addProduct(addProductModel: productModel)
        .then((value) {
      emit(ProductAddedState(id: value.id!));
    }).onError((error, stackTrace) {
      emit(ProductAddingErrorState());
    });
  }

  updateProduct(
      {required AddProductModel productModel, required int productId}) async {
    emit(ProductAddingState());

    await productRepository
        .updateProduct(addProductModel: productModel, productId: productId)
        .then((value) {
      emit(ProductUpdatedState(id: value.id!));
    }).onError((error, stackTrace) {
      emit(ProductAddingErrorState());
    });
  }
    deleteProduct(
      {required Products products, required int productId}) async {
    emit(ProductAddingState());

    await productRepository
        .deleteProduct(products: products, productId: productId)
        .then((value) {
      emit(ProductDeletedState(deletedTime: value.deletedOn??""));
    }).onError((error, stackTrace) {
      emit(ProductAddingErrorState());
    });
  }
}
