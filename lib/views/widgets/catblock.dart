import 'package:flutter/material.dart';
import 'package:wallzz/views/screens/category.dart';

// ignore: must_be_immutable, camel_case_types
class catblock extends StatelessWidget {
  String categoryName;
  String categoryImgSrc;
  catblock(
      {super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Category(
                    catImgUrl: categoryImgSrc, catName: categoryName)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                  categoryImgSrc),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12)),
            ),
            Positioned(
                left: 35,
                top: 15,
                child: Text(
                  categoryName,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ))
          ],
        ),
      ),
    );
  }
}
