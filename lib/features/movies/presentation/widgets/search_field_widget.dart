import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  final void Function()? onPressedTextButton;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final void Function()? onPressedSuffixIcon;
  const SearchFieldWidget({
    Key? key,
    required this.focusNode,
    required this.onPressedTextButton,
    required this.textEditingController,
    required this.onPressedSuffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            focusNode: focusNode,
            cursorColor: AppColors.white,
            style: TextStyle(
              color: focusNode.hasFocus
                  ? AppColors.white
                  : AppColors.textFieldTextDisable,
            ),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.close,
                  color: focusNode.hasFocus
                      ? AppColors.white
                      : AppColors.textFieldTextDisable,
                ),
                onPressed: onPressedSuffixIcon,
              ),
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
            controller: textEditingController,
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          child: Text(
            'Search'.toUpperCase(),
            style: const TextStyle(
              color: AppColors.accent,
            ),
          ),
          onPressed: onPressedTextButton,
        ),
      ],
    );
  }
}
