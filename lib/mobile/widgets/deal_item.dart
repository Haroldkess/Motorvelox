import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motorvelox/mobile/widgets/delete_modal.dart';
import 'package:motorvelox/mobile/widgets/toast.dart';
import 'package:motorvelox/models/order_model.dart';
import 'package:motorvelox/models/prod_model.dart';
import 'package:motorvelox/service/constant.dart';

import '../../designParams/params.dart';

class DealItem extends StatelessWidget {
  final double price;
  final String title;
  final String assetPath;
  final OrderModel product;
  DealItem({
    Key? key,
    required this.product,
    this.price = 0,
    this.title = 'Title of the product',
    this.assetPath = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 14),
      padding: EdgeInsets.all(0),
      minimumSize: const Size(22, 22),
      maximumSize: const Size(22, 22),
      elevation: 0,
      primary: Color(0xFF7DCCEC),
    );

    return Container(
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
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
          padding: EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Image(
                  image: CachedNetworkImageProvider(product.image.toString()),
                  width: 80,
                  height: 105,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Requested ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    // Text(
                    //   '${currencySymbol()} ${numberFormat.format(int.tryParse(product.price!))} x ${product.quantity.toString()} ',
                    //   style: const TextStyle(
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: 15,
                    //       color: Color(0xFF5956E9)),
                    // ),
                    // Row(
                    //   children: [
                    //     const Text('Quantity: '),
                    //     Text(
                    //       product.quantity.toString(),
                    //       style: const TextStyle(
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 15,
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        "Motorvelox",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        "bimechtech@gmail.com",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        "08104544917",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        "${product.timeStamp!.toDate().day}|${product.timeStamp!.toDate().month}|${product.timeStamp!.toDate().year} - ${product.timeStamp!.toDate().hour}:${product.timeStamp!.toDate().minute}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.contacts_outlined,
                    size: 18,
                    color: Color(0xFFFA4A0C),
                  ),
                  onPressed: () async {
                    await Clipboard.setData(
                        const ClipboardData(text: "08104544917"));

                    showToast("Phone-number copied", successBlue);

                    // Modals.deleteFromCart(context, product.id!);
                    // do something
                  },
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 6,
                      backgroundColor:
                          product.recieved! ? kPrimaryColor : Colors.orange,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      product.recieved! ? 'Recieved' : 'Processing',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ])),
    );
  }
}
