// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/adapters.dart' as _i170;
import 'package:injectable/injectable.dart' as _i526;
import 'package:inpo_mobile_app/core/data/datasources/remote/news_remote_data_source.dart'
    as _i1004;
import 'package:inpo_mobile_app/core/data/datasources/remote/news_remote_data_source_impl.dart'
    as _i188;
import 'package:inpo_mobile_app/core/data/repositories/news_repository_impl.dart'
    as _i193;
import 'package:inpo_mobile_app/core/domain/repositories/news_repository.dart'
    as _i702;
import 'package:inpo_mobile_app/core/domain/usecases/get_news_usecase.dart'
    as _i966;
import 'package:inpo_mobile_app/core/presentation/bloc/news_bloc.dart' as _i553;
import 'package:inpo_mobile_app/features/chat/data/datasources/local/chat_local_datasource.dart'
    as _i730;
import 'package:inpo_mobile_app/features/chat/data/datasources/local/chat_local_datasource_impl.dart'
    as _i698;
import 'package:inpo_mobile_app/features/chat/data/datasources/remote/chat_remote_datasource.dart'
    as _i948;
import 'package:inpo_mobile_app/features/chat/data/datasources/remote/chat_remote_datasource_impl.dart'
    as _i279;
import 'package:inpo_mobile_app/features/chat/data/models/message_model.dart'
    as _i190;
import 'package:inpo_mobile_app/features/chat/data/repositories/chat_repository_impl.dart'
    as _i418;
import 'package:inpo_mobile_app/features/chat/domain/repositories/chat_repository.dart'
    as _i831;
import 'package:inpo_mobile_app/features/chat/domain/usecases/get_messages_use_case.dart'
    as _i1071;
import 'package:inpo_mobile_app/features/chat/domain/usecases/save_message_use_case.dart'
    as _i805;
import 'package:inpo_mobile_app/features/chat/domain/usecases/send_message_use_case.dart'
    as _i833;
import 'package:inpo_mobile_app/features/chat/presentation/bloc/chat_bot_bloc.dart'
    as _i552;
import 'package:inpo_mobile_app/features/specialties/data/datasources/remote/specialties_remote_data_source.dart'
    as _i302;
import 'package:inpo_mobile_app/features/specialties/data/datasources/remote/specialties_remote_data_source_impl.dart'
    as _i859;
import 'package:inpo_mobile_app/features/specialties/data/datasources/remote/specialty_detail_remote_data_source.dart'
    as _i219;
import 'package:inpo_mobile_app/features/specialties/data/datasources/remote/specialty_detail_remote_data_source_impl.dart'
    as _i349;
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
import 'package:inpo_mobile_app/features/specialties/presentation/detail/bloc/specialty_detail_bloc.dart'
    as _i593;
import 'package:inpo_mobile_app/features/specialties/presentation/index/bloc/specialty_bloc.dart'
    as _i386;

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
    gh.lazySingleton<_i302.SpecialtiesRemoteDataSource>(
        () => _i859.SpecialtiesRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i948.ChatRemoteDataSource>(
        () => _i279.ChatRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i730.ChatLocalDataSource>(() =>
        _i698.ChatLocalDataSourceImpl(gh<_i170.Box<_i190.MessageModel>>()));
    gh.lazySingleton<_i1004.NewsRemoteDataSource>(
        () => _i188.NewsRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i222.SpecialtyRepository>(() =>
        _i923.SpecialtyRepositoryImpl(gh<_i302.SpecialtiesRemoteDataSource>()));
    gh.lazySingleton<_i219.SpecialtyDetailRemoteDataSource>(
        () => _i349.SpecialtyDetailRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i665.GetSpecialtiesUseCase>(
        () => _i665.GetSpecialtiesUseCase(gh<_i222.SpecialtyRepository>()));
    gh.lazySingleton<_i702.NewsRepository>(
        () => _i193.NewsRepositoryImpl(gh<_i1004.NewsRemoteDataSource>()));
    gh.lazySingleton<_i386.SpecialtyBloc>(() => _i386.SpecialtyBloc(
        getSpecialtiesUseCase: gh<_i665.GetSpecialtiesUseCase>()));
    gh.lazySingleton<_i831.ChatRepository>(() => _i418.ChatRepositoryImpl(
          gh<_i948.ChatRemoteDataSource>(),
          gh<_i730.ChatLocalDataSource>(),
        ));
    gh.lazySingleton<_i1071.GetMessagesUseCase>(
        () => _i1071.GetMessagesUseCase(gh<_i831.ChatRepository>()));
    gh.lazySingleton<_i833.SendMessageUseCase>(
        () => _i833.SendMessageUseCase(gh<_i831.ChatRepository>()));
    gh.lazySingleton<_i862.SpecialtyDetailRepository>(() =>
        _i352.SpecialtyDetailRepositoryImpl(
            gh<_i219.SpecialtyDetailRemoteDataSource>()));
    gh.lazySingleton<_i805.SaveMessageUseCase>(
        () => _i805.SaveMessageUseCase(gh<_i831.ChatRepository>()));
    gh.lazySingleton<_i966.GetNewsUseCase>(
        () => _i966.GetNewsUseCase(gh<_i702.NewsRepository>()));
    gh.lazySingleton<_i552.ChatBotBloc>(() => _i552.ChatBotBloc(
          gh<_i1071.GetMessagesUseCase>(),
          gh<_i833.SendMessageUseCase>(),
          gh<_i805.SaveMessageUseCase>(),
        ));
    gh.lazySingleton<_i553.NewsBloc>(
        () => _i553.NewsBloc(gh<_i966.GetNewsUseCase>()));
    gh.lazySingleton<_i190.GetSpecialtyDetailUseCase>(() =>
        _i190.GetSpecialtyDetailUseCase(gh<_i862.SpecialtyDetailRepository>()));
    gh.lazySingleton<_i593.SpecialtyDetailBloc>(
        () => _i593.SpecialtyDetailBloc(gh<_i190.GetSpecialtyDetailUseCase>()));
    return this;
  }
}
