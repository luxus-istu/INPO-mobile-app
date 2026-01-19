import 'package:flutter_test/flutter_test.dart';
import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:inpo_mobile_app/features/specialties/domain/usecases/get_specialties_usecase.dart';
import 'package:inpo_mobile_app/core/resources/data_state.dart';
import 'package:inpo_mobile_app/features/specialties/domain/repositories/specialty_repository.dart';
import 'package:mockito/mockito.dart';

// Mock implementation instead of using @GenerateMocks
class MockSpecialtyRepository extends Mock implements SpecialtyRepository {
  @override
  Future<DataState<List<Specialty>>> getSpecialties() {
    return super.noSuchMethod(
      Invocation.method(#getSpecialties, []),
      returnValue: Future<DataState<List<Specialty>>>.value(DataSuccess([])),
      returnValueForMissingStub:
          Future<DataState<List<Specialty>>>.value(DataSuccess([])),
    ) as Future<DataState<List<Specialty>>>;
  }
}

void main() {
  late GetSpecialtiesUseCase useCase;
  late MockSpecialtyRepository mockRepository;

  setUp(() {
    mockRepository = MockSpecialtyRepository();
    useCase = GetSpecialtiesUseCase(mockRepository);
  });

  group('GetSpecialtiesUseCase', () {
    test(
        'should return DataSuccess when repository returns specialties successfully',
        () async {
      // Arrange
      final specialtiesList = [
        Specialty(code: '38.02.01', title: 'Экономика'),
        Specialty(code: '38.02.02', title: 'Менеджмент'),
      ];
      when(mockRepository.getSpecialties())
          .thenAnswer((_) async => DataSuccess(specialtiesList));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<DataSuccess<List<Specialty>>>());
      expect((result as DataSuccess).data, specialtiesList);
      verify(mockRepository.getSpecialties()).called(1);
    });

    test('should throw exception when repository throws exception', () async {
      // Arrange
      final exception = Exception('Failed to fetch specialties');
      when(mockRepository.getSpecialties()).thenThrow(exception);

      // Act & Assert
      expect(() => useCase(), throwsA(isA<Exception>()));
      verify(mockRepository.getSpecialties()).called(1);
    });

    test('should return DataFailed when repository returns DataFailed',
        () async {
      // Arrange
      final error = Exception('Repository error');
      when(mockRepository.getSpecialties())
          .thenAnswer((_) async => DataFailed(error));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<DataFailed>());
      expect((result as DataFailed).error, error);
      verify(mockRepository.getSpecialties()).called(1);
    });
  });
}
