import 'package:dio/dio.dart';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/search/data/models/search_result_item_model.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'search_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiEndpoint)
abstract class SearchApiService {
  factory SearchApiService(Dio dio, {String baseUrl}) = _SearchApiService;

  // Search Movies
  @GET(ApiConstants.searchPath)
  Future<List<SearchResultItem>> search(@Query('query') String title);
}
