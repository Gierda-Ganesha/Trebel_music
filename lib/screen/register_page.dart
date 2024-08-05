import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:music/screen/login_page.dart'; // Import halaman Login

/// Halaman Register
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

/// State untuk RegisterPage
class _RegisterPageState extends State<RegisterPage> {
  // Kontroller untuk video background
  late VideoPlayerController _controller;
  // Menyembunyikan atau menampilkan password
  bool _isAgreed = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  // Kunci untuk form validasi
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Menginisialisasi video player
    _controller = VideoPlayerController.asset('assets/video/iklan2.mp4')
      ..initialize().then((_) {
        setState(() {});
        // Mengatur video agar looping dan mute
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
      }).catchError((error) {
        debugPrint("Error initializing video: $error");
      });
  }

  /// Fungsi untuk proses register
  void _register() {
    if (!_isAgreed) {
      // Menampilkan pesan error jika persetujuan tidak dicentang
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed: You must agree to the terms.')),
      );
    } else if (_formKey.currentState!.validate()) {
      // Proses register
    }
  }

  /// Fungsi untuk toggle visibility password
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  /// Fungsi untuk toggle visibility konfirmasi password
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  /// Fungsi untuk validasi email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!value.contains('@')) {
      return 'Use @ for email character';
    }
    return null;
  }

  @override
  void dispose() {
    // Membersihkan video player saat widget dihapus
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menampilkan video jika sudah terinisialisasi
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
                // Form register
                Positioned(
                  bottom: 50, // Ubah nilai ini untuk menggeser konten ke atas
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Register Trebel',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Input username
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Masukan Username',
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
                                filled: true,
                                fillColor: Colors.white24,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 14.0),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username cannot be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            // Input email
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Masukan Email',
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
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
                              obscureText: _obscurePassword,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Masukan Password',
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
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
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white54,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Input konfirmasi password
                            TextFormField(
                              obscureText: _obscureConfirmPassword,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Konfirmasi Password',
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
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
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white54,
                                  ),
                                  onPressed: _toggleConfirmPasswordVisibility,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Konfirmasi Password cannot be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Checkbox persetujuan
                            Row(
                              children: [
                                Checkbox(
                                  value: _isAgreed,
                                  onChanged: (value) {
                                    setState(() {
                                      _isAgreed = value!;
                                    });
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                    'Saya bersedia mengikuti aturan yang berlaku',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Tombol register
                            ElevatedButton(
                              onPressed: _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text('Register',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(height: 20),
                            // Tombol untuk pindah ke halaman login
                            TextButton(
                              onPressed: () {
                                // Navigasi ke halaman LoginPage
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Sudah punya akun? ',
                                  style: TextStyle(color: Colors.white),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' Login',
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
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
