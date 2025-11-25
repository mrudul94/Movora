import 'package:flutter/material.dart';
import 'package:movora/utils/app_pattete.dart';
import 'package:movora/utils/custom_app_bar.dart';
import 'package:movora/utils/slider_menu.dart';
import 'package:movora/viewmodels/firebase_auth_view_model.dart';
import 'package:movora/viewmodels/search_view_model.dart';
import 'package:movora/viewmodels/shift_booking_view_model.dart';
import 'package:movora/views/shift_booked.dart';
import 'package:movora/views/shift_updates.dart';
import 'package:provider/provider.dart';

class MyShift extends StatefulWidget {
  const MyShift({super.key});

  @override
  State<MyShift> createState() => _MyShiftState();
}

class _MyShiftState extends State<MyShift> {
  @override
  void initState() {
    super.initState();

    final authVm = Provider.of<FirebaseAuthViewModel>(context, listen: false);
    final shiftVM = Provider.of<ShiftBookingViewModel>(context, listen: false);

    authVm.initUser().then((_) {
      if (authVm.user != null) {
        shiftVM.fetchShiftBookingdetails(authVm.user!.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final shiftVM = Provider.of<ShiftBookingViewModel>(context);
    return Scaffold(
      drawer: const Drawer(child: SliderMenu()),
      appBar: CustomAppBar(searchVM: context.watch<SearchViewModel>()),
      body: shiftVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : shiftVM.shiftBookingList.isEmpty
          ? const Center(child: Text("No Shifts Booked"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: shiftVM.shiftBookingList.length,
              itemBuilder: (context, index) {
                final booking = shiftVM.shiftBookingList[index];
                final img = booking['productDetails']['imageUrl'];
                final productName = booking['productDetails']['productname'];
                final shiftId = booking['shiftId'];
                final status = booking['status'];

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    createAnimatedRoute(ShiftUpdates(bookingData: booking)),
                  ),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: img != null
                            ? Image.network(
                                img,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 55,
                                height: 55,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: AppPallete.greyColor,
                                ),
                              ),
                      ),
                      title: Text(
                        'Product Name : $productName',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shift ID : $shiftId',
                            style: TextStyle(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('Status : $status'),
                        ],
                      ),
                      contentPadding: EdgeInsets.all(10),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
