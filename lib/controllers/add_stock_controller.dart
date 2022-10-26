import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_forum/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yahoofin/yahoofin.dart';

class AddStockController extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final yfin = YahooFin();
  List<String> stockList = [];
  StockQuote? quote;
  String updatedValue = 'error - ';
  addStock() {
    try {
      Get.defaultDialog(
        title: 'Priority Stocks',
        backgroundColor: Colors.lightBlue,
        content: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              cursorColor: Colors.black,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "stock symbol e.g. 'msft', 'goog'",
              ),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                updatedValue = value;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () async {
                addToWatchlist();
                updatedValue = 'error - ';
                notifyListeners();
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ))
        ]),
      );
    } catch (e) {
      'no changes made';
    }
    notifyListeners();
  }

  addToWatchlist() async {
    try {
      Get.close(1);
      loading();
      StockInfo info = yfin.getStockInfo(ticker: updatedValue);
      quote = await info.getStockData();
      stockList.add(quote!.ticker!);
      Get.close(1);
      notifyListeners();
    } on YahooApiException catch (e) {
      Get.close(1);
      getSnackBar('Oops!', e.message!);
      notifyListeners();
    }
  }

  removeStock(index) {
    stockList.removeAt(index);
    notifyListeners();
  }
}
