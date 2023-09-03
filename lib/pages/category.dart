import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:wallpaper_app/cubits/categorycubit/category_cubit.dart';
import 'package:wallpaper_app/widgets/wallperbuldier.dart';
import 'package:wallpaper_app/widgets/widgets.dart';
import '../models/photos_model.dart';

class Category extends StatelessWidget {
  final String categoryName;
  Category({super.key, required this.categoryName});

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
        body: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is CategoryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            } else if (state is CategoryLoaded) {
              BlocProvider.of<CategoryCubit>(context).isloading = false;
            } else if (state is CategoryLoading) {
              BlocProvider.of<CategoryCubit>(context).isloading = true;
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: BlocProvider.of<CategoryCubit>(context).isloading,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(children: [
                    const SizedBox(height: 16),
                    wallpapersList(
                        photos: BlocProvider.of<CategoryCubit>(context).photos,
                        context: context),
                  ]),
                ),
              ),
            );
          },
        ));
  }
}
