import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movora/models/shift_booking_model.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/utils/bottom_next_previous_button.dart';
import 'package:movora/utils/product_details/delivery_details.dart';
import 'package:movora/utils/product_details/pickup_details.dart';
import 'package:movora/utils/product_details/product_details.dart';
import 'package:movora/viewmodels/image_picker_view_model.dart';
import 'package:movora/viewmodels/shift_booking_view_model.dart';
import 'package:movora/views/shift_booked.dart';
import 'package:provider/provider.dart';

class ShiftHub extends StatefulWidget {
  ShiftHub({super.key});

  @override
  State<ShiftHub> createState() => _ShiftHubState();
}

class _ShiftHubState extends State<ShiftHub> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShiftBookingViewModel>(
        context,
        listen: false,
      ).setTotalSteps(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingVM = Provider.of<ShiftBookingViewModel>(context);
    final imageVM = Provider.of<ImagePickerViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.transparent,
        elevation: 0,
        title: bookingVM.appbarTitle(bookingVM.currentStep),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                constraints: BoxConstraints(maxHeight: 600),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: bookingVM.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          PickupDetails(),
                          ProductDetails(
                            bookingVM: bookingVM,
                            imageVM: imageVM,
                          ),
                          DeliveryDetails(bookingVM: bookingVM),
                        ],
                      ),
                    ),
                    BookingNavigationButtons(
                      showPrevious: bookingVM.currentStep > 0,
                      isLastStep:
                          bookingVM.currentStep == bookingVM.totalSteps - 1,
                      onPrevious: bookingVM.prevStep,
                      onNextOrConfirm: () {
                        // ✅ Validate the form before proceeding
                        bool isValid = false;

                        // ✅ Validate only the current step’s form
                        if (bookingVM.currentStep == 0) {
                          isValid =
                              bookingVM.pickupFormKey.currentState
                                  ?.validate() ??
                              false;
                        } else if (bookingVM.currentStep == 1) {
                          isValid =
                              bookingVM.productdetailsFormKey.currentState
                                  ?.validate() ??
                              false;
                        } else if (bookingVM.currentStep == 2) {
                          isValid =
                              bookingVM.deliveryFormKey.currentState
                                  ?.validate() ??
                              false;
                        }
                        if (isValid) {
                          if (bookingVM.currentStep ==
                              bookingVM.totalSteps - 1) {
                            debugPrint('🟢 Confirm button pressed');
                            bookingVM.conformShiftBooking(
                              FirebaseAuth.instance.currentUser!.uid,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShiftBookedPage(),
                              ),
                            );
                          } else {
                            // ✅ Not last step → go to next page
                            bookingVM.nextStep();
                          }
                        } else {
                          debugPrint("⚠️ Please fill all required fields");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
