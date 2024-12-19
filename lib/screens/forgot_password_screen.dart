// import 'package:flutter/material.dart';
// import '../services/auth_services.dart';
// import '../widgets/custom_button.dart';
//
// class ForgotPasswordScreen extends StatelessWidget {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _authService = AuthService();
//
//   ForgotPasswordScreen({super.key});
//
//   void _resetPassword(BuildContext context) async {
//     final email = _emailController.text;
//     final newPassword = _passwordController.text;
//
//     if (email.isNotEmpty && newPassword.isNotEmpty) {
//       await _authService.resetPassword(email, newPassword);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Password reset successfully!')),
//       );
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Forgot Password', style: TextStyle(fontWeight: FontWeight.bold)),
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
//                 'Reset Your Password',
//                 style: TextStyle(
//                   fontSize: 28,
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
//                         labelText: 'New Password',
//                         hintText: 'Enter a new password',
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
//                       text: 'Reset Password',
//                       color: Colors.blue,
//                       onPressed: () => _resetPassword(context),
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             'Back to Login',
//                             style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
//                           ),
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
import '../widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _obscurePassword = true;  // Variable to control password visibility

  void _resetPassword(BuildContext context) async {
    final email = _emailController.text;
    final newPassword = _passwordController.text;

    if (email.isNotEmpty && newPassword.isNotEmpty) {
      await _authService.resetPassword(email, newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset successfully!')),
      );
      Navigator.pop(context);
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
        title: Text('Forgot Password', style: TextStyle(fontWeight: FontWeight.bold)),
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
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 28,
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
                        labelText: 'New Password',
                        hintText: 'Enter a new password',
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
                      text: 'Reset Password',
                      color: Colors.blue,
                      onPressed: () => _resetPassword(context),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Back to Login',
                            style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
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
