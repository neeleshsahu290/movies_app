import 'package:dio/dio.dart';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/network/result.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';
import 'package:movies_app/search/domain/repository/search_repository.dart';
import 'package:movies_app/search/domain/services/search_api_service.dart';

class SearchRepositoryImpl extends SearchRepository {

  SearchRepositoryImpl(this.dio);
 SearchApiService get _searchApiService => SearchApiService(dio,baseUrl: ApiConstants.apiEndpoint);
  
  @override
  final Dio dio;

  @override
  Future<Result<List<SearchResultItem>>> search(String title) async {
    return safeCall(
      _searchApiService.search(title),
      entityMapper: (response) => response,
    );
  }


}
