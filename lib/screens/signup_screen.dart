import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_flutter/responsive/responsive_layout.dart';
import 'package:instagram_clone_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:instagram_clone_flutter/widgets/text_field_input.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              // SvgPicture.asset(
              //   'assets/ic_instagram.svg',
              //   color: primaryColor,
              //   height: 64,
              // ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), // Label text color
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey, // Hint text color
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 3, 4, 4), // Icon color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          255, 3, 3, 3), // Border color when not in focus
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when in focus
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                controller: _usernameController,
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), // Label text color
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey, // Hint text color
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 3, 4, 4), // Icon color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          255, 3, 3, 3), // Border color when not in focus
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when in focus
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), // Label text color
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey, // Hint text color
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 3, 4, 4), // Icon color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          255, 3, 3, 3), // Border color when not in focus
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when in focus
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                controller: _passwordController,
                obscureText: true, // Set this to true to hide the password
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your bio',
                  labelText: 'Bio',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), // Label text color
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey, // Hint text color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromARGB(
                          255, 3, 3, 3), // Border color when not in focus
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when in focus
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                controller: _bioController,
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                  child: !_isLoading
                      ? InkWell(
                          onTap: () {},
                          child: const Text(
                            'Sign up',
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
