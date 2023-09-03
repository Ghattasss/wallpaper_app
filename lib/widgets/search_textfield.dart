import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField(
      {super.key, required this.searchController, required this.onTap});
  TextEditingController searchController = TextEditingController();
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Wallpaper',
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(child: const Icon(Icons.search)),
          ),
        ],
      ),
    );
  }
}
