import 'package:flutter/material.dart';

import 'cartScreen.dart';

class ShopScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _shopScreenState();
  }
}

class _shopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () => {Navigator.of(context).pop()},
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.arrow_back_outlined))),
                Text(
                  "Shop Screen",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 22),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return productCell();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productCell() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          height: 200,
          width: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/shop.png",
                    height: 80,
                    width: 80,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CartScreen()))
                          },
                      child: Container(
                          height: 50,
                          width: 100,
                          color: Colors.blue,
                          child: Center(
                            child: Text("Add to Cart"),
                          )))
                ],
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          height: 200,
          width: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/shop.png",
                    height: 80,
                    width: 80,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CartScreen()))
                          },
                      child: Container(
                          height: 50,
                          width: 100,
                          color: Colors.blue,
                          child: Center(
                            child: Text("Add to Cart"),
                          )))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
