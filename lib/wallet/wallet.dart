
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/clouddebugger/v2.dart';
import 'package:untitled1/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:untitled1/util/my_button.dart';
import 'package:untitled1/util/my_list.dart';
import 'package:untitled1/util/my_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}


class _WalletPageState extends State<WalletPage> {
  final _controller=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
            // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16.0),
            backgroundColor: Colors.blue,
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
                      color: Colors.blue,
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
                MyCard(
                  balance: 8950.20,
                  cardNumber: 123456789,
                  expiryMonth: 10,
                  expiryYear: 24,
                  color: Colors.blue,
                ),
                MyCard(
                  balance: 5340.20,
                  cardNumber: 123456789,
                  expiryMonth: 12,
                  expiryYear: 23,
                  color: Colors.red,
                ),
                MyCard(
                  balance: 3330.20,
                  cardNumber: 123456789,
                  expiryMonth: 12,
                  expiryYear: 25,
                  color: Colors.green[400],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          SmoothPageIndicator(
            controller: _controller,
            count: 3,
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
                  iconImagePath: 'asset/images/credit.png',
                  buttonText: 'Pay',
                ),
                MyButton(
                  iconImagePath: 'asset/images/save_money.png',
                  buttonText: 'Send',
                ),
                MyButton(
                  iconImagePath: 'asset/images/bill.png',
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
                iconImagePath: 'asset/images/transactions.png',
                tileTitle: 'History',
                tileSubtitle: 'Transactions Made',
              ),
              MyListTile(
                iconImagePath: 'asset/images/graph.png',
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