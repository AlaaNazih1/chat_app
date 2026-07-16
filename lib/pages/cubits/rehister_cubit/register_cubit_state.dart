part of 'register_cubit_cubit.dart';

@immutable
sealed class RegisterCubitState {}

 class RegisterCubitInitial extends RegisterCubitState {}
  class RegisterCubitLoading extends RegisterCubitState {}
  class RegisterCubitSuccess extends RegisterCubitState {}
  class RegisterCubitFailure extends RegisterCubitState {
  String erroeMessage;
   RegisterCubitFailure({required this.erroeMessage});
  }

