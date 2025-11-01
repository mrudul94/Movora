import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/utils/product_details_field.dart';
import 'package:movora/viewmodels/shift_booking_view_model.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatelessWidget {
  const DeliveryDetails({super.key, required this.bookingVM});

  final ShiftBookingViewModel bookingVM;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: bookingVM.formKey,
        child: Column(
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ProductDetailsField(
              hintText: 'Full Name (Required)*',
              controller: bookingVM.deliveryNameController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            ProductDetailsField(
              hintText: 'Phone Number (Required)*',
              controller: bookingVM.deliveryContactController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ProductDetailsField(
                    hintText: "Pin Code (Required)*",
                    controller: bookingVM.deliveryPincodeController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {},
                  label: Text(
                    'Use my location',
                    style: TextStyle(color: AppPallete.focusBorder),
                  ),
                  icon: Icon(Icons.my_location),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ProductDetailsField(
                    hintText: 'State (Required)*',
                    controller: bookingVM.deliveryStateController,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text('Select State'),
                            content: Consumer<ShiftBookingViewModel>(
                              builder: (context, vm, _) {
                                return SizedBox(
                                  width: double.maxFinite,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: vm.indianStates.map((state) {
                                      return RadioListTile<String>(
                                        title: Text(state),
                                        value: state,
                                        groupValue: vm.selectedDeliveryState,
                                        onChanged: (value) {
                                          vm.selectDeliveryState(value!);
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ProductDetailsField(
                    hintText: 'City (Required)*',
                    controller: bookingVM.deliveryCityController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),

            ProductDetailsField(
              hintText: 'House No., Building Name (Required)*',
              controller: bookingVM.deliveryAddressController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ProductDetailsField(
              hintText: 'Road name, Area, Colony (Required)*',
              controller: bookingVM.deliveryroadNameController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ProductDetailsField(
              hintText: 'Landmark',
              controller: bookingVM.deliveryLandmarkController,
              isRequired: false,
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}
