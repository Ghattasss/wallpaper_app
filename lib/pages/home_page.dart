import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:wallpaper_app/cubits/homecubit/home_cubit.dart';
import 'package:wallpaper_app/pages/search.dart';
import 'package:wallpaper_app/widgets/search_textfield.dart';
import 'package:wallpaper_app/widgets/widgets.dart';
import '../data/data.dart';
import '../models/catigeories_model.dart';
import '../widgets/categories_tile.dart';
import '../widgets/wallperbuldier.dart';

class WallpaperHome extends StatelessWidget {
  List<CategorieModel> categories = getCategories();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: brandName(),
        elevation: 0.0,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is HomeLoaded) {
            BlocProvider.of<HomeCubit>(context).isloading = false;
          } else if (state is HomeLoading) {
            BlocProvider.of<HomeCubit>(context).isloading = true;
          }
        },
        builder: (context, state) {
          return SuccessBody(
              searchController: searchController, categories: categories);
        },
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({
    super.key,
    required this.searchController,
    required this.categories,
  });

  final TextEditingController searchController;
  final List<CategorieModel> categories;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: BlocProvider.of<HomeCubit>(context).isloading,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SearchTextField(
                searchController: searchController,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search(
                                searchQuery: searchController.text,
                              )));
                },
              ),
              const SizedBox(height: 16),
              Container(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: ((context, index) {
                    return CategoryTile(
                      imgUrl: categories[index].imgUrl!,
                      title: categories[index].categorieName!,
                    );
                  }),
                  itemCount: categories.length,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              wallpapersList(
                  photos: BlocProvider.of<HomeCubit>(context).photos,
                  context: context),
            ],
          ),
        ),
      ),
    );
  }
}
