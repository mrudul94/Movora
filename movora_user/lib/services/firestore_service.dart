import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movora/models/shift_booking_model.dart';
import 'package:movora/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addShiftBooking(
    String userId,
    ShiftBookingModel shiftBookingModel,
  ) async {
    await _firestore
        .collection('user')
        .doc(userId)
        .collection('shiftBooking')
        .doc(shiftBookingModel.shiftId)
        .set(shiftBookingModel.toMap());
  }

  Future<List<ShiftBookingModel>> fetchShiftbookings(String userId) async {
    final querySnapshot = await _firestore
        .collection('user')
        .doc(userId)
        .collection('shiftBooking')
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => ShiftBookingModel.fromMap(doc.data()))
        .toList();
  }

  Future<void> saveUser(UserModel user) async {
    try {
      await _firestore
          .collection('userDetails')
          .doc(user.uid)
          .set(user.toMap());
      debugPrint('✅ User saved successfully');
    } catch (e) {
      debugPrint('❌ Error saving user: $e');
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection('userDetails').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Error fetching user: $e');
    }
    return null;
  }
}
