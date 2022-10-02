import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Artisit_Detail extends StatefulWidget {
  const Artisit_Detail({Key? key,required this.detail,required this.imageList,required this.title,required this.subtitle}) : super(key: key);
  final String detail;
  final String title;
  final String subtitle;
  final String imageList;
  @override
  State<Artisit_Detail> createState() => _Artisit_DetailState();
}

class _Artisit_DetailState extends State<Artisit_Detail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [

            CarouselSlider.builder(
              itemCount: 1,
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
                        this.widget.imageList,
                        width: 500,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  onTap: (){
                    var url = this.widget.imageList;
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
              child: Text(this.widget.title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black), textAlign: TextAlign.left),

            ),
            Container(

              width : double.infinity,

              margin: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 7,
                bottom: 0,
              ),
              child: Text(this.widget.subtitle, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 19,color: Colors.grey), textAlign: TextAlign.left),

            ),
            Container(

              width : double.infinity,

              margin: const EdgeInsets.only(
                left: 15,
                top: 25,
                right: 7,
                bottom: 0,
              ),
              child: Text(this.widget.detail, style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17,color: Colors.grey), textAlign: TextAlign.left),

            ),
            Container(

              width : double.infinity,

              margin: const EdgeInsets.only(
                left: 15,
                top: 25,
                right: 7,
                bottom: 20,
              ),
              child: Text("Followers", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black), textAlign: TextAlign.left),
            ),
            Row(children: [
              Container(
                  width : 90,
                  height: 90,
                  margin: const EdgeInsets.only(left: 10,top: 10,bottom: 10),

                  child:ClipRRect(

                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(45.0),

                        topLeft: Radius.circular(45.0),
                        bottomRight: Radius.circular(45.0),
                        bottomLeft: Radius.circular(45.0),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/ubpx-app-logo-200-clr.png',
                        image:this.widget.imageList
                        ,fit: BoxFit.fill,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/ubpx-app-logo-200-clr.png',
                          );
                        },
                      )
                  )



//videoKey
              ),
              Expanded(child:

              Container(

                width : double.infinity,

                margin: const EdgeInsets.only(
                  left: 15,
                  top: 25,
                  right: 10,
                  bottom: 20,
                ),
                child: Text("View All", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.blue), textAlign: TextAlign.right),

              ),

             )

            ],),


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
