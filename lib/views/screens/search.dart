import 'package:flutter/material.dart';
import 'package:wallzz/controller/apiOper.dart';
import 'package:wallzz/model/photosmodel.dart';
import 'package:wallzz/views/screens/fullscreen.dart';
import 'package:wallzz/views/widgets/catblock.dart';
import 'package:wallzz/views/widgets/customappbar.dart';
import 'package:wallzz/views/widgets/searchBar.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Photosmodel> searchResults;
  bool isLoading = true;

  GetSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: customappbar(),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),):SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: searchBar()),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 400,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: ((context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgUrl: searchResults[index].imgSrc)));
                          },
                          child: Hero(
                            tag: searchResults[index].imgSrc,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 800,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    height: 700,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    searchResults[index].imgSrc),
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
