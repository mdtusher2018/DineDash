import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class GoogleLocationPicker extends StatefulWidget {
  final TextEditingController controller;
  final Function(double lat, double lng, String address)? onPicked;
  final String label;
  final String hintText;
  final double? initialLat;
  final double? initialLng;

  const GoogleLocationPicker({
    super.key,
    required this.controller,
    this.onPicked,
    this.label = "Detailed Address*",
    this.hintText = "Search address...",
    this.initialLat,
    this.initialLng,
  });

  @override
  State<GoogleLocationPicker> createState() => _GoogleLocationPickerState();
}

class _GoogleLocationPickerState extends State<GoogleLocationPicker> {
  double? lat;
  double? lng;

  // ✅ Added to maintain focus stability
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    lat = widget.initialLat;
    lng = widget.initialLng;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        const SizedBox(height: 8),

        /// Google Places Autocomplete Field
        GooglePlaceAutoCompleteTextField(
          focusNode: _focusNode, // ✅ Keeps focus stable
          textEditingController: widget.controller,
          googleAPIKey: ApiEndpoints.mapKey,
          debounceTime: 400,
          isLatLngRequired: true,
          inputDecoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),

          getPlaceDetailWithLatLng: (Prediction prediction) {
            setState(() {
              lat = double.tryParse(prediction.lat ?? '');
              lng = double.tryParse(prediction.lng ?? '');
            });

            if (widget.onPicked != null && lat != null && lng != null) {
              widget.onPicked!(lat!, lng!, prediction.description ?? "N/A");
            }

            // ✅ Manually close suggestions and keep cursor still
            Future.delayed(const Duration(milliseconds: 100), () {
              FocusScope.of(context).unfocus();
            });
          },

          itemClick: (postalCodeResponse) {
            setState(() {
              lat = double.tryParse(postalCodeResponse.lat ?? '');
              lng = double.tryParse(postalCodeResponse.lng ?? '');
            });

            if (widget.onPicked != null && lat != null && lng != null) {
              widget.onPicked!(
                lat!,
                lng!,
                postalCodeResponse.description ?? "N/A",
              );
            }
            Future.delayed(const Duration(milliseconds: 100), () {
              FocusScope.of(context).unfocus();
            });
          },
          itemBuilder: (context, index, Prediction prediction) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      prediction.description ?? "",
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

      
      ],
    );
  }
}
