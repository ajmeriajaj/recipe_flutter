import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('recipes')
  Future<String> getAllRecipe();

  @GET('recipes/search')
  Future<String> searchRecipe(
      @Query('q') String query
      );

  @GET('recipes/tags')
  Future<String> getAllTags();

  @GET('recipes')
  Future<String> getPagination(
      @Query('limit') int limit,
      @Query('skip') int skip,
      );

  @GET('recipes')
  Future<String> getSort(
      @Query('sortBy') String sortBy,
      @Query('order') String order,
      );
}