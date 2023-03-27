import 'package:flutter/material.dart';
import 'package:motorvelox/mobile/fuel/fuel_card.dart';
import 'package:motorvelox/state/ui_manager.dart';
import 'package:provider/provider.dart';

import '../servicemodel/service_model.dart';

class ServiceSection extends StatefulWidget {
  const ServiceSection({super.key});

  @override
  State<ServiceSection> createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  @override
  Widget build(BuildContext context) {
    UiProvider stream = context.watch<UiProvider>();
    UiProvider service = Provider.of<UiProvider>(context, listen: false);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: const [
                Text(
                  "Pick a service option.",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            // height: MediaQuery.of(context).size.height * 0.9,
            child: ListView.builder(
                itemCount: stream.serviceModel.length,
                itemBuilder: (BuildContext context, index) {
                  ServiceModel data = service.serviceModel[index];
                  return FuelCard(
                    data: data,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
