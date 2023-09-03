import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import '../../data/data.dart';
import '../../models/photos_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<PhotosModel> photos = [];
  bool isloading = true;

  String numPhoto = '15';

  getTrendingWallpapers() async {
    emit(HomeLoading());
    try {
      var response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/curated?per_page=$numPhoto&page=1"),
          headers: {"Authorization": apiKEY});
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        emit(HomeLoaded(photos: photos));
      });
    } on Exception catch (e) {
      if (e.toString().contains("SocketException")) {
        emit(HomeError(error: "No Internet Connection"));
      } else {
        emit(HomeError(error: "Something Went Wrong"));
      }
    }
  }
}
