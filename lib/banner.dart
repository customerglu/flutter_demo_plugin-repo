import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cust_Banner extends StatelessWidget
{
  const Cust_Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.amber
      ),
      child: const Center(
        child: Text("Hello Banner"),
      ),
    );
  }

}