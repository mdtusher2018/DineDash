import 'dart:developer';

import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/ApiEndpoints.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/core/controller/city_controller.dart';
import 'package:dine_dash/features/explore/user_explore_controller.dart';
import 'package:dine_dash/features/explore/user_explore_map_response.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/user_resturant_card.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/user_business_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class UserExplorePage extends StatefulWidget {
  const UserExplorePage({super.key});

  @override
  State<UserExplorePage> createState() => _UserExplorePageState();
}

class _UserExplorePageState extends State<UserExplorePage> {
  bool showMap = false;

  UserExploreController controller = Get.find<UserExploreController>();
  final CityController cityController = Get.find<CityController>();
  final TextEditingController searchTermController = TextEditingController();
  SessionMemory sessionMemory = Get.find();
  GoogleMapController? _mapController;
  BitmapDescriptor? customMarkerIcon;
  String selectedSortBy = 'Low';
  RxString selectedDate = "".obs;

  List<String> days = [
    "Today",
    "Tomorrow",
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadCustomMarker();
      controller.getCurrentLocation();
      cityController.fetchCities();
      controller.fetchBusinessesOnMap();
      controller.fetchBusinessesList();
    });
  }

  Future<void> _loadCustomMarker() async {
    final icon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(50, 50)),
      'assets/images/map_icon.png',
    );
    setState(() {
      customMarkerIcon = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Content
          showMap
              ? _buildMapView()
              : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildListView(),
                ),
              ),

          if (showMap)
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16, right: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,

                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: searchTermController,
                  googleAPIKey: ApiEndpoints.mapKey,
                  containerVerticalPadding: 4,
                  focusNode: FocusNode(),
                  inputDecoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Search Location",

                    fillColor: Color(0xFFDCE7FA),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  debounceTime: 800,
                  boxDecoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFDCE7FA),
                  ),

                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (prediction) {
                    if (prediction.lat != null && prediction.lng != null) {
                      final LatLng target = LatLng(
                        double.parse(prediction.lat!),
                        double.parse(prediction.lng!),
                      );
                      controller.fetchBusinessesOnMap(
                        lat: target.latitude,
                        lng: target.longitude,
                      );
                      _mapController?.animateCamera(
                        CameraUpdate.newLatLngZoom(target, 13),
                      );
                    }
                  },
                  itemClick: (prediction) {
                    searchTermController.text = prediction.description!;
                    searchTermController.selection = TextSelection.fromPosition(
                      TextPosition(offset: prediction.description!.length),
                    );
                    if (prediction.lat != null && prediction.lng != null) {
                      final LatLng target = LatLng(
                        double.parse(prediction.lat!),
                        double.parse(prediction.lng!),
                      );
                      controller.fetchBusinessesOnMap(
                        lat: target.latitude,
                        lng: target.longitude,
                      );
                      _mapController?.animateCamera(
                        CameraUpdate.newLatLngZoom(target, 13),
                      );
                    }
                  },
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  toggleButton(
                    icon: "assets/images/location2.png",
                    label: 'Map',
                    isSelected: showMap,
                    onTap: () async {
                      setState(() => showMap = true);

                      if (_mapController != null) {
                        LatLng businessLocation;

                        final position = await getCurrentPosition(
                          controller: controller,
                        );
                        businessLocation = LatLng(
                          position.latitude,
                          position.longitude,
                        );

                        _mapController!.animateCamera(
                          CameraUpdate.newLatLngZoom(businessLocation, 15),
                        );
                      }
                    },

                    isleft: true,
                  ),

                  toggleButton(
                    icon: "assets/images/bottom nav/explore_u.png",
                    label: 'List',

                    isSelected: !showMap,
                    onTap: () => setState(() => showMap = false),
                    isleft: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget toggleButton({
    required String icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isleft,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular((isleft) ? 30 : 0),
            bottomLeft: Radius.circular((isleft) ? 30 : 0),
            bottomRight: Radius.circular((isleft) ? 0 : 30),
            topRight: Radius.circular((isleft) ? 0 : 30),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            CommonImage(
              icon,
              color: isSelected ? Colors.white : AppColors.primaryColor,
              width: 24,
            ),
            const SizedBox(width: 6),
            commonText(
              label,
              size: 14,
              color: isSelected ? Colors.white : AppColors.primaryColor,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapView() {
    // Dhaka coordinates

    return Obx(() {
      if (controller.currentPosition.value == null) {
        return Center(child: CircularProgressIndicator());
      }
      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: controller.currentPosition.value!,
          zoom: 10,
        ),
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        mapToolbarEnabled: false,

        markers: _buildMarkers(),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller; // Save it
        },
      );
    });
  }

  Set<Marker> _buildMarkers() {
    return controller.businessesOnMap.map((b) {
      return Marker(
        markerId: MarkerId(b.id),
        position: LatLng(b.coordinates[1], b.coordinates[0]),
        infoWindow: InfoWindow(title: b.name),
        onTap: () {
          _showBottomSheet(context, b);
        },
        icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
      );
    }).toSet();
  }

  void _showBottomSheet(BuildContext context, BusinessOnMap business) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SizedBox(
                  child: RestaurantCard(
                    imageUrl: business.image,
                    title: business.name,
                    rating: business.rating.toDouble(),
                    reviewCount: business.totalReview,
                    priceRange: "",
                    openTime: business.openTimeText,
                    location: business.formattedAddress,
                    tags: business.type.map((e) => e.toString()).toList(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              commonButton(
                "See Details",
                boarderRadious: 10,
                height: 40,
                onTap: () {
                  Navigator.pop(context);
                  navigateToPage(
                    UserBusinessDetailsPage(businessId: business.id),
                    context: context, //restaurantId: restaurant.id
                  );
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListView() {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels ==
                notification.metrics.maxScrollExtent &&
            !controller.isLoadingMore &&
            controller.currentPage < controller.totalPages) {
          controller.fetchBusinessesList(
            city: cityController.selectedCity.split('-').first,
            searchTerm:
                searchTermController.text.trim().isNotEmpty
                    ? searchTermController.text.trim()
                    : null,
            sortBy: selectedSortBy,
            loadMore: true,
          );
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          controller.fetchBusinessesList();
          cityController.selectedCity.value = "";
          searchTermController.clear();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchTermController,
                        decoration: InputDecoration(
                          hintText: "Search restaurants, foods...".tr,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.trim().isEmpty) {
                            controller.fetchBusinessesList(
                              city:
                                  cityController.selectedCity.split('-').first,
                              searchTerm: null,
                              sortBy: selectedSortBy,
                            );
                          }
                        },
                        onSubmitted: (value) {
                          controller.fetchBusinessesList(
                            city: cityController.selectedCity.split('-').first,
                            searchTerm:
                                searchTermController.text.trim().isNotEmpty
                                    ? searchTermController.text.trim()
                                    : null,
                            sortBy: selectedSortBy,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.search),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// Filter and Sort
              Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightBlue),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: DropdownButtonHideUnderline(
                            child: SizedBox(
                              width: double.infinity,
                              child: DropdownButton<String>(
                                value:
                                    selectedDate.value.isEmpty
                                        ? null
                                        : selectedDate.value,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 18,
                                ),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    selectedDate.value = newValue;

                                    DateTime today = DateTime.now();
                                    String dayOfWeek;
                                    if (newValue == "Today") {
                                      dayOfWeek = getDayOfWeek(today);
                                    } else if (newValue == "Tomorrow") {
                                      DateTime tomorrow = today.add(
                                        Duration(days: 1),
                                      );
                                      dayOfWeek = getDayOfWeek(tomorrow);
                                    } else {
                                      dayOfWeek = newValue;
                                    }
                                    log("Selected day: $dayOfWeek");

                                    controller.fetchBusinessesList(
                                      day: dayOfWeek,
                                      searchTerm:
                                          searchTermController.text
                                                  .trim()
                                                  .isNotEmpty
                                              ? searchTermController.text.trim()
                                              : null,
                                      sortBy: selectedSortBy,
                                    );
                                  }
                                },
                                hint: commonText("Select day"),
                                items:
                                    generateDayOptions().map((day) {
                                      // Use the unique identifier for each dropdown value (day)
                                      return DropdownMenuItem<String>(
                                        value: day,
                                        child: commonText(day, size: 14),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(() {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightBlue),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value:
                                cityController.selectedCity.value.isEmpty
                                    ? null
                                    : cityController.selectedCity.value,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.primaryColor,
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                cityController.selectedCity.value = newValue;

                                controller.fetchBusinessesList(
                                  city: newValue.split('-').first,
                                  searchTerm:
                                      searchTermController.text
                                              .trim()
                                              .isNotEmpty
                                          ? searchTermController.text.trim()
                                          : null,
                                  sortBy: selectedSortBy,
                                );
                              }
                            },
                            hint:
                                cityController.isLoading.value
                                    ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : commonText(
                                      cityController.cities.isEmpty
                                          ? "No locations"
                                          : "Select location",
                                      size: 14,
                                    ),
                            items:
                                cityController.cities.map((city) {
                                  // use a unique identifier for each dropdown value
                                  final uniqueValue = city.cityName;
                                  return DropdownMenuItem<String>(
                                    value: uniqueValue,
                                    child: commonText(city.cityName, size: 14),
                                  );
                                }).toList(),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.businessList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        20.0,
                      ), // Adds padding around the content
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons
                                .business_center, // Icon that represents the "business" theme
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(
                            height: 20,
                          ), // Adds space between icon and text
                          commonText(
                            "No businesses found.".tr,
                            textAlign: TextAlign.center,
                            size: 18,
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: controller.businessList.length,
                  shrinkWrap: true,
                  itemBuilder:
                      (context, index) => InkWell(
                        onTap: () {
                          navigateToPage(
                            context: context,
                            UserBusinessDetailsPage(
                              businessId: controller.businessList[index].id,
                            ),
                          );
                        },
                        child: RestaurantCard(
                          imageUrl: getFullImagePath(
                            controller.businessList[index].image ?? "",
                          ),

                          title: controller.businessList[index].name,
                          rating:
                              controller.businessList[index].rating.toDouble(),
                          reviewCount:
                              controller.businessList[index].userRatingsTotal,
                          priceRange:
                              controller.businessList[index].priceRange != null
                                  ? "€${controller.businessList[index].priceRange!.min}-${controller.businessList[index].priceRange!.max}"
                                  : "N/A",
                          openTime: controller.businessList[index].openTimeText,
                          location: controller.businessList[index].addressText,
                          tags: controller.businessList[index].types,
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(height: 8),

                  physics: NeverScrollableScrollPhysics(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
