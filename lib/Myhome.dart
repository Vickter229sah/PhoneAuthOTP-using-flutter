import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(

        backgroundColor: Colors.purple,

        title: Text("'Home"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,),
        ),


      ),

      body: Column(

        children: [

          Center(

            child: Container(
              child: (
              Text("Welcome to New Page", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
