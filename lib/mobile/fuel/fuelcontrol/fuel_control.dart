import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart'
    hide context;
import 'package:motorvelox/mobile/screens/servicemodel/service_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motorvelox/mobile/widgets/toast.dart';
import 'package:motorvelox/service/constant.dart';
import 'package:motorvelox/state/fuel_manager.dart';

class FuelControl {


  static Future<bool> sendService(BuildContext context, String comment, ServiceModel data,) async {
    late bool isFinished;
   // FuelManager fuel = Provider.of<FuelManager>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
    showToast("Processing service...", successBlue);
    

    //fuel.isLoading(true);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction
            .set(FirebaseFirestore.instance.collection("adminOrders").doc(pref.getString(userIdKey)).collection("order").doc(data.id), {
          "id": pref.getString(userIdKey),
          "price": data.price,
          "location": "",
          "phone": pref.getString(phoneKey),
          "email": pref.getString(emailKey),
          "address": pref.getString(addressKey),
          "timestamp": Timestamp.now(),
          "name": pref.getString(nameKey),
          "comment": comment,
          "recieved": false,
          "image": data.image
        });
        transaction.set(
            userDir
                .doc(pref.getString(userIdKey))
                .collection("OrderHistory")
                .doc(data.id),
            {
             
              "id": pref.getString(userIdKey),
          "price": data.price,
          "location": "",
          "phone": pref.getString(phoneKey),
          "email": pref.getString(emailKey),
          "address": pref.getString(addressKey),
          "timestamp": Timestamp.now(),
          "name": pref.getString(nameKey),
          "comment": comment,
          "recieved": false,
           "image": data.image
            });
    
      }).whenComplete(() async {
       isFinished = true;
        // isFinished = true;
      });
    } catch (e) {
      isFinished = false;
    }
    return isFinished;
  }

  static Future<void> makePayment(
      BuildContext context, String comment,ServiceModel data ) async {
    FuelManager provider = Provider.of<FuelManager>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();
   double finalPrice = provider.selectedLires * provider.sellingPrice;

    provider.isLoading(true);
    int added = 100;
    int resolvedPrice = int.tryParse(data.price!)! * added;

    try {
      final charge = Charge()
        ..email = pref.getString(emailKey)
        ..amount = resolvedPrice
        // ..card!.cardTypes = CardT
        // ..card!.cvc = "123" 
        // ..card!.expiryMonth = 12
        // ..card!.expiryYear = 2025
        // ..card!.name = "kelechi"
        ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}';
        
      // ignore: use_build_context_synchronously
      final res = await PaystackClient.checkout(context, charge: charge);

      if (res.status) {
        // ignore: use_build_context_synchronously
        bool sendOrder = await sendService(context, comment, data);
        if (sendOrder) {
          provider.isLoading(false);
          // ignore: use_build_context_synchronously
        //  Navigator.pop(context);
          showToast(
              'Charge was successful. Ref: ${res.reference}', successBlue);
          showToast('Order Completed succseffully ', successBlue);
        } else {
          showToast('waiting for network do not Exit page  ', errorRed);
          // ignore: use_build_context_synchronously
          bool sendOrder = await sendService(context, comment, data);
          if (sendOrder) {
            provider.isLoading(false);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            showToast(
                'Charge was successful. Ref: ${res.reference}', successBlue);
            showToast('Order Completed', successBlue);
          }
        }
      } else {
        provider.isLoading(false);
        // ignore: use_build_context_synchronously
    //   Navigator.pop(context);
        showToast('Failed: ${res.message}', errorRed);
      }
    } catch (error) {
      provider.isLoading(false);
      // ignore: use_build_context_synchronously
     // Navigator.pop(context);
      print('Payment Error ==> $error');
    }
    // ignore: use_build_context_synchronously
  Navigator.pop(context);
    provider.isLoading(false);
  }
}
