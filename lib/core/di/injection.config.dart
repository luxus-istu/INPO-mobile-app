// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:inpo_mobile_app/core/data/datasources/news_remote_data_source.dart'
    as _i810;
import 'package:inpo_mobile_app/core/data/repositories/news_repository_impl.dart'
    as _i193;
import 'package:inpo_mobile_app/core/domain/repositories/news_repository.dart'
    as _i702;
import 'package:inpo_mobile_app/core/domain/usecases/get_news_usecase.dart'
    as _i966;
import 'package:inpo_mobile_app/features/home/presentation/bloc/news_bloc.dart'
    as _i140;
import 'package:inpo_mobile_app/features/news/presentation/bloc/news_bloc.dart'
    as _i575;
import 'package:inpo_mobile_app/features/specialties/data/datasources/specialties_remote_data_source.dart'
    as _i316;
import 'package:inpo_mobile_app/features/specialties/data/datasources/specialty_detail_remote_data_source.dart'
    as _i853;
import 'package:inpo_mobile_app/features/specialties/data/repositories/specialty_detail_repository_impl.dart'
    as _i352;
import 'package:inpo_mobile_app/features/specialties/data/repositories/specialty_repository_impl.dart'
    as _i923;
import 'package:inpo_mobile_app/features/specialties/domain/repositories/specialty_detail_repository.dart'
    as _i862;
import 'package:inpo_mobile_app/features/specialties/domain/repositories/specialty_repository.dart'
    as _i222;
import 'package:inpo_mobile_app/features/specialties/domain/usecases/get_specialties_usecase.dart'
    as _i665;
import 'package:inpo_mobile_app/features/specialties/domain/usecases/get_specialty_detail_usecase.dart'
    as _i190;
import 'package:inpo_mobile_app/features/specialties/presentation/bloc/specialty_bloc.dart'
    as _i240;
import 'package:inpo_mobile_app/features/specialties/presentation/bloc/specialty_detail_bloc.dart'
    as _i130;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i316.SpecialtiesRemoteDataSource>(
        () => const _i316.SpecialtiesRemoteDataSourceImpl());
    gh.lazySingleton<_i810.NewsRemoteDataSource>(
        () => const _i810.NewsRemoteDataSourceImpl());
    gh.lazySingleton<_i222.SpecialtyRepository>(() =>
        _i923.SpecialtyRepositoryImpl(gh<_i316.SpecialtiesRemoteDataSource>()));
    gh.lazySingleton<_i853.SpecialtyDetailRemoteDataSource>(
        () => const _i853.SpecialtyDetailRemoteDataSourceImpl());
    gh.lazySingleton<_i702.NewsRepository>(() => _i193.NewsRepositoryImpl(
        remoteDataSource: gh<_i810.NewsRemoteDataSource>()));
    gh.lazySingleton<_i966.GetNewsUseCase>(
        () => _i966.GetNewsUseCase(gh<_i702.NewsRepository>()));
    gh.lazySingleton<_i665.GetSpecialtiesUseCase>(
        () => _i665.GetSpecialtiesUseCase(gh<_i222.SpecialtyRepository>()));
    gh.lazySingleton<_i862.SpecialtyDetailRepository>(() =>
        _i352.SpecialtyDetailRepositoryImpl(
            gh<_i853.SpecialtyDetailRemoteDataSource>()));
    gh.lazySingleton<_i575.NewsBloc>(
        () => _i575.NewsBloc(gh<_i966.GetNewsUseCase>()));
    gh.lazySingleton<_i140.NewsBloc>(
        () => _i140.NewsBloc(gh<_i966.GetNewsUseCase>()));
    gh.lazySingleton<_i240.SpecialtyBloc>(() => _i240.SpecialtyBloc(
        getSpecialtiesUseCase: gh<_i665.GetSpecialtiesUseCase>()));
    gh.lazySingleton<_i190.GetSpecialtyDetailUseCase>(() =>
        _i190.GetSpecialtyDetailUseCase(gh<_i862.SpecialtyDetailRepository>()));
    gh.lazySingleton<_i130.SpecialtyDetailBloc>(
        () => _i130.SpecialtyDetailBloc(gh<_i190.GetSpecialtyDetailUseCase>()));
    return this;
  }
}
