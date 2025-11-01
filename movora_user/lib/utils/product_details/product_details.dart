import 'package:flutter/material.dart';
import 'package:movora/utils/product_details_field.dart';
import 'package:movora/viewmodels/image_picker_view_model.dart';
import 'package:movora/viewmodels/shift_booking_view_model.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.bookingVM,
    required this.imageVM,
  });

  final ShiftBookingViewModel bookingVM;
  final ImagePickerViewModel imageVM;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: bookingVM.formKey,
        child: Column(
          children: [
            Text('Product details'),
            SizedBox(
              width: double.infinity,
              child: ProductDetailsField(
                hintText: 'Product Name (Required)*',
                controller: bookingVM.productNameController,
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ProductDetailsField(
                hintText: 'Product Weight (optional)',
                controller: bookingVM.productWeightController,
                keyboardType: TextInputType.number,
                isRequired: false,
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ProductDetailsField(
                hintText: 'Product Quantity (Required)*',
                controller: bookingVM.productQuantityController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ProductDetailsField(
                hintText: 'Product Description (Required)*',
                controller: bookingVM.productDescriptionController,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 20),

            const Text('Add Image'),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => imageVM.pickImage(context),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: imageVM.selectedImage == null
                    ? const Icon(Icons.person, size: 50, color: Colors.grey)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          imageVM.selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
