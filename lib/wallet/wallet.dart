
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:googleapis/clouddebugger/v2.dart';
import 'package:algo_learn/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:algo_learn/utils/my_button.dart';
import 'package:algo_learn/utils/my_list.dart';
import 'package:algo_learn/utils/my_algo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:algo_learn/utils/my_nft.dart';
import 'package:algo_learn/theme/themes.dart';

class WalletsPage extends StatefulWidget {
  @override
  _WalletsPageState createState() => _WalletsPageState();
}


class _WalletsPageState extends State<WalletsPage> {
  final _controller=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
            // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16.0),
            backgroundColor: Palette.accentColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Algo-wallet',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Palette.accentColor,
                    )),
              ],
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ))
          ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(children: [
          SizedBox(height: 20),
          Container(
            height: 198,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: [
                MyAlgo(
                  balance: 895,
                  cardNumber: 123456789,
                  expiryMonth: 10,
                  expiryYear: 24,
                  color: Palette.accentColor,
                ),
                MyNFT(
                  balance: 53,
                  cardNumber: 123456789,
                  expiryMonth: 12,
                  expiryYear: 23,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          SmoothPageIndicator(
            controller: _controller,
            count: 2,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.grey.shade600,
            ),
          ),

          SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  iconImagePath: 'assets/images/credit.png',
                  buttonText: 'Pay',
                ),
                MyButton(
                  iconImagePath: 'assets/images/save_money.png',
                  buttonText: 'Send',
                ),
                MyButton(
                  iconImagePath: 'assets/images/bill.png',
                  buttonText: 'Bills',
                ),
              ],
            ),
          ),
          SizedBox(height: 0),

          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(children: [
              MyListTile(
                iconImagePath: 'assets/images/transactions.png',
                tileTitle: 'History',
                tileSubtitle: 'Transactions Made',
              ),
              MyListTile(
                iconImagePath: 'assets/images/graph.png',
                tileTitle: 'Payments',
                tileSubtitle: 'Statistics on Payment',
              ),
            ]),
          )
        ]),
        ),
      )
    );

  }
}