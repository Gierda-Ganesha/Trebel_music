import 'package:flutter/material.dart';
import 'package:music/home/home_page.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music/screen/register_page.dart'; // Import halaman register

/// Halaman Login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Kontroller untuk video background
  late VideoPlayerController _controller;
  // Menyembunyikan atau menampilkan password
  bool _isPasswordVisible = false;
  // Kunci untuk form validasi
  final _formKey = GlobalKey<FormState>();

  // Daftar penyedia email yang valid
  final List<String> validEmailProviders = [
    'yahoo.com',
    'hotmail.com',
    'aol.com',
    'mail.com',
    'zoho.com',
    'icloud.com',
    'yandex.com',
    'protonmail.com',
    'tutanota.com',
    'gmail.com'
  ];

  @override
  void initState() {
    super.initState();
    // Menginisialisasi video player
    _controller = VideoPlayerController.asset('assets/video/iklan.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          // Mengatur video agar looping dan mute
          _controller.setLooping(true);
          _controller.setVolume(0.0);
          _controller.play();
        }
      }).catchError((error) {
        debugPrint("Error initializing video: $error");
      });
  }

  // Fungsi untuk validasi email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!value.contains('@')) {
      return 'Use @ for email character';
    } else {
      String domain = value.split('@').last;
      if (!validEmailProviders.contains(domain)) {
        return 'failed Domain not in valid email';
      }
    }
    return null;
  }

  // Fungsi untuk validasi password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  @override
  void dispose() {
    // Membersihkan video player saat widget dihapus
    _controller.dispose();
    super.dispose();
  }

  // Fungsi login
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // Menyimpan status login ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      if (mounted) {
        // Navigasi ke halaman HomePage setelah login berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? Stack(
              children: [
                // Video background
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                // Overlay gradient untuk video background
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(1.0),
                          Colors.black.withOpacity(0.5),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                // Form login
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Login Trebel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Input email
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Masukan Email',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white24,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 14.0),
                            ),
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 16),
                          // Input password
                          TextFormField(
                            obscureText: !_isPasswordVisible,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Masukan Password',
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white24,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 14.0),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                          const SizedBox(height: 16),
                          // Tombol login
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize:
                                  const Size.fromHeight(50), // Lebar tombol
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Login',
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(height: 16),
                          // Tombol login sosial media
                          _buildSocialLoginButton(
                            icon: FontAwesomeIcons.google,
                            text: 'Login menggunakan Google',
                            onPressed: () {},
                          ),
                          const SizedBox(height: 8),
                          _buildSocialLoginButton(
                            icon: FontAwesomeIcons.facebookF,
                            text: 'Login menggunakan Facebook',
                            onPressed: () {},
                          ),
                          const SizedBox(height: 8),
                          _buildSocialLoginButton(
                            icon: FontAwesomeIcons.message,
                            text: 'Login menggunakan SMS',
                            onPressed: () {},
                          ),
                          const SizedBox(height: 16),
                          // Tombol pindah ke halaman register
                          TextButton(
                            onPressed: () {
                              // Pindah ke halaman register
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: 'Belum punya akun? ',
                                style: TextStyle(color: Colors.white),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Register',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  // Fungsi untuk membuat tombol login sosial media
  Widget _buildSocialLoginButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50), // Lebar tombol
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
