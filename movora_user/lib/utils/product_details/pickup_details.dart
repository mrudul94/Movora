import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/utils/product_details_field.dart';
import 'package:movora/viewmodels/shift_booking_view_model.dart';
import 'package:provider/provider.dart';

class PickupDetails extends StatelessWidget {
  const PickupDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingVM = Provider.of<ShiftBookingViewModel>(context);
    return SingleChildScrollView(
      child: Form(
        key: bookingVM.formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            ProductDetailsField(
              hintText: 'Full Name (Required)*',
              controller: bookingVM.nameController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ProductDetailsField(
              hintText: 'Phone Number (Required)*',
              controller: bookingVM.pickupContactController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ProductDetailsField(
                    hintText: "Pin Code (Required)*",
                    controller: bookingVM.pincodeController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10),
                TextButton.icon(
                  onPressed: () async {
                    final vm = context.read<ShiftBookingViewModel>();

                    await vm.useCurrentLocation();
                  },
                  label: Text(
                    'Use my location',
                    style: TextStyle(color: AppPallete.focusBorder),
                  ),
                  icon: Icon(Icons.my_location, color: AppPallete.focusBorder),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ProductDetailsField(
                    hintText: 'State (Required)*',
                    controller: bookingVM.stateController,
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
                                        groupValue: vm.selectedPickUpState,
                                        onChanged: (value) {
                                          vm.selectPickupState(value!);
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
                    controller: bookingVM.cityController,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            ProductDetailsField(
              hintText: 'House No., Building Name (Required)*',
              controller: bookingVM.pickupAddressController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ProductDetailsField(
              hintText: 'Road name, Area, Colony (Required)*',
              controller: bookingVM.roadNameController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ProductDetailsField(
              hintText: 'Landmark',
              controller: bookingVM.pickupLandmarkController,
              isRequired: false,
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}
