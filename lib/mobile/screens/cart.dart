import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorvelox/service/controller.dart';
import 'package:motorvelox/service/database_service.dart';
import 'package:motorvelox/state/ui_manager.dart';

import '../../designParams/params.dart';
import '../../responsive/responsive_config.dart';
import '../../service/constant.dart';
import '../widgets/button.dart';
import '../widgets/cart_item.dart';
import '../widgets/toast.dart';
import 'checkout.dart';

// Carrito de compras
class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    getCart(context);
  }

  Future getCart(BuildContext context) async {
    if (Provider.of<UiProvider>(context, listen: false).cartList.isNotEmpty) {
      return;
    }
    await Controls.cartCollectionControl(context)
        .whenComplete(() => DatabaseService.getDeliveryPrices(context));
    // ignore: use_build_context_synchronously
    await DatabaseService.getDeliveryPrices(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F8),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff5956E9),
          ),
        ),
        title: const Text(
          "Basket",
          style: TextStyle(
            color: Color(0xff5956E9),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              size: 28,
              color: Color(0xFFFA4A0C),
            ),
            onPressed: () {
              // do something
            },
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.center,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: const Image(
                      image: AssetImage('assets/images/splash.png'),
                      fit: BoxFit.contain))),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width * 0.15
                    : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                CartInfoAlert(),
                Expanded(
                  child: context.watch<UiProvider>().cartList.isNotEmpty
                      ? ListView(
                          children: context
                              .watch<UiProvider>()
                              .cartList
                              .map(
                                (e) => CartItem(
                                  assetPath: 'assets/images/tablet.png',
                                  title: '2020 Apple iPad Air 10.9"',
                                  price: 579,
                                  product: e,
                                ),
                              )
                              .toList())
                      : Column(
                          children: const [
                            Center(
                              child: CupertinoActivityIndicator(
                                color: Color(0xFF5956E9),
                                radius: 30,
                              ),
                            ),
                            Text(
                              'Nothing in your cart',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 17),
                      ),
                      Row(
                        children: [
                          Text(
                            '${currencySymbol()}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5956E9),
                            ),
                          ),
                          Text(
                            numberFormat.format(int.tryParse(context
                                .watch<UiProvider>()
                                .totalPrice
                                .toString())),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5956E9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: LargeButton(
                    text: 'Checkout',
                    onClick: () async {
                      bool value =
                          await Controls.checkEnable(context, 'oneGod1997');

                      if (value == false) {
                        showToast('We are closed kindly come back tomorrow',
                            errorRed);
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Checkout()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
          Positioned(
            top: 2.0,
            right: 2.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Image(
                      image: AssetImage('assets/images/EllipseMorado.png')),
                  // ShaderMask(
                  //     shaderCallback: (rect) {
                  //       return const LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: FractionalOffset.center,
                  //         colors: [Colors.black, Colors.transparent],
                  //       ).createShader(rect);
                  //     },
                  //     blendMode: BlendMode.dstIn,
                  //     child: const Image(
                  //         image: AssetImage('assets/images/EllipseRosa.png'),
                  //         fit: BoxFit.contain)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InfoAlert extends StatelessWidget {
  const InfoAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        child: Card(
          color: const Color(0XFFD3F2FF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
             alignment: Alignment.center,
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined),
                  onPressed: () {},
                  iconSize: 28,
                ),
              const  Expanded(
                  child:  Text(
                    'Relax. Services will be rendered shortly',
                
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(width: 12)
              ],
            ),
          ),
        ));
  }
}

class CartInfoAlert extends StatelessWidget {
  const CartInfoAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Card(
          color: const Color(0XFFD3F2FF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () {},
                iconSize: 28,
              ),
              const Text(
                'Process cart before 5pm, for quick delivery',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 12)
            ],
          ),
        ));
  }
}


class AdminAlert extends StatelessWidget {
  const AdminAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Card(
          color: const Color(0XFFD3F2FF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined),
                onPressed: () {},
                iconSize: 28,
              ),
              const Text(
                'Please quickly fufil These Orders ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 12)
            ],
          ),
        ));
  }
}


class FuelAlertError extends StatelessWidget {
  const FuelAlertError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  Colors.red.withOpacity(0.4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined,color: Colors.white,),
              onPressed: () {},
              iconSize: 28,
            ),
            const Text(
              'Incorrect phone number can delay delivery',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.white
              ),
            ),
            SizedBox(width: 12)
          ],
        ),
      ),
    );
  }
}
