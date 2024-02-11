import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp/Myhome.dart';
import 'package:phone_otp/phone.dart';
import 'package:pinput/pinput.dart';


class MyOtp extends StatefulWidget {
  const MyOtp({super.key});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("OTP...",style: TextStyle(color: Colors.deepOrange,fontSize: 22,fontWeight: FontWeight.bold),),
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,
          ),
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

              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value){
                  code = value;


                },


              ),


                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(onPressed: () async{

                          try {
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code);

                            // Sign the user in (or link) with the credential
                            await auth.signInWithCredential(credential);
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>home()));
                          } catch(e){
                            print("wrong otp");

                          }




                        }, child: Text(" Verify ", style: TextStyle(color: Colors.black,),), style: ElevatedButton.styleFrom(
                            primary: Colors.green, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),



                        )
                        ),
                         ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),

                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPhone()));

                  }, child: Text("Edit Phone Number",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  ))

                ],
              ),
            )
        ),
      ),
    );
  }
}
