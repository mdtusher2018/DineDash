import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/features/auth/dealer/create_dealer_account_2nd_page.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:flutter/material.dart';

class BusinessSelectionPage extends StatefulWidget {
  final List<dynamic> results;

  const BusinessSelectionPage({super.key, required this.results});

  @override
  _BusinessSelectionPageState createState() => _BusinessSelectionPageState();
}

class _BusinessSelectionPageState extends State<BusinessSelectionPage> {
  dynamic selectedBusiness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: commonAppBar(
        title: "Select Your Business",
        backGroundColor: AppColors.primaryColor,
        textColor: AppColors.white,
      ),
      bottomSheet: Column(
        children: [
          // Business list
          Expanded(
            child:
                widget.results.isEmpty
                    ? const Center(
                      child: Text(
                        "No matching businesses found.",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: widget.results.length,
                      itemBuilder: (context, index) {
                        final place = widget.results[index];

                        final name = place['displayName']?['text'] ?? 'Unknown';
                        final address = place['shortFormattedAddress'] ?? '';
                        final phone = place['internationalPhoneNumber'] ?? '';
                        final website = place['websiteUri'] ?? '';
                        final photoRef =
                            (place['photos'] != null &&
                                    place['photos'].isNotEmpty)
                                ? place['photos'][0]['name']
                                : null;

                        final photoUrl =
                            photoRef != null
                                ? 'https://places.googleapis.com/v1/$photoRef/media?maxWidthPx=400&key=${ApiEndpoints.mapKey}'
                                : null;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBusiness = place;
                            });
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            color:
                                selectedBusiness == place
                                    ? Colors.blue[50] // Highlight selected item
                                    : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                width:
                                    selectedBusiness == place
                                        ? 2 // Highlight selected item
                                        : 0,
                                color:
                                    selectedBusiness == place
                                        ? AppColors
                                            .primaryColor // Highlight selected item
                                        : Colors.transparent,
                              ),
                            ),
                            elevation: 6,
                            shadowColor: Colors.black.withOpacity(0.1),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Thumbnail
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child:
                                        photoUrl != null
                                            ? Image.network(
                                              photoUrl,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (_, __, ___) => const Icon(
                                                    Icons.store,
                                                    size: 60,
                                                  ),
                                            )
                                            : const Icon(Icons.store, size: 60),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ), // Adjusted space between thumbnail and text
                                  // Business info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        commonText(
                                          name,
                                          size: 18,
                                          isBold: true,
                                        ),
                                        const SizedBox(height: 8),
                                        if (address.isNotEmpty)
                                          commonText(address, size: 14),
                                        if (phone.isNotEmpty)
                                          commonText("📞 $phone", size: 14),
                                        if (website.isNotEmpty)
                                          commonText(
                                            "🌐 $website",
                                            size: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),

          // "Continue" Button
          if (selectedBusiness != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: commonButton("Submit",onTap: () {
                navigateToPage(CreateDealerAccount2ndPage(businessDetails: selectedBusiness,));
              },),
            ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final dynamic selectedBusiness;

  const NextPage(this.selectedBusiness, {super.key});

  @override
  Widget build(BuildContext context) {
    // Show details or perform further actions based on selected business
    return Scaffold(
      appBar: AppBar(title: const Text("Business Details")),
      body: Center(
        child: Text(
          "You selected: ${selectedBusiness['displayName']?['text']}",
        ),
      ),
    );
  }
}
