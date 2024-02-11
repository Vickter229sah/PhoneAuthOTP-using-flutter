import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp/otp.dart';
import 'package:pinput/pinput.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({super.key});
   static String verify = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}


class _MyPhoneState extends State<MyPhone> {
  TextEditingController countrycode = TextEditingController();
  var phone = "";
  @override
  void initState(){
    countrycode.text = " +91";
    super.initState();
  }

  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Verification....", style: TextStyle(color: Colors.deepOrange,fontSize: 22,fontWeight: FontWeight.bold),),
          ],
        ),
      ),


      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,

        child: (


        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Phone Verification",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              SizedBox(height: 10,),
              Text("We need to register your phone before getting Started"
              , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 45, width: double.infinity,),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: countrycode ,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text("|", style: TextStyle(fontSize: 33, color: Colors.grey),),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          phone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Phone"),

                      ) ,
                    )

                  ],
                ),
              ),

              SizedBox(height: 20,),

              Row(
                children: [
                  Expanded(

                    child: ElevatedButton(onPressed: () async{

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countrycode.text+phone}',
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          MyPhone.verify = verificationId;

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyOtp()),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );

                    }, child: Text("Send code", style: TextStyle(color: Colors.black),), style: ElevatedButton.styleFrom(
                      primary: Colors.green, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                      
                    )
                    ),),
                  ),
                ],
              )

            ],
          ),
        )
        ),
      ),
    );
  }
}
