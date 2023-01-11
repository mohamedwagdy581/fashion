abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates
{
  final String error;

  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates
{
  final String error;

  CreateUserErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}



/*Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1?.copyWith(
                            fontSize: 35.0,
                          ),
                        ),

                        //SizedBox between SignUp Text and Login to Start Text
                        SizedBox(
                          height: height * 0.019,
                        ),

                        Text(
                          'Register to start connect with your company',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.033,
                        ),

                        // TextFormField of Name
                        defaultTextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          label: 'Name',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                          prefix: Icons.person,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                        ),

                        //SizedBox between Name and Email Address TextFormField
                        SizedBox(
                          height: height * 0.019,
                        ),

                        // TextFormField of Email Address
                        defaultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                        ),

                        //SizedBox between Email and Phone TextFormField
                        SizedBox(
                          height: height * 0.019,
                        ),

                        // TextFormField of Phone
                        defaultTextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Phone',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Phone';
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                        ),

                        //SizedBox between Phone and Password TextFormField
                        SizedBox(
                          height: height * 0.019,
                        ),

                        // TextFormField of Password
                        defaultTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          textStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color:
                            AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          ),
                          validator: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          secure: RegisterCubit.get(context).isPasswordShown,
                          prefix: Icons.password,
                          prefixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          suffix: RegisterCubit.get(context).suffix,
                          suffixColor: AppCubit.get(context).isDark ? Colors.black : Colors.white,
                          suffixPressed: ()
                          {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                        ),

                        //SizedBox between Password and Login Button
                        SizedBox(
                          height: height * 0.034,
                        ),

                        // Register Button
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) =>
                              defaultButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate())
                                  {
                                    RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      image: '',
                                    );
                                  }
                                },
                                text: 'Register',
                                backgroundColor:
                                AppCubit.get(context).isDark ? Colors.blue : Colors.deepOrange,
                              ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),

                        //SizedBox between Login Button and Don't have an account
                        SizedBox(
                          height: height * 0.019,
                        ),

                        // Row that contain Don't have an account text and Register TextButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have an account?',
                              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color:
                                AppCubit.get(context).isDark ? Colors.black : Colors.white,
                              ),
                            ),
                            defaultTextButton(
                              onPressed: () {
                                navigateAndFinish(
                                  context,
                                  LoginScreen(),
                                );
                              },
                              text: 'Login',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),*/