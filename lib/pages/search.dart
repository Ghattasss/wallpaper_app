import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:wallpaper_app/widgets/search_textfield.dart';

import '../data/data.dart';
import '../widgets/wallperbuldier.dart';
import '../widgets/widgets.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({required this.searchQuery});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotosModel> photos = [];
  TextEditingController searchController = TextEditingController();
  getSearchWallpapers(String Query) async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$Query&per_page=15&page=1"),
        headers: {"Authorization": apiKEY});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    if (Query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Results Found,Researh Again"),
        ),
      );
      Navigator.pop(context);
    } else {
      if (jsonData["total_results"] == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No Results Found,Researh Again"),
          ),
        );
        Navigator.pop(context);
      } else {
        jsonData["photos"].forEach((element) {
          PhotosModel photosModel = PhotosModel();
          photosModel = PhotosModel.fromMap(element);
          photos.add(photosModel);
        });
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: brandName(),
            elevation: 0.0,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: (photos.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  child: Column(children: [
                    SearchTextField(
                      onTap: () {
                        getSearchWallpapers(searchController.text);
                        setState(() {
                          photos = [];
                        });
                      },
                      searchController: searchController,
                    ),
                    const SizedBox(height: 16),
                    wallpapersList(photos: photos, context: context),
                  ]),
                ),
              ));
  }
}
