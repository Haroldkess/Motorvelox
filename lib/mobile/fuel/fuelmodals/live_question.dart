import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorvelox/designParams/params.dart';
import 'package:provider/provider.dart';
import 'package:motorvelox/mobile/widgets/toast.dart';
import 'package:motorvelox/service/constant.dart';
import 'package:motorvelox/state/fuel_manager.dart';
import 'package:motorvelox/state/ui_manager.dart';

class FuelLiveIn extends StatefulWidget {
  FuelLiveIn({Key? key}) : super(key: key);

  @override
  State<FuelLiveIn> createState() => _FuelLiveInState();
}

class _FuelLiveInState extends State<FuelLiveIn> {
  final paymentMethodSelected = 'visa1';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Live in FESTAC TOWN Lagos ?,',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: Colors.white),
            ),
            SizedBox(height: 15),
            Card(
              color: darkCard,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Column(children: [
                  LiveInWidget(
                    cardNumber: 'Yes',
                    radioValue: 'Yes',
                    paymenMethodSelected: paymentMethodSelected,
                    //  imagePath: 'assets/images/visa.png',
                  ),
                  LiveInWidget(
                    cardNumber: 'No',
                    radioValue: 'No',
                    paymenMethodSelected: paymentMethodSelected,
                    //   imagePath: 'assets/images/master.png',
                  ),
                  //   PaymentMethod(
                  //     cardNumber: '**** **** **** 8274',
                  //     radioValue: 'bank1',
                  //     paymenMethodSelected: paymentMethodSelected,
                  // //    imagePath: 'assets/images/credit_card.png',
                  //   ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LiveInWidget extends StatelessWidget {
  final String cardNumber;
  final String radioValue;
  final String imagePath;
  final String paymenMethodSelected;
  final Function(String)? onCountChanged;
  LiveInWidget({
    Key? key,
    this.cardNumber = '',
    this.radioValue = '',
    this.imagePath = '',
    this.paymenMethodSelected = '',
    @required this.onCountChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Radio(
           // fillColor: Colors.blue,
            value: radioValue,
            groupValue: context.watch<FuelManager>().liveIn,
            onChanged: (value) async {
              Provider.of<FuelManager>(context, listen: false)
                  .addLiveIn(value!);
              if (value == "No") {
                
                showToast("Sorry this feature is not available in your region",
                    errorRed);
                    Navigator.pop(context);
              }
            },
            activeColor: Theme.of(context).primaryColor,
            fillColor: MaterialStateProperty.all(Colors.white),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: Image(
          //     image: AssetImage(imagePath),
          //     width: 62,
          //     height: 40,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          const SizedBox(width: 15),
          Text(cardNumber, style: TextStyle(fontSize: 17,color: Colors.white)),
        ],
      ),
    );
  }
}
