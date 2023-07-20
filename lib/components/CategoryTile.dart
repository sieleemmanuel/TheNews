import 'package:flutter/material.dart';

Widget categoryListTile(BuildContext context, String category,
    String imageUrl) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3.0)]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.cover),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0))),
        ),
        const SizedBox(height: 10.0,),
        Text(category)
      ],
    ),
  );
}
