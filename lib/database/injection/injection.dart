import 'package:dio/dio.dart';
import 'package:recipe/database/rest_client/rest_client.dart';

final dio = Dio(BaseOptions(

));

final restClient = RestClient(Dio());