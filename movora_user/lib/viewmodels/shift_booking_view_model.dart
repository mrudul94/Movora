import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import 'package:movora/models/shift_booking_model.dart';
import 'package:movora/services/firestore_service.dart';
import 'package:movora/viewmodels/image_picker_view_model.dart';

class ShiftBookingViewModel extends ChangeNotifier {
  final FirestoreService firestoreService;
  final ImagePickerViewModel imageVM;

  ShiftBookingViewModel({
    required this.firestoreService,
    required this.imageVM,
  });

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

  String? _selectedDeliveryType;

  String? get selectedDeliveryType => _selectedDeliveryType;

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
  final deliveryAlternativeContactController = TextEditingController();
  final deliveryroadNameController = TextEditingController();
  final deliveryTypeController = TextEditingController();
  final pickupFormKey = GlobalKey<FormState>();
  final deliveryFormKey = GlobalKey<FormState>();
  final productdetailsFormKey = GlobalKey<FormState>();

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

  Widget appbarTitle(int index) {
    if (index == 0) {
      return Text(
        'Pickup Address',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    } else if (index == 1) {
      return Text(
        'Product details',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    } else {
      return Text(
        'Delivery Address',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }
  }

  /// --- Booking Confirmation ---

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
    deliveryAlternativeContactController.dispose();
    deliveryCityController.dispose();
    deliveryStateController.dispose();
    deliveryPincodeController.dispose();
    deliveryroadNameController.dispose();
    deliveryTypeController.dispose();
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
  final List<String> deliveryType = ['Easy Shift', 'Bulk Shift'];
  void selectdeliveryType(String dvType) {
    _selectedDeliveryType = dvType;
    deliveryTypeController.text = dvType;
    notifyListeners();
  }

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

      TextEditingController pinCtrl = TextEditingController();
      TextEditingController cityCtrl = TextEditingController();
      TextEditingController stateCtrl = TextEditingController();
      TextEditingController roadCtrl = TextEditingController();

      pinCtrl.text = place.postalCode ?? '';
      stateCtrl.text = place.administrativeArea ?? '';

      if (place.postalCode != null && place.postalCode!.isNotEmpty) {
        final district = await _getDistrict(place.postalCode);

        if (district != null) {
          cityCtrl.text = district;
        }
      }
      final roadName = await getRoadName(position.latitude, position.longitude);
      if (roadName != null) {
        roadCtrl.text = roadName;
      }
      if (currentStep == 0) {
        // Pickup
        pincodeController.text = pinCtrl.text;
        cityController.text = cityCtrl.text;
        stateController.text = stateCtrl.text;
        roadNameController.text = roadCtrl.text;
      } else {
        // Delivery
        deliveryPincodeController.text = pinCtrl.text;
        deliveryCityController.text = cityCtrl.text;
        deliveryStateController.text = stateCtrl.text;
        deliveryroadNameController.text = roadCtrl.text;
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

  String _generateShiftId() {
    final random = math.Random.secure();
    final randomCode = List.generate(
      6,
      (_) => String.fromCharCode(random.nextInt(26) + 65), // A–Z
    ).join();

    return 'SFT-$randomCode';
  }

  bool isLoading = false;

  Future<String?> uploadToCloudinary(File imageFile) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dp8vrxufl/image/upload',
      );

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'movora_preset'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final data = json.decode(responseData.body);
        print('✅ Uploaded to Cloudinary: ${data['secure_url']}');
        return data['secure_url'];
      } else {
        print('❌ Failed to upload: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ Cloudinary upload error: $e');
      return null;
    }
  }

  Future<void> conformShiftBooking(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      final shiftId = _generateShiftId();
      String? imageUrl;
      if (imageVM.selectedImage != null) {
        final file = File(imageVM.selectedImage!.path);
        imageUrl = await uploadToCloudinary(file);
      }

      final shiftBooking = ShiftBookingModel(
        shiftId: shiftId,
        deliveryType: deliveryTypeController.text,
        status: 'pending',
        createdAt: DateTime.now(),
        pickupDetails: {
          'name': nameController.text,
          'phone': pickupContactController.text,
          'pinCode': pincodeController.text,
          'state': stateController.text,
          'city': cityController.text,
          'house': pickupAddressController.text,
          'roadname': roadNameController.text,
          'landMark': pickupLandmarkController.text,
        },
        productDetails: {
          'productname': productNameController.text,
          'productweight': productWeightController.text,
          'productquntity': productQuantityController.text,
          'productDescriptionController': productDescriptionController.text,
          'imageUrl': imageUrl,
        },
        deliveryDetails: {
          'deliveryname': deliveryNameController.text,
          'phone': deliveryContactController.text,
          'alterphone': deliveryAlternativeContactController.text,
          'deliveryType': deliveryTypeController.text,
          'pinCode': deliveryPincodeController.text,
          'state': deliveryStateController.text,
          'city': deliveryCityController.text,
          'house': deliveryAddressController.text,
          'roadname': deliveryroadNameController.text,
          'landMark': deliveryLandmarkController.text,
        },
      );
      await firestoreService.addShiftBooking(userId, shiftBooking);
      debugPrint('✅ Booking stored successfully: $shiftId');
    } catch (e) {
      debugPrint("❌ Error saving booking: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> shiftBookingList = [];

  Future<void> fetchShiftBookingdetails(String userId) async {
    isLoading = true;
    notifyListeners();
    try {
      final bookings = await firestoreService.fetchShiftbookings(userId);

      // ✅ Convert ShiftBookingModel objects to Map for UI usage
      shiftBookingList = bookings.map((b) => b.toMap()).toList();
      debugPrint('✅ Booking fetch successfully: $userId');
    } catch (e) {
      debugPrint("❌ Error fetch booking: $e");
    }
    isLoading = false;
    notifyListeners();
    debugPrint('✅ : $shiftBookingList');
  }
}
