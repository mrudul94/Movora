import 'package:cloud_firestore/cloud_firestore.dart';

class ShiftBookingModel {
  final String shiftId;
  final String deliveryType;
  final String status;
  final DateTime createdAt;
  final Map<String, dynamic> pickupDetails;
  final Map<String, dynamic> productDetails;
  final Map<String, dynamic> deliveryDetails;

  ShiftBookingModel({
    required this.shiftId,
    required this.deliveryType,
    required this.status,
    required this.createdAt,
    required this.pickupDetails,
    required this.productDetails,
    required this.deliveryDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'shiftId': shiftId,
      'deliveryType': deliveryType,
      'pickupDetails': pickupDetails,
      'productDetails': productDetails,
      'deliveryDetails': deliveryDetails,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory ShiftBookingModel.fromMap(Map<String, dynamic> map) {
    return ShiftBookingModel(
      shiftId: map['shiftId'] ?? '',
      deliveryType: map['deliveryType'] ?? '',
      status: map['status'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      pickupDetails: Map<String, dynamic>.from(map['pickupDetails'] ?? {}),
      productDetails: Map<String, dynamic>.from(map['productDetails'] ?? {}),
      deliveryDetails: Map<String, dynamic>.from(map['deliveryDetails'] ?? {}),
    );
  }
}
