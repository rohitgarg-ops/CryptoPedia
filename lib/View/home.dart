// ignore_for_file: body_might_complete_normally_nullable

import 'package:cryptopedia/Model/coinModel.dart';
import 'package:cryptopedia/View/Components/item.dart';
import 'package:cryptopedia/View/Components/item2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 255, 226, 108), Color(0xffFBC700)],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: myHeight * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: myWidth * 0.02, vertical: myHeight * 0.005),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'Main Portfolio',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    'Top 10',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Experimental',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹ 75,450.20',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    padding: EdgeInsets.all(myWidth * 0.015),
                    height: myHeight * 0.04,
                    width: myWidth * 0.1,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5)),
                    child: Image.asset(
                      'assets/icons/5.1.png',
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
              child: Row(
                children: [
                  Text(
                    '+ 160.57 % All time',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: myHeight * 0.01,
            ),
            Container(
              height: myHeight * 0.7,
              width: myWidth,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: myHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: myWidth * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Assets',
                          style: TextStyle(fontSize: 17),
                        ),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.02,
                  ),
                  Expanded(
                      child: isRefereshing == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: 4,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Item(item: coinMarket![index]);
                              },
                            )),
                  SizedBox(
                    height: myHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                    child: Row(
                      children: [
                        Text(
                          'Recommended to buy',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  Container(
                    height: myHeight * 0.21,
                    child: Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: myWidth * 0.05),
                        child: ListView.builder(
                            itemCount: coinMarket!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Item2(
                                item: coinMarket![index],
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isRefereshing = true;
  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isRefereshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'accept': 'application/json'
    });
    setState(() {
      isRefereshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
