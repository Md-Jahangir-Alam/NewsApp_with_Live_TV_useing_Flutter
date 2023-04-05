import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desh_bidesh/drawar.dart';
import 'package:desh_bidesh/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class signuppages extends StatefulWidget {
  const signuppages({Key? key}) : super(key: key);

  @override
  State<signuppages> createState() => _signuppagesState();
}

class _signuppagesState extends State<signuppages> {

  final GlobalKey<ScaffoldState> _drawer = GlobalKey<ScaffoldState>();
  final _phone = TextEditingController();
  final _fullname = TextEditingController();
  final _name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var _uid;

  getUid() async{
    final FirebaseAuth _auth =await FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    setState(() {
      _uid = uid;
    });
    return uid;
  }

  File? image;

  Future _getImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);

    if(pickedFile == null)return;
    setState(() {
      image = File(pickedFile.path);
    });
  }

  uploaddata()async{
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref("/image"+ DateTime.now().millisecondsSinceEpoch.toString());
    firebase_storage.UploadTask uploadTask = ref.putFile(image!);
    await Future.value(uploadTask);
    var newUrl =await ref.getDownloadURL();
    FirebaseFirestore.instance.collection("users")
      .doc(_uid.toString()).set({
      "name" : _name.text.toString(),
      "fullname" : _fullname.text.toString(),
      "image" : newUrl.toString(),
    });


  }

  @override
  void initState() {
    getUid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _drawer,
      drawer: Drawer(
        child: draWar(),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        title: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              "Desh Bidesh",
              style: TextStyle(fontSize: 25),
            )),
        leading: IconButton(
            onPressed: () {
              _drawer.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 30,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                size: 30,
              )),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/login.png"), fit: BoxFit.cover)),
          ),
          Positioned(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Colors.grey,
                                    child: ClipOval(
                                      child: image == null
                                          ? new Text('No image')
                                          : Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    child: Center(
                                      child: IconButton(onPressed: (){
                                        _getImage();
                                      },icon: Icon(Icons.camera_alt_outlined, size: 30,),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              FittedBox(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Add Your Profile Photo",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: _name,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.pinkAccent),
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.pinkAccent),
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    prefixIcon: Icon(
                                      Icons.verified_user,color: Colors.pinkAccent,
                                    ),
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.pinkAccent),
                                    labelText: "Username",
                                    labelStyle: TextStyle(color: Colors.pinkAccent),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Username";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _fullname,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.pinkAccent),
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.pinkAccent),
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline_outlined,color: Colors.pinkAccent,
                                    ),
                                    hintText: "Fullname",
                                    hintStyle: TextStyle(color: Colors.pinkAccent),
                                    labelText: "Fullname",
                                    labelStyle: TextStyle(color: Colors.pinkAccent),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Your Fullname";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _phone,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.pinkAccent),
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.pinkAccent),
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                    ),
                                    prefixIcon: Icon(
                                        Icons.call,color: Colors.pinkAccent
                                    ),
                                    hintText: "Number",
                                    hintStyle: TextStyle(color: Colors.pinkAccent),
                                    labelText: "Number",
                                    labelStyle: TextStyle(color: Colors.pinkAccent),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Your Number.";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                                    onPressed: ()async{
                                      if(formKey.currentState!.validate()){
                                        uploaddata();
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                      }
                                    }, child: Text("Finish")),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
