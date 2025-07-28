import 'package:course_app/models/razorpay_key_model.dart';
import 'package:flutter/material.dart';

import '../../controllers/user_controller.dart';
import 'package:get/get.dart';

import '../../controllers/users_controller.dart';

class UpdateKey extends StatefulWidget {
  const UpdateKey({super.key});

  @override
  State<UpdateKey> createState() => _UpdateKeyState();
}

class _UpdateKeyState extends State<UpdateKey> {
  final keyController = TextEditingController();
  final UsersController userController = Get.put(UsersController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userController.key != null) {
      keyController.text = userController.key!.key!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Categories'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  controller: keyController,
                  decoration: const InputDecoration(label: Text("Razorpay Key"),border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (userController.key == null ||
                        userController.key!.key!.isEmpty) {
                      await userController.addRazorpay(
                          RazorpaykeyModel(key: keyController.text));
                    } else {
                      _openDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  child: userController.isLoading.value
                      ? const CircularProgressIndicator()
                      : (userController.key == null ||
                      userController.key!.key!.isEmpty) ? Text("Add") :Text("Update"))
            ],
          ),
        ),
      ),
    );
  }

  void _openDialog(BuildContext context) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text("Do you want to update the key?",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 24),),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("No",style: TextStyle(fontSize: 18),)),
          TextButton(onPressed: (){
            userController.updateRazorpay(RazorpaykeyModel(key: keyController.text, id: userController.key!.id));
            Navigator.pop(context);
            Get.snackbar("Success", "Key Updated Successfully",colorText: Colors.white,backgroundColor: Colors.green);
          }, child: const Text("Yes",style: TextStyle(fontSize: 18),))
        ],
      );
    });
  }
}
