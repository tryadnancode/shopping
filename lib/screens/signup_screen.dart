// import 'package:flutter/material.dart';
// import '../services/auth_services.dart';
// import 'login_screen.dart';
// import '../widgets/custom_button.dart';
//
// class SignupScreen extends StatelessWidget {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _authService = AuthService();
//
//   SignupScreen({super.key});
//
//   void _signup(BuildContext context) async {
//     final email = _emailController.text;
//     final password = _passwordController.text;
//
//     if (email.isNotEmpty && password.isNotEmpty) {
//       await _authService.signup(email, password);
//
//       // Show a Snackbar for successful signup
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Signup successful! Please log in.'),
//           backgroundColor: Colors.green,
//         ),
//       );
//
//       // Navigate to the Login screen after a successful signup
//       Future.delayed(Duration(seconds: 2), () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       });
//     } else {
//       // If the fields are empty, show an error Snackbar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please enter both email and password.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.blueAccent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 40),
//               Text(
//                 'Create Account',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               SizedBox(height: 30),
//               Form(
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         hintText: 'Enter your email',
//                         prefixIcon: Icon(Icons.email),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                       ),
//                       validator: (value) => value!.isEmpty ? 'Enter email' : null,
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         hintText: 'Enter your password',
//                         prefixIcon: Icon(Icons.lock),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                       ),
//                       obscureText: true,
//                       validator: (value) => value!.isEmpty ? 'Enter password' : null,
//                     ),
//                     SizedBox(height: 30),
//                     CustomButton(
//                       text: 'Sign Up',
//                       color: Colors.blue,
//                       onPressed: () => _signup(context),
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Already have an account? ',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => LoginScreen()),
//                             );
//                           },
//                           child: Text(
//                             'Log In',
//                             style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Or sign up with',
//                       style: TextStyle(fontSize: 16, color: Colors.black54),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.facebook, color: Colors.blue, size: 30),
//                           onPressed: () {},
//                         ),
//                        IconButton(
//                           icon: Icon(Icons.apple, color: Colors.black, size: 30),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import 'login_screen.dart';
import '../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _obscurePassword = true;  // Variable to control password visibility

  void _signup(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      await _authService.signup(email, password);

      // Show a Snackbar for successful signup
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup successful! Please log in.'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to the Login screen after a successful signup
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    } else {
      // If the fields are empty, show an error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 30),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter email' : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword, // Use the state variable to control visibility
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: _togglePasswordVisibility, // Toggle visibility
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter password' : null,
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      text: 'Sign Up',
                      color: Colors.blue,
                      onPressed: () => _signup(context),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text(
                            'Log In',
                            style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Or sign up with',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.facebook, color: Colors.blue, size: 30),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.apple, color: Colors.black, size: 30),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
