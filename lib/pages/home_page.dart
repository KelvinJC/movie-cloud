import 'package:flutter/material.dart';
import 'package:flutter_mdb/api/services.dart';
import 'package:flutter_mdb/api/config.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<MovieData> futureMovieData;
  String imageUrl = Config.image_base_url;
  String posterSize = Config.poster_size;

  // late List<dynamic> data;
  //
  // getMovieData(search, page) async {
  //   MovieData res = await ApiService.fetchMovieData(search, page);
  //   // Now you can access the 'result' getter on the 'data' object.
  //   data = res.results;
  // }

  getMovieData(search, page) async {
    futureMovieData = fetchMovieData(search, page);
  }

  @override
  void initState() {
    super.initState();
    getMovieData(null, 1);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 10),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage('assets/movie_logo.jpeg'),
                    fit: BoxFit.fill,
                  )
              )
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/beach3.png'),
            ),
            // Icon(Icons.person)
          )
        ],
        title: Text(
            'Movie Cloud',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold
            ),
        ),
      ),


      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
                width: 406,
                height: 228,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/john_wick.jpg'),
                      fit: BoxFit.fill,
                    )
                )
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Movie',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600)
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Trending Movies',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold

                  ),
                ),
              ],
            ),
          ),



          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: FutureBuilder<MovieData>(
                future: futureMovieData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
// While waiting for the data to load, show a progress indicator
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }


                  else if (snapshot.hasError) {
// If an error occurs during fetching data, display an error message
                    return Center(
                      child: Text('Error fetching data'),
                    );
                  } else if (snapshot.hasData) {
// If data is available, display it in a GridView
                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.7
                      ),
                      itemCount: snapshot.data!.results.length,
                      itemBuilder: (context, index) {
                        return RawMaterialButton(
                          onPressed: () {
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage("${imageUrl}${posterSize}${snapshot.data!.results[index]['poster_path']}"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        );
                      },
                    );






//                       GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2, // Number of columns in the grid
//                           crossAxisSpacing: 8.0,
//                           mainAxisSpacing: 8.0,
//                         ),
//                         itemCount: snapshot.data!.results.length,
//                         itemBuilder: (context, index) {
// // Build each grid item using the data
//                           return GridTile(
//                             child: Image.network("${imageUrl}${posterSize}${snapshot.data!.results[index]['poster_path']}"),
// // footer: GridTileBar(
// //   backgroundColor: Colors.black45,
// //   title: Text(snapshot.data![index].title),
// // ),
//                           );
//                         },
//                       );
                  }





                  else {
// If there's no data, display an empty message
                    return Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black45,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, ),
            label: 'Load more',
          ),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.favorite),
          //     label: ''
          // )
        ],
      ),
    );
  }
}





































//
//
//
// Scaffold(
// backgroundColor: Colors.grey[900],
// appBar: AppBar(
// elevation: 0,
// backgroundColor: Colors.transparent,
// leading: Padding(
// padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 10),
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// image: DecorationImage(
// image: AssetImage('assets/movie_logo.jpeg'),
// fit: BoxFit.fill,
// )
// )
// ),
// ),
//
// // SvgPicture.asset(
// //     'react-movie-logo.svg',
// //     // width: 40.0,
// //     // height: 48.0,
// // ),
// actions: [
// Padding(
// padding: const EdgeInsets.only(right: 20),
// child: Icon(Icons.person),
// )
// ],
//
// title: Text(
// 'Movie Cloud'
// ),
//
// ),
// // Search bar
// body: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15),
// child: Container(
// width: 406,
// height: 228,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// image: DecorationImage(
// image: AssetImage('assets/john_wick.jpg'),
// fit: BoxFit.fill,
// )
// )
// ),
// ),
// SizedBox(height: 20,),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15),
// child: TextField(
// decoration: InputDecoration(
// prefixIcon: Icon(Icons.search),
// hintText: 'Search Movie',
// focusedBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.grey.shade600)
// ),
// enabledBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.grey.shade600)
// )
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text(
// 'Trending Movies',
// style: TextStyle(
// ),
// ),
// ],
// ),
// ),
// Expanded(
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
// child: Container(
// child:
// GridView.builder(
// scrollDirection: Axis.vertical,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// mainAxisSpacing: 12,
// crossAxisSpacing: 12,
// childAspectRatio: 0.7
// ),
// itemCount: _images.length,
// itemBuilder: (context, index) {
// return RawMaterialButton(
// onPressed: () {
// },
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// image: DecorationImage(
// image: AssetImage(_images[index].imagePath),
// fit: BoxFit.cover
// )
// ),
// ),
// );
// },
// ),
//
//
//
//
//
//
//
//
//
//
// ),
// ),
// ),
// ],
// ),
//
// bottomNavigationBar: BottomNavigationBar(
// items: [
// BottomNavigationBarItem(
// icon: Icon(Icons.home, color: Colors.blue,),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.add_box, ),
// label: 'Load more',
// ),
// // BottomNavigationBarItem(
// //     icon: Icon(Icons.favorite),
// //     label: ''
// // )
// ],
// ),
//
//
// );