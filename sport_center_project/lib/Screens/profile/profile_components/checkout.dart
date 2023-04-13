import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sport_center_project/Utilities/VariablesUtils.dart';
import 'package:sport_center_project/shared/component/component.dart';

class CheckOutSheet extends StatefulWidget {
  const CheckOutSheet({super.key});

  @override
  _CheckOutSheetState createState() => _CheckOutSheetState();
}

class _CheckOutSheetState extends State<CheckOutSheet> {
  List<int> lint = [];

  @override
  void initState() {
    lint = VariablesUtils.totalPrice.map(int.parse).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: -15,
              child: Container(
                width: 55,
                height: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Number of items',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('${VariablesUtils.totalPrice.length}'),
                SizedBox(
                  height: 10,
                ),
                lint.isNotEmpty
                    ? Text(
                  'Total Price: ${lint.reduce((a, b) => a + b)}',
                  style: TextStyle(fontSize: 17),
                )
                    : Text(
                  'Total Price: 0',
                  style: TextStyle(fontSize:20),
                ),
                SizedBox(height: 10,),
                defaultLoginButton(
                    radius: 12,
                    backround: Colors.blueGrey.shade900.withOpacity(0.9),

                    function: () {
                      Fluttertoast.showToast(
                          msg: 'Our future work will be on map');
                    },
                    text: 'Confirm Checkout')
              ],
            ),
          ),
        ]);
  }
}