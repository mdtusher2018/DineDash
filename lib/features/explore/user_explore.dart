import 'package:dine_dash/core/services/localstorage/session_memory.dart';
import 'package:dine_dash/core/utils/colors.dart';
import 'package:dine_dash/core/utils/helper.dart';
import 'package:dine_dash/core/controller/city_controller.dart';
import 'package:dine_dash/features/explore/user_explore_controller.dart';
import 'package:dine_dash/res/commonWidgets.dart';
import 'package:dine_dash/res/user_resturant_card.dart';
import 'package:dine_dash/features/business/user/bussiness%20details/user_business_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  String? selectedExpense;
  String selectedSortBy = 'Low';

  @override
  void initState() {
    super.initState();

    controller.fetchBusinessesOnMap();
    controller.fetchBusinessesList();
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(40, 40)),
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
                decoration: BoxDecoration(
                  color: Color(0xFFDCE7FA),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search restaurants, foods...".tr,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.search),
                  ],
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
                        final (latitude, longitude) =
                            sessionMemory.userLocation;
                        LatLng businessLocation;

                        if (latitude != null && longitude != null) {
                          businessLocation = LatLng(latitude, longitude);
                        } else {
                          final position = await getCurrentPosition(
                            controller: controller,
                          );
                          businessLocation = LatLng(
                            position.latitude,
                            position.longitude,
                          );
                        }

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
            Image.asset(
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
    final LatLng initialPosition = LatLng(
      20.794542,
      80.389016,
    ); // Dhaka coordinates

    return Obx(() {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 10,
        ),
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,

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
        icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
      );
    }).toSet();
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
              Obx(() {
                return Align(
                  alignment: Alignment.centerLeft,
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
                                searchTermController.text.trim().isNotEmpty
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
                              : Text(
                                cityController.cities.isEmpty
                                    ? "No locations"
                                    : "Select location",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                      items:
                          cityController.cities.map((city) {
                            // use a unique identifier for each dropdown value
                            final uniqueValue =
                                "${city.cityName}-${city.postalCode}";
                            return DropdownMenuItem<String>(
                              value: uniqueValue,
                              child: Text(
                                "${city.cityName} (${city.postalCode})",
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                );
              }),

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
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightBlue),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          value: selectedExpense,
                          hint: commonText("What do you want to do".tr),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18,
                          ),
                          items:
                              ['Restaurants', 'Activities'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,

                                  child: commonText(value),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedExpense = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightBlue),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          value: selectedSortBy,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18,
                          ),
                          items:
                              ['Low', 'Hign'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: commonText("Price: $value"),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSortBy = newValue!;
                              controller.fetchBusinessesList(
                                city:
                                    cityController.selectedCity
                                        .split('-')
                                        .first,
                                searchTerm:
                                    searchTermController.text.trim().isNotEmpty
                                        ? searchTermController.text.trim()
                                        : null,
                                sortBy: newValue,
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  itemCount: controller.businessList.length,
                  shrinkWrap: true,
                  itemBuilder:
                      (context, index) => InkWell(
                        onTap: () {
                          navigateToPage(
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
