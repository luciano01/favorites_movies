import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  final void Function()? onTap;
  final FocusNode focusNode;
  const SearchFieldWidget({
    Key? key,
    required this.onTap,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        focusNode: focusNode,
        cursorColor: AppColors.white,
        style: TextStyle(
          color: focusNode.hasFocus
              ? AppColors.white
              : AppColors.textFieldTextDisable,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.textFieldBackground,
          hintText: 'Search by Title',
          hintStyle: const TextStyle(
            color: AppColors.textFieldTextDisable,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: focusNode.hasFocus
                ? AppColors.white
                : AppColors.textFieldTextDisable,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.accent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.textFieldBackground,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
