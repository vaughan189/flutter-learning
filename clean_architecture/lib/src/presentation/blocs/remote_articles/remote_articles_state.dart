part of 'remote_articles_bloc.dart';

abstract class RemoteArticlesState extends Equatable {
  const RemoteArticlesState({
    this.articles = const [],
    this.noMoreData = false,
    this.error,
  });

  final List<Article> articles;
  final bool noMoreData;

  final DioError? error;

  @override
  List<Object?> get props => [articles, noMoreData, error];
}

class RemoteArticlesLoading extends RemoteArticlesState {
  const RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticlesState {
  const RemoteArticlesDone(List<Article> article, {bool noMoreData = false})
      : super(
          articles: article,
          noMoreData: noMoreData,
        );
}

class RemoteArticlesError extends RemoteArticlesState {
  const RemoteArticlesError(DioError? error) : super(error: error);
}
