import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../allNavigation.dart';
import '../../../models/user_model.dart';
import '../user_orders.dart';

class OrderedUsers extends StatelessWidget {
  final double price;
  final String title;
  final String assetPath;
  final UserModel data;
  OrderedUsers({
    Key? key,
    required this.data,
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

    return InkWell(
      onTap: () {
        print(data.id);
        PageRouting.pushToPage(
            context, UserOrders(name: data.name!, id: data.id!));
      },
      child: Container(
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
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        image:
                            CachedNetworkImageProvider(data.profileImageUrl!),
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
                            data.name!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                           SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Text(
                              data.phoneNumber!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Text(
                              data.email!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.person,
                          size: 18,
                          color: Color(0xFFFA4A0C),
                        ),
                        onPressed: () async {
                          // do something
                        },
                      ),
                    ],
                  ),
                ])),
      ),
    );
  }
}
