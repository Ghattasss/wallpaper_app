part of 'category_cubit.dart';

abstract class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<PhotosModel> photos;
  CategoryLoaded({required this.photos});
}

final class CategoryError extends CategoryState {
  final String error;
  CategoryError({required this.error});
}
