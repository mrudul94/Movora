import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ShiftBookingViewModel extends ChangeNotifier {
  /// --- PageView Controller ---
  final PageController pageController = PageController();
  int _currentStep = 0;
  int _totalSteps = 1;

  int get currentStep => _currentStep;
  int get totalSteps => _totalSteps;

  String? _selectedPickUpState;
  String? _selectedDeliveryState;

  String? get selectedPickUpState => _selectedPickUpState;
  String? get selectedDeliveryState => _selectedDeliveryState;

  /// --- Pickup Details Controllers ---
  final nameController = TextEditingController();
  final pincodeController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pickupAddressController = TextEditingController();
  final pickupLandmarkController = TextEditingController();
  final pickupDateController = TextEditingController();
  final pickupTimeController = TextEditingController();
  final pickupContactController = TextEditingController();
  final roadNameController = TextEditingController();

  /// --- Product Details Controllers ---
  final productNameController = TextEditingController();
  final productWeightController = TextEditingController();
  final productQuantityController = TextEditingController();
  final productDescriptionController = TextEditingController();

  /// --- Delivery Details Controllers ---
  final deliveryNameController = TextEditingController();
  final deliveryPincodeController = TextEditingController();
  final deliveryStateController = TextEditingController();
  final deliveryCityController = TextEditingController();
  final deliveryAddressController = TextEditingController();
  final deliveryLandmarkController = TextEditingController();
  final deliveryDateController = TextEditingController();
  final deliveryTimeController = TextEditingController();
  final deliveryContactController = TextEditingController();
  final deliveryroadNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// --- Step Navigation ---
  void setTotalSteps(int count) {
    _totalSteps = count;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _currentStep++;
      pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void prevStep() {
    if (_currentStep > 0) {
      _currentStep--;
      pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void onPageChanged(int index) {
    _currentStep = index;
    notifyListeners();
  }

  /// --- Booking Confirmation ---
  void confirmBooking() {
    debugPrint("✅ Booking confirmed successfully!");
    debugPrint("Pickup Address: ${pickupAddressController.text}");
    debugPrint("Delivery Name: ${deliveryNameController.text}");
    // TODO: Add API/Database save logic here
  }

  /// --- Dispose All Controllers ---
  @override
  void dispose() {
    pageController.dispose();
    pickupAddressController.dispose();
    pickupLandmarkController.dispose();
    pickupDateController.dispose();
    pickupTimeController.dispose();
    pickupContactController.dispose();
    nameController.dispose();
    pincodeController.dispose();
    stateController.dispose();
    cityController.dispose();
    roadNameController.dispose();

    productNameController.dispose();
    productWeightController.dispose();
    productQuantityController.dispose();
    productDescriptionController.dispose();

    deliveryNameController.dispose();
    deliveryAddressController.dispose();
    deliveryLandmarkController.dispose();
    deliveryDateController.dispose();
    deliveryTimeController.dispose();
    deliveryContactController.dispose();
    deliveryCityController.dispose();
    deliveryStateController.dispose();
    deliveryPincodeController.dispose();
    deliveryroadNameController.dispose();

    super.dispose();
  }

  final List<String> indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Delhi',
  ];

  void selectPickupState(String state) {
    _selectedPickUpState = state;
    stateController.text = state;
    notifyListeners();
  }

  void selectDeliveryState(String state) {
    _selectedDeliveryState = state;
    deliveryStateController.text = state;
    notifyListeners();
  }

  Future<void> useCurrentLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    // Step 1: Check if location service is enabled

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    // Step 2: Check permission

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        debugPrint('Location permission denied');
        return;
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      debugPrint('Location permissions are permanently denied.');
      return;
    }
    // Step 3: Get current position

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // Step 4: Get address info from coordinates
    List<Placemark> placeMark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placeMark.isNotEmpty) {
      Placemark place = placeMark.first;

      pincodeController.text = place.postalCode ?? '';
      stateController.text = place.administrativeArea ?? '';

      if (place.postalCode != null && place.postalCode!.isNotEmpty) {
        final district = await _getDistrict(place.postalCode);

        if (district != null) {
          cityController.text = district;
        }
      }
      final roadName = await getRoadName(position.latitude, position.longitude);
      if (roadName != null) {
        roadNameController.text = roadName;
      }

      notifyListeners();
      debugPrint('📍 Location fetched successfully!');
      debugPrint(cityController.text);
      debugPrint(pincodeController.text);
      debugPrint(stateController.text);
      debugPrint(roadNameController.text);
    }
  }

  Future<String?> _getDistrict(String? postalCode) async {
    if (postalCode == null || postalCode.isEmpty) return null;

    try {
      final url = Uri.parse('https://api.postalpincode.in/pincode/$postalCode');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List && data.isNotEmpty && data[0]['Status'] == 'Success') {
          final postOffice = data[0]['PostOffice'];
          if (postOffice != null && postOffice.isNotEmpty) {
            return postOffice[0]['District']; // ✅ Correct key
          }
        } else {
          debugPrint('⚠️ Invalid or unknown pincode: $postalCode');
        }
      }
    } catch (e) {
      debugPrint('❌ Failed to fetch district from API: $e');
    }
    return null;
  }

  Future<String?> getRoadName(double lat, double lon) async {
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&addressdetails=1',
      );

      final response = await http.get(
        url,
        headers: {'User-Agent': 'FlutterApp'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final address = data['address'] ?? {};

        return address['road'] ??
            address['neighbourhood'] ??
            address['suburb'] ??
            address['village'] ??
            address['county'] ??
            address['state_district'];
      } else {
        debugPrint('❌ Failed to fetch road name: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Error fetching road name: $e');
    }
    return null;
  }
}
