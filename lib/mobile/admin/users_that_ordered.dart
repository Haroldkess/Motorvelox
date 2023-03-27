import 'package:flutter/material.dart';
import 'package:motorvelox/designParams/params.dart';
import 'package:provider/provider.dart';
import 'package:motorvelox/mobile/admin/adminextra/order_users.dart';

import '../../responsive/responsive_config.dart';
import '../../service/controller.dart';
import '../../state/ui_manager.dart';
import '../screens/cart.dart';
import '../widgets/deal_item.dart';
import '../widgets/empty_state.dart';
import 'adminextra/admin_extra.dart';

class AdminOrderPage extends StatefulWidget {
  const AdminOrderPage({super.key});

  @override
  State<AdminOrderPage> createState() => _AdminOrderPageState();
}

class _AdminOrderPageState extends State<AdminOrderPage> {
  @override
  void initState() {
    super.initState();
    getCart(context);
  }

  Future getCart(BuildContext context) async {
    await Controls.doneAdminOrderController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Admin Order",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Controls.doneAdminOrderController(context),
        child: Stack(
          children: [
          
           
            Container(
              color: background,
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context)
                      ? MediaQuery.of(context).size.width * 0.15
                      : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30),
                  AdminAlert(),
                  Expanded(
                    child: context.watch<UiProvider>().adminOrderUsers.isNotEmpty
                        ? ListView(
                            children: context
                                .watch<UiProvider>()
                                .adminOrderUsers
                                .map(
                                  (e) => OrderedUsers(
                                    assetPath: 'assets/images/tablet.png',
                                    title: '2020 Apple iPad Air 10.9"',
                                    price: 579,
                                    data: e,
                                  ),
                                )
                                .toList())
                        : EmptyState(
                            path: 'assets/images/no_history.png',
                            title: 'No Orders yet',
                            description:
                                'Hit the blue button down below to Leave page',
                            textButton: 'Go Back',
                            onClick: () {
                              Navigator.pop(context);
                            },
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
