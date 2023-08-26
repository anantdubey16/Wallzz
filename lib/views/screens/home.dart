import 'package:flutter/material.dart';
import 'package:wallzz/controller/apiOper.dart';
import 'package:wallzz/model/categoryModel.dart';
import 'package:wallzz/model/photosmodel.dart';
import 'package:wallzz/views/screens/fullscreen.dart';
import 'package:wallzz/views/widgets/catblock.dart';
import 'package:wallzz/views/widgets/customappbar.dart';
import 'package:wallzz/views/widgets/searchBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Photosmodel> trendingWallList;
  late List<CategoryModel> CatModList;
  bool isLoading = true;

  GetCatDetail() async {
    CatModList = await ApiOperations.getCategoriesList();
    print("Getting Cat Mod List");
    print(CatModList);
    setState(() {
      CatModList = CatModList;
    });
  }

  GetTrendingWallpapers() async {
    trendingWallList = await ApiOperations.getTrendingWallpapers();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetCatDetail();
    GetTrendingWallpapers();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: customappbar(),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: searchBar()),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 30,
                          itemBuilder: ((context, index) => catblock(
                            categoryImgSrc: CatModList[index].catImgUrl,
                            categoryName: CatModList[index].catImgUrl,

                          ))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 650,
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 400,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: trendingWallList.length,
                        itemBuilder: ((context, index) => GridTile(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullScreen(
                                              imgUrl: trendingWallList[index]
                                                  .imgSrc)));
                                },
                                child: Hero(
                                  tag: trendingWallList[index].imgSrc,
                                  child: Container(
                                    height: 800,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.amberAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          height: 800,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          trendingWallList[index].imgSrc),
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
