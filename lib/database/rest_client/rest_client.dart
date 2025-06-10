import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('recipes')
  Future<String> getAllRecipe();
}