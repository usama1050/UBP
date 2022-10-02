import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeTiles_Detail extends StatefulWidget {
  const HomeTiles_Detail({Key? key,required this.detail,required this.imageList,required this.title}) : super(key: key);
  final String detail;
  final String title;
  final List<dynamic> imageList;
  @override
  State<HomeTiles_Detail> createState() => _HomeTiles_DetailState();
}

class _HomeTiles_DetailState extends State<HomeTiles_Detail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [

            CarouselSlider.builder(
              itemCount: this.widget.imageList.length,
              options: CarouselOptions(
                height: 400,
                viewportFraction: 1,
                enlargeCenterPage: true,
                autoPlay: false,
                scrollDirection: Axis.horizontal,
                autoPlayInterval: Duration(seconds: 3),
                reverse: false,

              ),
              itemBuilder: (context, i, id){
                //for onTap to redirect to another screen
                return GestureDetector(
                  child: Container(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),


                    ),
                    //ClipRRect for image border radius
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        this.widget.imageList[i],
                        width: 500,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  onTap: (){
                    var url = this.widget.imageList[i];
                    print(url.toString());
                  },
                );
              },
            ),
            Container(

              width : double.infinity,

              margin: const EdgeInsets.only(
                left: 15,
                top: 25,
                right: 7,
                bottom: 0,
              ),
              child: Text(this.widget.title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21,color: Colors.black), textAlign: TextAlign.left),

            ),
            Container(
              width : double.infinity,
              margin: const EdgeInsets.only(
                left: 15,
                top: 25,
                right: 7,
                bottom: 20,
              ),
              child: Text(this.widget.detail, style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20,color: Colors.grey), textAlign: TextAlign.left),

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
      onPressed:back,

      backgroundColor: Colors.black,

      child: const Icon(Icons.close_sharp,color: Colors.white,),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

    );
  }
  void back() {
    Navigator.pop(context);
  }
}
