import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:motorvelox/service/constant.dart';
import 'package:motorvelox/state/ui_manager.dart';

class EditName extends StatelessWidget {
  const EditName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiProvider _provider = Provider.of<UiProvider>(context);

    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const [
              Icon(Icons.person,
                  size: 24.0, color: Colors.grey, semanticLabel: 'name icon'),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Display Name',
                  style: TextStyle(color: Color(0xff868686), fontSize: 16.0),
                ),
              ),
            ],
          ),
          TextField(
         
            onChanged: (value) async {
              await _provider.initializePref();
              _provider.pref!.setString(nameKey, value);
       
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
    ));
  }
}
