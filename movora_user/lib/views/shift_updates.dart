// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movora/utils/app_pattete.dart';

class ShiftUpdates extends StatelessWidget {
  Map<String, dynamic> bookingData;
  ShiftUpdates({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    // ======================
    // 🔥 MAIN FIELDS
    // ======================
    final shiftId = bookingData['shiftId'];
    final status = bookingData['status'];
    final createdAt = bookingData['createdAt'];

    // ======================
    // 🔥 PICKUP DETAILS
    // ======================
    final pickup = bookingData['pickupDetails'];
    final pickupName = pickup['name'];
    final pickupPhone = pickup['phone'];
    final pickupPin = pickup['pinCode'];
    final pickupState = pickup['state'];
    final pickupCity = pickup['city'];
    final pickupHouse = pickup['house'];
    final pickupRoad = pickup['roadname'];
    final pickupLandmark = pickup['landMark'];

    // ======================
    // 🔥 PRODUCT DETAILS
    // ======================
    final product = bookingData['productDetails'];
    final productName = product['productname'];
    final productWeight = product['productweight'];
    final productQty = product['productquntity'];
    final productDescription = product['productDescriptionController'];
    final productImage = product['imageUrl'];

    // ======================
    // 🔥 DELIVERY DETAILS
    // ======================
    final delivery = bookingData['deliveryDetails'];
    final deliveryName = delivery['deliveryname'];
    final deliveryPhone = delivery['phone'];
    final deliveryAltPhone = delivery['alterphone'];
    final deliveryType = delivery['deliveryType'];
    final deliveryPin = delivery['pinCode'];
    final deliveryState = delivery['state'];
    final deliveryCity = delivery['city'];
    final deliveryHouse = delivery['house'];
    final deliveryRoad = delivery['roadname'];
    final deliveryLandmark = delivery['landMark'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.transparent,
        title: Text(
          'Shift Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              'Shift ID : $shiftId',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppPallete.greyColor,
              ),
            ),
            Text(
              DateFormat('MMM d,yyyy').format(createdAt),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppPallete.greyColor,
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Column(
                  spacing: 10,
                  children: [
                    Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.amber,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(productImage, fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(height: 20, width: 20, child: Text(productQty)),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    Text(productName),
                    Text(productDescription),
                    Text(pickupHouse),
                    Text(pickupRoad),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
