import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';
import '../login/login_screen.dart';
import 'register_cubit/register_cubit.dart';
import 'register_cubit/register_states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          // Listener in create user success state if success navigate and finish to Home Layout
          if(state is CreateUserSuccessState)
          {
            navigateAndFinish(context, LoginScreen());
          }
        },
        builder: (context, state)
        {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.height;

          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/back.jpg',
                  width: height,
                  height: width,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 75.0,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            'assets/images/lg.png',
                            fit: BoxFit.cover,
                          ),
                        ),

                        // ******************  Email and Password TextField  ***************
                        defaultTextFormField(
                          controller: _nameController,
                          label: 'Enter your Name',
                          keyboardType: TextInputType.text,
                          prefix: Icons.person,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name must not be Empty!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        defaultTextFormField(
                          controller: _emailController,
                          label: 'Enter your Email',
                          keyboardType: TextInputType.text,
                          prefix: Icons.alternate_email_outlined,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email must not be Empty!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          controller: _phoneController,
                          label: 'Enter your Phone',
                          keyboardType: TextInputType.phone,
                          prefix: Icons.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be Empty!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          controller: _passwordController,
                          label: 'Enter your Password',
                          keyboardType: TextInputType.visiblePassword,
                          secure: RegisterCubit.get(context).isPasswordShown,
                          prefix: Icons.password,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          suffixPressed: ()
                          {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password must not be Empty!';
                            }
                            return null;
                          },
                        ),
                        // ****************   Forget Password  ******************
                        Container(
                          alignment: Alignment.centerLeft,
                          child: defaultTextButton(
                            onPressed: () {},
                            text: 'Forget Password?',
                          ),
                        ),
                        // ***********************   Register Button  ***********************
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 110.0),
                                child: defaultButton(
                                  onPressed: () {
                                    if(_formKey.currentState!.validate())
                                    {
                                      RegisterCubit.get(context).userRegister(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        phone: _phoneController.text,
                                        image: '',
                                      );
                                    }
                                  },
                                  text: 'Register >',
                                  backgroundColor: Colors.red,
                                ),
                              ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Have an account?   ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  navigateAndFinish(context, LoginScreen());
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


