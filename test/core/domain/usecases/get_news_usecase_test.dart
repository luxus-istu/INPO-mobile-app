import 'package:flutter_test/flutter_test.dart';
import 'package:inpo_mobile_app/core/domain/entities/news_item.dart';
import 'package:inpo_mobile_app/core/domain/usecases/get_news_usecase.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/core/domain/repositories/news_repository.dart';
import 'package:mockito/mockito.dart';

// Mock implementation instead of using @GenerateMocks
class MockNewsRepository extends Mock implements NewsRepository {
  @override
  Future<DataState<List<NewsItem>>> getNews(String path) {
    return super.noSuchMethod(
      Invocation.method(#getNews, []),
      returnValue: Future<DataState<List<NewsItem>>>.value(DataSuccess([])),
      returnValueForMissingStub:
          Future<DataState<List<NewsItem>>>.value(DataSuccess([])),
    ) as Future<DataState<List<NewsItem>>>;
  }
}

void main() {
  late GetNewsUseCase useCase;
  late MockNewsRepository mockRepository;

  setUp(() {
    mockRepository = MockNewsRepository();
    useCase = GetNewsUseCase(mockRepository);
  });

  group('GetNewsUseCase', () {
    test('should return DataSuccess when repository returns news successfully',
        () async {
      // Arrange
      final newsList = [
        const NewsItem(title: 'News 1', date: '2024-01-01'),
        const NewsItem(title: 'News 2', date: '2024-01-02'),
      ];
      when(mockRepository.getNews())
          .thenAnswer((_) async => DataSuccess(newsList));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<DataSuccess<List<NewsItem>>>());
      expect((result as DataSuccess).data, newsList);
      verify(mockRepository.getNews()).called(1);
    });

    test('should throw exception when repository throws exception', () async {
      // Arrange
      final exception = Exception('Failed to fetch news');
      when(mockRepository.getNews()).thenThrow(exception);

      // Act & Assert
      expect(() => useCase(), throwsA(isA<Exception>()));
      verify(mockRepository.getNews()).called(1);
    });

    test('should return DataFailed when repository returns DataFailed',
        () async {
      // Arrange
      final error = Exception('Repository error');
      when(mockRepository.getNews()).thenAnswer((_) async => DataFailed(error));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<DataFailed>());
      expect((result as DataFailed).error, error);
      verify(mockRepository.getNews()).called(1);
    });
  });
}
