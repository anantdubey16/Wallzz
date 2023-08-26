// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:wallzz/controller/apiOper.dart';
import 'package:wallzz/model/photosmodel.dart';
import 'package:wallzz/views/screens/fullscreen.dart';
import 'package:wallzz/views/widgets/catblock.dart';
import 'package:wallzz/views/widgets/customappbar.dart';
import 'package:wallzz/views/widgets/searchBar.dart';

class Category extends StatefulWidget {
  String catName;
  String catImgUrl;
  Category({super.key, required this.catImgUrl, required this.catName});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late List<Photosmodel> categoryResults;
  bool isLoading = true;
  GetCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    GetCatRelWall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: const customappbar(),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator(),): SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    widget.catImgUrl),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                ),
                Positioned(
                  left: 170,
                  top: 70,
                  child: Column(
                    children: [
                      const Text("Category",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w300)),
                      Text(
                        widget.catName,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 700,
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 400,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: categoryResults.length,
                  itemBuilder: ((context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgUrl:
                                            categoryResults[index].imgSrc)));
                          },
                          child: Hero(
                            tag: categoryResults[index].imgSrc,
                            child: Container(
                              height: 800,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFFD740),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    height: 800,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    categoryResults[index].imgSrc),
                              ),
                            ),
                          ),
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
