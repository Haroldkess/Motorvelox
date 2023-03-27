import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorvelox/designParams/params.dart';
import 'package:motorvelox/mobile/screens/servicemodel/service_model.dart';
import 'package:provider/provider.dart';
import 'package:motorvelox/mobile/fuel/fuelcontrol/fuel_control.dart';
import 'package:motorvelox/mobile/fuel/fuelmodals/fuel_param.dart';
import 'package:motorvelox/mobile/fuel/fuelmodals/live_question.dart';
import 'package:motorvelox/mobile/screens/cart.dart';
import 'package:motorvelox/state/fuel_manager.dart';

import '../../../service/constant.dart';
import '../../../service/controller.dart';
import '../../../state/ui_manager.dart';
import '../../widgets/address_form.dart';
import '../../widgets/button.dart';
import '../../widgets/phone_form.dart';
import '../../widgets/shiping_information.dart';
import '../../widgets/toast.dart';

class FuelModal {
  static Future<void> fuelModal(BuildContext context,
      TextEditingController controller, ServiceModel data) async {
    FuelManager _provider = Provider.of<FuelManager>(context, listen: false);
    UiProvider _Uiprovider = Provider.of<UiProvider>(context, listen: false);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.09),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 7,
                ),
                const FuelAlertError(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Contact information?',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.09),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const ShippingAddress(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const ShippingPhone(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    context.watch<UiProvider>().loading
                                        ? CupertinoActivityIndicator(
                                            radius: 30,
                                            color: Colors.blue.shade900,
                                          )
                                        : Button(
                                            text: 'Add',
                                            width: 200,
                                            height: 50,
                                            onClick: () async {
                                              await _Uiprovider
                                                  .initializePref();
                                              // ignore: use_build_context_synchronously
                                              await Controls
                                                  .shippingInfoController(
                                                      context);

                                              _Uiprovider.addAdress(_Uiprovider
                                                  .pref!
                                                  .getString(addressKey)!);
                                              _Uiprovider.addPhone(_Uiprovider
                                                  .pref!
                                                  .getString(phoneKey)!);
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                            },
                                            color: Colors.blue.shade900,
                                          ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('change'),
                    )
                  ],
                ),
                ShippingInfo(),
                const SizedBox(
                  height: 10,
                ),
                // const FuelParam(),
                // const SizedBox(
                //   height: 10,
                // ),
                FuelExtra(controller: controller),
                const SizedBox(
                  height: 10,
                ),
                FuelLiveIn(),
                const SizedBox(
                  height: 10,
                ),
                context.watch<FuelManager>().loadStatus
                    ? CupertinoActivityIndicator(
                        radius: 30,
                        color: Colors.blue.shade900,
                      )
                    : Button(
                        text: 'Proceed',
                        width: 200,
                        height: 50,
                        onClick: () async {
                          if (_provider.liveIn.isEmpty) {
                            showToast("Please complete form", errorRed);
                            return;
                          }
                          if (_provider.liveIn == "No") {
                            showToast(
                                "Sorry this feature is not available in your region",
                                errorRed);
                            return;
                          } else {
                            if (_Uiprovider.address.isEmpty ||
                                _Uiprovider.phoneNumber.isEmpty) {
                              showToast(
                                  "Your phone number or location cannot be empty",
                                  errorRed);
                            } else{
                                await FuelControl.makePayment(
                                context, controller.text, data);

                            }
                          
                          }
                          // ignore: use_build_context_synchronously
                          // await Controls.sendFeedBackController(
                          //     context, controller.text);

                          //Navigator.pop(context);
                        },
                        color: Colors.white,
                      ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
