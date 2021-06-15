import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Network/local/cache_helper.dart';
import 'package:news/modules/ShopApp/Register_Screen/Cubit/RegisterCubit.dart';
import 'package:news/modules/ShopApp/Register_Screen/Cubit/RegisterStates.dart';
import 'package:news/modules/ShopApp/ShopLayout/ShopLayout.dart';
import 'package:news/shared/component/componentButton.dart';
import 'package:news/styles/constance.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, states) => {
          if (states is RegisterScuessStates)
            {
              if (states.registerModel.status)
                {
                  showToast(
                      text: states.registerModel.message,
                      states: ToastStates.Sucess),
                  CacheHelper.saveData(
                          key: 'token', value: states.registerModel.data.token)
                      .then((value) {
                    token = states.registerModel.data.token;
                    navigateAndFinish(context, ShopLayout());
                  })
                }
              else
                {
                  showToast(
                      text: states.registerModel.message,
                      states: ToastStates.Error),
                }
            }
        },
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultTextField(
                          context: context,
                          controller: nameController,
                          type: TextInputType.name,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter the name";
                            }
                          },
                          icon: Icons.person,
                          label: "Name",
                          isShown: false,
                          istrue: false),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter the Email";
                            }
                          },
                          icon: Icons.email,
                          label: "Email",
                          isShown: false,
                          istrue: false),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                          context: context,
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter the Phone";
                            }
                          },
                          icon: Icons.phone,
                          label: "phone",
                          isShown: false,
                          istrue: false),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextField(
                        context: context,
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter the Password';
                          }
                        },
                        icon: Icons.lock_open,
                        label: "Password",
                        isShown: RegisterCubit.get(context).showPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changeShowPassword();
                        },
                        suffixicon: RegisterCubit.get(context).showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        istrue: false,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: states is! RegisterLoadingStates,
                        builder: (BuildContext context) => defaultButton(
                            function: () {
                              if (formkey.currentState.validate()) {
                                RegisterCubit.get(context).register(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: "Register",
                            background: Colors.blue,
                            width: double.infinity),
                        fallback: (BuildContext context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
