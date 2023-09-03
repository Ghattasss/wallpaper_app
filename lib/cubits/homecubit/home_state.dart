part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<PhotosModel> photos;
  HomeLoaded({required this.photos});
}

final class HomeError extends HomeState {
  final String error;
  HomeError({required this.error});
}
