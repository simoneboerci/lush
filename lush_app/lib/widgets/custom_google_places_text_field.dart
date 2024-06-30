import 'package:flutter/material.dart';

import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import 'package:lush_app/widgets/custom_text_field.dart';

class CustomGooglePlacesTextField extends StatelessWidget {
  const CustomGooglePlacesTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.onTap,
    this.borderRadius = 16.0,
    this.countries = const ['it'],
    this.debounceTime = 600,
    this.isLatLngRequired = true,
    this.itemClick,
    this.showError = false,
  });

  final TextEditingController controller;
  final String? hintText;
  final Function? onTap;
  final double borderRadius;
  final List<String>? countries;
  final int debounceTime;
  final bool isLatLngRequired;
  final Function(Prediction)? itemClick;
  final bool showError;

  final String _googleAPIKey = 'AIzaSyCsRrormWUEL60j4bw2oMUO0gON7Z0yBg0';

  @override
  Widget build(BuildContext context) {
    return CustomTextField.large(
      controller: controller,
      onTap: () {
        _showPlacesAutocomplete(context);
        onTap;
      },
    );
  }

  void _showPlacesAutocomplete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GooglePlaceAutoCompleteTextField(
              textEditingController: controller,
              googleAPIKey: _googleAPIKey,
              inputDecoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              debounceTime: debounceTime,
              countries: countries,
              showError: showError,
              isLatLngRequired: isLatLngRequired,
              itemClick: (Prediction prediction) {
                controller.text = prediction.description!;
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description!.length),
                );
                Navigator.of(context).pop();
                itemClick!(prediction);
              },
            ),
          ],
        ),
      ),
    );
  }
}
