import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:motorvelox/responsive/responsive_config.dart';
import 'package:provider/provider.dart';
import 'package:motorvelox/mobile/fuel/fuelcontrol/fuel_control.dart';
import 'package:motorvelox/mobile/fuel/fuelmodals/fuel_modal.dart';
import 'package:motorvelox/mobile/widgets/button.dart';
import 'package:motorvelox/mobile/widgets/toast.dart';
import 'package:motorvelox/service/constant.dart';
import 'package:motorvelox/state/fuel_manager.dart';

import '../../service/controller.dart';
import '../screens/servicemodel/service_model.dart';

class FuelCard extends StatefulWidget {
  final ServiceModel data;
  const FuelCard({super.key, required this.data});

  @override
  State<FuelCard> createState() => _FuelCardState();
}

class _FuelCardState extends State<FuelCard> {
  TextEditingController controller = TextEditingController();
  String key = '';
  @override
  void initState() {
    super.initState();
    getKey();
  }

  Future<void> getKey() async {
    await FirebaseFirestore.instance
        .collection("controls")
        .doc('oneGod1997')
        .get()
        .then((value) {
      String _key = value.data()!["key"];
      setState(() {
        key = _key;
      });
    });

    await PaystackClient.initialize(key);
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.white,
      textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        // width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Colors.black,
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.3),
            ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Text(
                  //   "Click to buy Fuel ",
                  //   style: TextStyle(
                  //       fontFamily: 'Raleway',
                  //       color: Colors.white,
                  //       fontSize: 25.0,
                  //       fontWeight: FontWeight.w700),
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          widget.data.name!,
                          style: const TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        //   width: 200,
                        constraints:
                             BoxConstraints(maxWidth:  Responsive.isMobile(context) ? 200 : 150, minWidth: 100),
                        child: Text(
                          widget.data.desc!,
                          style: const TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.grey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),

                  ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxWidth: 140, minWidth: 80, maxHeight: 27),
                    child: ElevatedButton(
                      style: style,
                      child: const Text(
                        "Request",
                        style: TextStyle(color: Color(0xff5956E9)),
                      ),
                      onPressed: () async {
                        bool value =
                            await Controls.checkEnable(context, 'oneGod1997');
                        //   bool gotten = await FuelControl.getFuelValues(context);

                        if (value == false) {
                          showToast('We are closed kindly come back tomorrow',
                              errorRed);
                          return;
                        }

                        if (value) {
                          // ignore: use_build_context_synchronously
                          FuelModal.fuelModal(context, controller, widget.data);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                  maxWidth: 80, minWidth: 20, maxHeight: 80, minHeight: 20),
              child: Image(
                  image: CachedNetworkImageProvider(widget.data.image!),
                  fit: BoxFit.contain),
            )
          ],
        ),
      ),
    );
  }
}
