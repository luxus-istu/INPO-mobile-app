import 'package:inpo_mobile_app/features/specialties/domain/entities/specialty.dart';
import 'package:equatable/equatable.dart';

sealed class SpecialtyState extends Equatable {
  const SpecialtyState();

  @override
  List<Object> get props => [];
}

class SpecialtyInitial extends SpecialtyState {
  const SpecialtyInitial();
}

class SpecialtyLoading extends SpecialtyState {
  const SpecialtyLoading();
}

class SpecialtyLoaded extends SpecialtyState {
  final List<Specialty> specialties;

  const SpecialtyLoaded(this.specialties);

  @override
  List<Object> get props => [specialties];
}

class SpecialtyError extends SpecialtyState {
  final String message;

  const SpecialtyError(this.message);

  @override
  List<Object> get props => [message];
}
