import 'package:flutter/material.dart';
import 'package:wallzz/views/screens/search.dart';

class searchBar extends StatelessWidget {
  searchBar({Key? key}) : super(key: key);

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 154, 154, 154),
        border: Border.all(color: Color.fromARGB(6, 255, 249, 79)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Wallpapers",
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchScreen(query: _searchController.text)));
              },
              child: Icon(Icons.search)),
        ],
      ),
    );
  }
}
