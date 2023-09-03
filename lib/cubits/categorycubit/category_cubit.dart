import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../../data/data.dart';
import '../../models/photos_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  List<PhotosModel> photos = [];
  bool isloading = true;
  String numPhoto = '15';

  getCateoryWallpapers(String Query) async {
    emit(CategoryLoading());

    try {
      var response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$Query&pe0r_page=${numPhoto}&page=1"),
          headers: {"Authorization": apiKEY});
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      emit(CategoryLoaded(photos: photos));
    } on Exception catch (e) {
      if (e.toString().contains("SocketException")) {
        emit(CategoryError(error: "No Internet Connection"));
      } else {
        emit(CategoryError(error: "Something Went Wrong"));
      }
    }
  }
}
