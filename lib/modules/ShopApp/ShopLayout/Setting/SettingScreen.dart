import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Network/local/cache_helper.dart';
import 'package:news/modules/ShopApp/Login/login.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/Cubit.dart';
import 'package:news/modules/ShopApp/ShopLayout/Cubit/States.dart';
import 'package:news/modules/ShopApp/ShopLayout/Setting/Contacts/Contacts.dart';
import 'package:news/shared/component/componentButton.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var numberController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, states) => {},
        builder: (context, states) {
          var cubit = ShopCubit.get(context).settingModel;
          nameController.text = cubit.data.name;
          emailController.text = cubit.data.email;
          numberController.text = cubit.data.phone;
          return Scaffold(
            appBar: AppBar(
                // title: Text("data"),
                ),
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: NetworkImage(
                              'https://student.valuxapps.com/storage/uploads/users/eMylwuhbCg_1622063293.jpeg',
                            ),
                            color: Colors.grey.shade200,
                            width: 400,
                            height: 300,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personal Information",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "You Can Edit the Personal information",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.grey),
                            ),
                            SizedBox(height: 30),
                            defaultTextField(
                              context: context,
                              controller: nameController,
                              type: TextInputType.name,
                              icon: Icons.email,
                              isShown: false,
                              istrue: false,
                            ),
                            SizedBox(height: 20),
                            defaultTextField(
                              context: context,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              icon: Icons.email,
                              isShown: false,
                              istrue: false,
                            ),
                            SizedBox(height: 20),
                            defaultTextField(
                              context: context,
                              controller: numberController,
                              type: TextInputType.number,
                              icon: Icons.email,
                              isShown: false,
                              istrue: false,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultButton(
                                width: double.infinity,
                                function: () {
                                  CacheHelper.rmoveData(key: 'token')
                                      .then((value) {
                                    navigateAndFinish(context, LoginScreen());
                                  });
                                },
                                background: Colors.blue,
                                text: "LogOut"),
                            SizedBox(height: 20),
                            defaultButton(
                                width: double.infinity,
                                function: () {
                                  navigateTo(context, ContactsScreen());
                                },
                                background: Colors.blue,
                                text: "Go To contacts With Response"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
