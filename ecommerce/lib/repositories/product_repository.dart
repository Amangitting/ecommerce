import 'package:ecommerce/models/add_product_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/services/product_service.dart';

class ProductRepository {
  ProductService productService = ProductService();
  Future<ProductModel> getProduct() async {
    Map<String, dynamic> products = await productService.getProducts();

    if (products.keys.first == "error") {
      return ProductModel();
    }
    return ProductModel.fromJson(products);
  }

  Future<ProductModel> getProductsByCategory(
      {required String productsCategory}) async {
    Map<String, dynamic> products = await productService.getProductsByCategory(
        productsCategory: productsCategory);

    if (products.keys.first == "error") {
      return ProductModel();
    }
    return ProductModel.fromJson(products);
  }

  Future<ProductModel> getProductsBySearch(
      {required String seachingText}) async {
    Map<String, dynamic> products =
        await productService.getProductsBySearch(seachingText: seachingText);

    if (products.keys.first == "error") {
      return ProductModel();
    }
    return ProductModel.fromJson(products);
  }

  Future<List<String>> getProductCategory() async {
    List<String> list = [];
    List productCategoryList = await productService.getProductsCategory();

    productCategoryList.forEach((element) {
      list.add(element.toString());
    });
    return list;
  }

  Future<AddProductModel> addProduct(
      {required AddProductModel addProductModel}) async {
    Map<String, dynamic> products =
        await productService.addProduct(body: addProductModel.toJson());

    return AddProductModel.fromJson(products);
  }
  
  Future<Products> updateProduct(
      {required AddProductModel addProductModel,required int productId}) async {
    Map<String, dynamic> products =
        await productService.updateProduct(
          productId: productId,
          body: addProductModel.toFormData());

    return Products.fromJson(products);
  }
    Future<Products> deleteProduct(
      {required Products products,required int productId}) async {
    Map<String, dynamic> productResponse =
        await productService.deleteProduct(
          productId: productId,
          body: products.toFormData());

    return Products.fromJson(productResponse);
  }
}
