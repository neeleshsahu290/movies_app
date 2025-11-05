import 'package:movies_app/core/network/repository/base_repository.dart';
import 'package:movies_app/core/network/result.dart';
import 'package:movies_app/search/domain/entities/search_result_item.dart';

abstract class SearchRepository extends BaseRepository  {
    Future<Result<List<SearchResultItem>>> search(String title);

}


