import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/image_view.dart';

import '../models/photos_model.dart';

Widget wallpapersList({required List<PhotosModel> photos, context}) {
  return Container(
      child: GridView.count(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          children: photos.map((e) {
            return GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ImageView(
                      imgUrl: e.src!.portrait!,
                    );
                  }));
                },
                child: Hero(
                  tag: e.src!.portrait!,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        e.src!.portrait!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList()));
}
