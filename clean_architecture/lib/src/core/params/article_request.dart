import '../utils/constants.dart';

class ArticlesRequestParams {
  ArticlesRequestParams({
    this.apiKey = kApiKey,
    this.country = 'us',
    this.category = 'general',
    this.page = 1,
    this.pageSize = 20,
  });

  final String apiKey;
  final String country;
  final String category;
  final int page;
  final int pageSize;
}
