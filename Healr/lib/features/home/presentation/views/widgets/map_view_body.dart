import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healr/core/constants.dart';
import 'package:healr/core/utils/location_service.dart';
import 'package:healr/core/utils/styles.dart';
import 'package:healr/core/widgets/custom_button.dart';
import 'package:healr/features/home/data/models/places_model/places_model.dart';
import 'package:healr/features/home/presentation/managers/places_cubit/cubit/places_cubit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';

class MapViewBody extends StatefulWidget {
  const MapViewBody({
    super.key,
  });

  @override
  State<MapViewBody> createState() => _MapViewBodyState();
}

class _MapViewBodyState extends State<MapViewBody> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  LatLng _initialPosition = const LatLng(31.2685013, 32.2658171);
  List<PlacesModel> _hospitals = [];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final position = await LocationService.getCurrentLocation();

    if (position != null) {
      _initialPosition = LatLng(position.latitude, position.longitude);
      if (position.latitude != 0 && position.longitude != 0) {
        BlocProvider.of<PlacesCubit>(context).fetchHospitals(
          lat: position.latitude,
          lng: position.longitude,
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('غير قادر على تحديد موقعك')),
      );
    }
  }

  void _updateHospitalMarkers(List<PlacesModel> hospitals) {
    final newMarkers = <Marker>{};
    for (var hospital in hospitals) {
      final lat = hospital.position.latitude;
      final lng = hospital.position.longitude;
      newMarkers.add(
        Marker(
          markerId: MarkerId(hospital.title),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            HSVColor.fromColor(kSecondaryColor).hue,
          ),
          infoWindow: InfoWindow(
            title: hospital.title,
            snippet: hospital.label,
          ),
          onTap: () {
            showHospitalDetailsBottomSheet(hospital);
          },
        ),
      );
    }
    _markers.clear();
    _markers.addAll(newMarkers);
  }

  Future<void> _goToHospital(PlacesModel hospital) async {
    final target = hospital.position;
    await mapController.animateCamera(
      CameraUpdate.newLatLngZoom(target, 16),
    );
    mapController.showMarkerInfoWindow(MarkerId(hospital.title));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesCubit, PlacesState>(
      builder: (context, state) {
        if (state is PlacesLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: kSecondaryColor),
                  SizedBox(height: 12.h),
                  Text(
                    "جاري تحميل المستشفيات...",
                    style: Styles.textStyle16.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is PlacesLoaded) {
          _hospitals = state.hospitals;
          _updateHospitalMarkers(_hospitals);
          if (_markers.isNotEmpty) {
            _initialPosition = _markers.first.position;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('خريطة المستشفيات'),
              backgroundColor: Colors.transparent,
              elevation: 1,
              centerTitle: true,
              foregroundColor: Colors.black,
            ),
            body: Stack(
              children: [
                GoogleMap(
                  padding: EdgeInsets.only(top: 70.h),
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 18),
                  markers: _markers,
                  mapType: MapType.terrain,
                  tiltGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (c) => mapController = c,
                ),
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  right: 12.w,
                  child: _buildSearchBar(),
                ),
              ],
            ),
          );
        }

        if (state is PlacesError) {
          return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSearchBar() {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12.r),
      child: TypeAheadField<PlacesModel>(
        suggestionsCallback: (pattern) {
          return _hospitals.where((hospital) {
            return hospital.title
                    .toLowerCase()
                    .contains(pattern.toLowerCase()) ||
                hospital.label.toLowerCase().contains(pattern.toLowerCase());
          }).toList();
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.title),
            subtitle: Text(
              suggestion.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        onSelected: (suggestion) {
          _goToHospital(suggestion);
          FocusScope.of(context).unfocus();
        },
        builder: (context, controller, focusNode) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: 'ابحث عن مستشفى...',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: Colors.grey[600]),
                onPressed: () {
                  controller.clear();
                  focusNode.unfocus();
                },
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          );
        },
      ),
    );
  }

  void showHospitalDetailsBottomSheet(PlacesModel hospital) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Title + Category
            Text(
              hospital.title,
              style: Styles.textStyle22.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xff1A1A1A),
              ),
            ),
            SizedBox(height: 16.h),

            // Distance Box
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xffD5E9F6),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(HugeIcons.strokeRoundedWorkoutRun,
                      color: kSecondaryColor, size: 20.h),
                  SizedBox(width: 6.w),
                  Text(
                    "المسافة: ${formatDistance(hospital.distance)}",
                    style: Styles.textStyle16
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),
            hospital.phone == "Not Available"
                ? Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          padding: 4.w,
                          borderRadius: 20.r,
                          color: kSecondaryColor,
                          textStyle: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                          borderColor: const Color(0xff3A95D2),
                          isIcon: true,
                          icon: HugeIcons.strokeRoundedSquareArrowMoveRightUp,
                          text: 'الإتجاهات',
                          onPressed: () {
                            openNavigation(
                              hospital.position.latitude,
                              hospital.position.longitude,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          padding: 4.w,
                          iconColor: kSecondaryColor,
                          borderRadius: 20.r,
                          color: kPrimaryColor,
                          textStyle: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.w600,
                            color: kSecondaryColor,
                          ),
                          textColor: kSecondaryColor,
                          isIcon: true,
                          borderColor: const Color(0xff3A95D2),
                          icon: HugeIcons.strokeRoundedCall02,
                          text: 'الإتصال',
                          onPressed: () => callNumber(hospital.phone),
                        ),
                      ),
                    ],
                  )
                : CustomButton(
                    padding: 4.w,
                    borderRadius: 20.r,
                    color: kSecondaryColor,
                    textStyle: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                    borderColor: const Color(0xff3A95D2),
                    isIcon: true,
                    icon: HugeIcons.strokeRoundedSquareArrowMoveRightUp,
                    text: 'الإتجاهات',
                    onPressed: () {
                      openNavigation(
                        hospital.position.latitude,
                        hospital.position.longitude,
                      );
                    },
                  ),

            SizedBox(height: 16.h),

            Row(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  HugeIcons.strokeRoundedLocation01,
                  color: Color(0xff2673A6),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    hospital.label,
                    style: Styles.textStyle16.copyWith(
                      color: const Color(0xff666666),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void openNavigation(double lat, double lng) async {
    final Uri uri = Uri.parse('google.navigation:q=$lat,$lng&mode=d');

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  String formatDistance(int distanceInMeters) {
    if (distanceInMeters >= 1000) {
      final km = (distanceInMeters / 1000).toStringAsFixed(1);
      return '$km كم';
    } else {
      return '$distanceInMeters م';
    }
  }

  void callNumber(String phone) async {
    final Uri phoneUri = Uri.parse('tel:$phone');

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يمكن إجراء الاتصال')),
      );
    }
  }
}
