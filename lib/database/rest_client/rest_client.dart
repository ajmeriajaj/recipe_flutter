import 'package:dio/dio.dart' hide Headers;
import 'package:recipe/database/headers/api_header.dart';
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

  @GET('recipes/tag/{tag}')
  Future<String> getRecipeByTags(
      @Path('tag') String tag
      );

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


  @GET('recipes/meal-type/{type}')
  Future<String> getMeals(
      @Path('type') String type
      );

  @POST('recipes/add')
  @Headers(ApiHeader.header)
  Future<String> addPost(
      @Body() Map<String, dynamic> body
      );
  
  @PUT('recipes/{id}')
  Future<String> updateRecipe(
      @Path('id') int id,
      @Body() Map<String, dynamic> body
      );

  @DELETE('recipes/{id}')
  Future<String> deteleRecipe(
      @Path('id') int id,
      @Body() Map<String, dynamic> body
      );
}