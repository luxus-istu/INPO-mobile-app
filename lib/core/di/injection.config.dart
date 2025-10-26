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
import 'package:inpo_mobile_app/features/home/data/datasources/news_remote_data_source.dart'
    as _i421;
import 'package:inpo_mobile_app/features/home/data/repositories/news_repository_impl.dart'
    as _i8;
import 'package:inpo_mobile_app/features/home/domain/repositories/news_repository.dart'
    as _i603;
import 'package:inpo_mobile_app/features/home/domain/usecases/get_news_usecase.dart'
    as _i109;
import 'package:inpo_mobile_app/features/home/presentation/bloc/news_bloc.dart'
    as _i140;
import 'package:inpo_mobile_app/features/specialties/data/datasources/specialties_remote_data_source.dart'
    as _i316;
import 'package:inpo_mobile_app/features/specialties/data/repositories/specialty_repository_impl.dart'
    as _i923;
import 'package:inpo_mobile_app/features/specialties/domain/repositories/specialty_repository.dart'
    as _i222;
import 'package:inpo_mobile_app/features/specialties/domain/usecases/get_specialties_usecase.dart'
    as _i665;
import 'package:inpo_mobile_app/features/specialties/presentation/bloc/specialty_bloc.dart'
    as _i240;
import 'package:inpo_mobile_app/features/specialty_detail/data/datasources/specialty_detail_remote_data_source.dart'
    as _i58;
import 'package:inpo_mobile_app/features/specialty_detail/data/repositories/specialty_detail_repository_impl.dart'
    as _i616;
import 'package:inpo_mobile_app/features/specialty_detail/domain/repositories/specialty_detail_repository.dart'
    as _i136;
import 'package:inpo_mobile_app/features/specialty_detail/domain/usecases/get_specialty_detail_usecase.dart'
    as _i881;
import 'package:inpo_mobile_app/features/specialty_detail/presentation/bloc/specialty_detail_bloc.dart'
    as _i693;

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
    gh.singleton<_i421.NewsRemoteDataSource>(
        () => const _i421.NewsRemoteDataSourceImpl());
    gh.lazySingleton<_i222.SpecialtyRepository>(() =>
        _i923.SpecialtyRepositoryImpl(gh<_i316.SpecialtiesRemoteDataSource>()));
    gh.lazySingleton<_i58.SpecialtyDetailRemoteDataSource>(
        () => const _i58.SpecialtyDetailRemoteDataSourceImpl());
    gh.singleton<_i603.NewsRepository>(() => _i8.NewsRepositoryImpl(
        remoteDataSource: gh<_i421.NewsRemoteDataSource>()));
    gh.lazySingleton<_i665.GetSpecialtiesUseCase>(
        () => _i665.GetSpecialtiesUseCase(gh<_i222.SpecialtyRepository>()));
    gh.lazySingleton<_i136.SpecialtyDetailRepository>(() =>
        _i616.SpecialtyDetailRepositoryImpl(
            gh<_i58.SpecialtyDetailRemoteDataSource>()));
    gh.lazySingleton<_i109.GetNewsUseCase>(
        () => _i109.GetNewsUseCase(gh<_i603.NewsRepository>()));
    gh.lazySingleton<_i881.GetSpecialtyDetailUseCase>(() =>
        _i881.GetSpecialtyDetailUseCase(gh<_i136.SpecialtyDetailRepository>()));
    gh.lazySingleton<_i693.SpecialtyDetailBloc>(
        () => _i693.SpecialtyDetailBloc(gh<_i881.GetSpecialtyDetailUseCase>()));
    gh.lazySingleton<_i240.SpecialtyBloc>(() => _i240.SpecialtyBloc(
        getSpecialtiesUseCase: gh<_i665.GetSpecialtiesUseCase>()));
    gh.lazySingleton<_i140.NewsBloc>(
        () => _i140.NewsBloc(gh<_i109.GetNewsUseCase>()));
    return this;
  }
}
