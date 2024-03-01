import 'package:ecommerce/services/api_service.dart';

class ProductService {
  ApiService apiService = ApiService();

  Future<Map<String, dynamic>> getProducts() async {
    Map<String, dynamic> response = await apiService.get(endPoint: "");
    return response;
  }

  getProductsCategory() async {
    var response = await apiService.get(endPoint: "/categories");
    return response;
  }

  Future<Map<String, dynamic>> getProductsByCategory(
      {required String productsCategory}) async {
    Map<String, dynamic> response =
        await apiService.get(endPoint: "/category/" + productsCategory);
    return response;
  }

  Future<Map<String, dynamic>> getProductsBySearch(
      {required String seachingText}) async {
    Map<String, dynamic> response =
        await apiService.get(endPoint: "/search?q=" + seachingText);
    return response;
  }

  Future<Map<String, dynamic>> addProduct(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic> response =
        await apiService.post(endPoint: "/add", body: body);
    return response;
  }

  Future<Map<String, dynamic>> updateProduct(
      {required Map<String, dynamic> body, required int productId}) async {
    Map<String, dynamic> response =
        await apiService.put(endPoint: "/${productId}", body: body);
    return response;
  }
    Future<Map<String, dynamic>> deleteProduct(
      {required Map<String, dynamic> body, required int productId}) async {
    Map<String, dynamic> response =
        await apiService.delete(endPoint: "/${productId}", body: body);
    return response;
  }
}
