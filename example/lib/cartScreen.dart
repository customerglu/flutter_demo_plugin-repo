import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartState();
  }
}

class _CartState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () => {Navigator.of(context).pop()},
                  child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_back_outlined))),
              const Text(
                "Cart Screen",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 22),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/shop.png")),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Container(
                  height: 50,
                  width: 100,
                  color: Colors.black,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartScreen()))
                    },
                    child: Center(
                      child: Text("Buy Now"),
                    ),
                  )))
        ],
      ),
    ));
  }
}
