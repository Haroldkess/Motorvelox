import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorvelox/designParams/params.dart';
import 'package:provider/provider.dart';
import 'package:motorvelox/state/ui_manager.dart';

import '../../responsive/responsive_config.dart';
import '../../service/controller.dart';
import '../widgets/cart_item.dart';
import '../widgets/deal_item.dart';
import '../widgets/empty_state.dart';
import 'cart.dart';

class DoneDeals extends StatefulWidget {
  const DoneDeals({Key? key}) : super(key: key);

  @override
  State<DoneDeals> createState() => _DoneDealsState();
}

class _DoneDealsState extends State<DoneDeals> {
  @override
  void initState() {
    super.initState();
    getCart(context);
  }

  Future getCart(BuildContext context) async {
    if (Provider.of<UiProvider>(context, listen: false).doneDeals.isNotEmpty) {
      return;
    }
    await Controls.doneDealsController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Order History",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Controls.doneDealsController(context),
        child: Stack(
          children: [
      
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context)
                      ? MediaQuery.of(context).size.width * 0.15
                      : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30),
                  InfoAlert(),
                  Expanded(
                    child: context.watch<UiProvider>().doneDeals.isNotEmpty
                        ? ListView(
                          padding: const  EdgeInsets.symmetric(horizontal: 10),
                            children: context
                                .watch<UiProvider>()
                                .doneDeals
                                .map(
                                  (e) => DealItem(
                                    assetPath: 'assets/images/tablet.png',
                                    title: '2020 Apple iPad Air 10.9"',
                                    price: 579,
                                    product: e,
                                  ),
                                )
                                .toList())
                        : SingleChildScrollView(
                          child: EmptyState(
                              path: 'assets/images/no_favorites.png',
                              title: 'No service yet',
                              description:
                                  'Hit the blue button down below to request a service',
                              textButton: 'Start requesting',
                              onClick: () {
                                Navigator.pop(context);
                              },
                            ),
                        ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(height: 20)
                ],
              ),
            ),
     
          ],
        ),
      ),
    );
  }
}
