import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Network/local/cache_helper.dart';
import 'package:news/modules/ShopApp/Login/Cubit/cubit.dart';
import 'package:news/modules/ShopApp/Login/Cubit/states.dart';
import 'package:news/modules/ShopApp/Register_Screen/ShopRegister.dart';
import 'package:news/modules/ShopApp/ShopLayout/ShopLayout.dart';
import 'package:news/shared/component/componentButton.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool shownPassword = true;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, states) => {
            if (states is LoginScussedStates)
              {
                if (states.shopLoginModel.status)
                  {
                    print(states.shopLoginModel.message),
                    print(states.shopLoginModel.data.token),
                    showToast(
                        text: states.shopLoginModel.message,
                        states: ToastStates.Sucess),
                    CacheHelper.saveData(
                            key: 'token',
                            value: states.shopLoginModel.data.token)
                        .then((value) {
                      navigateAndFinish(context, ShopLayout());
                    })
                  }
                else
                  {
                    print(states.shopLoginModel.message),
                    showToast(
                        text: states.shopLoginModel.message,
                        states: ToastStates.Error),
                  }
              }
          },
          builder: (context, states) {
            // var logincubit = LoginCubit.get(context);
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            "Login now to Browser our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: 30),
                          defaultTextField(
                            context: context,
                            controller: emailController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'ادخل البريد الالكتروني';
                              } else if (!value.toString().contains('@') ||
                                  !value.toString().contains('.com')) {
                                return 'ex: example@mail.com';
                              } else {
                                return null;
                              }
                            },
                            onchanege: (String value) {
                              print(value);
                            },
                            type: TextInputType.emailAddress,
                            label: "Email Address",
                            icon: Icons.email,
                            isShown: false,
                            istrue: false,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextField(
                              context: context,
                              controller: passwordController,
                              onsubmit: (value) {
                                if (formKey.currentState.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "enter the Password";
                                }
                                return null;
                              },
                              onchanege: (String value) {
                                print(value);
                              },
                              suffixPressed: () {
                                LoginCubit.get(context).changePassword();
                              },
                              type: TextInputType.visiblePassword,
                              label: "Password Address",
                              icon: Icons.lock_outline,
                              isShown: LoginCubit.get(context).shownPassword,
                              istrue: true,
                              suffixicon: LoginCubit.get(context).shownPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                          SizedBox(height: 15),
                          ConditionalBuilder(
                            condition: State is! LoginLoadingStates,
                            builder: (context) => defaultButton(
                              background: Colors.blue,
                              function: () {
                                if (formKey.currentState.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              width: double.infinity,
                              text: "Login",
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Dont Have an account ?"),
                              defaultTextButton(
                                function: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: "RegisterIn",
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
