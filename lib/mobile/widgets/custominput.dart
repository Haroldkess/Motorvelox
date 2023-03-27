import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorvelox/service/constant.dart';

import '../../state/ui_manager.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     UiProvider _provider = Provider.of<UiProvider>(context);

    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child:Column(
          children: <Widget>[
            Row(
              children: const [
                Icon(Icons.email_outlined,size: 24.0,color: Colors.grey,semanticLabel: 'Email icon'),
                Padding(padding: EdgeInsets.only(left: 10.0),
                  child: Text('Email',
                    style: TextStyle(color: Color(0xff868686),fontSize: 16.0),),
                ),

              ],
            ),
             TextField(
                        onChanged: (value) async {
              await _provider.initializePref();
              _provider.pref!.setString(emailKey, value);
              log( _provider.pref!.getString(emailKey).toString());
            },
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
