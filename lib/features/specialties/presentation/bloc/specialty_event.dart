import 'package:equatable/equatable.dart';

sealed class SpecialtyEvent extends Equatable {
  const SpecialtyEvent();

  @override
  List<Object> get props => [];
}

class FetchSpecialties extends SpecialtyEvent {
  const FetchSpecialties();
}
