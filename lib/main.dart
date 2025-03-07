import 'dart:math';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // Configuración específica para Web
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCTAs6zOmZSd_3avM17x62qVU_Gat7dKso",
        authDomain: "aplicacion-8afa2.firebaseapp.com",
        projectId: "aplicacion-8afa2",
        storageBucket: "aplicacion-8afa2.appspot.com", // Corregido
        messagingSenderId: "1024396750145",
        appId: "1:1024396750145:web:50f7a262f32f5775fcc5c0",
      ),
    );
  } else {
    // Configuración para Android/iOS
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(MateManiaApp());
}

class MateManiaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MateManía',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 26, fontFamily: 'Comic Sans MS'),
          labelLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7B1FA2),
              Color(0xFFE1BEE7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo animado
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.calculate,
                                  size: 80,
                                  color: Color(0xFF7B1FA2),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 40),
                    // Texto animado
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            '¡Bienvenido a',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            'MateManía!',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Indicador de carga
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Cargando...',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con gradiente y diseño
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF7B1FA2),
                  Color(0xFFE1BEE7),
                ],
              ),
            ),
          ),
          // Patrón de decoración
          Positioned.fill(
            child: CustomPaint(
              painter: BubblePainter(),
            ),
          ),
          // Contenido principal
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    // Logo y título
                    Hero(
                      tag: 'app_logo',
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.calculate,
                          size: 60,
                          color: Color(0xFF7B1FA2),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'MateManía',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    // Formulario de login
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildTextField(
                            Icons.person_outline,
                            "Usuario",
                            false,
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            Icons.lock_outline,
                            "Contraseña",
                            true,
                          ),
                          SizedBox(height: 30),
                          _buildLoginButton(context),
                          SizedBox(height: 20),
                          _buildRegisterButton(context),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // Enlaces adicionales
                    TextButton(
                      onPressed: () {
                        // Implementar recuperación de contraseña
                      },
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, bool isPassword) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(
            icon,
            color: Color(0xFF7B1FA2),
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'MateManía'),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF7B1FA2),
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Text(
          'Iniciar Sesión',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationForm()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Color(0xFF7B1FA2), width: 2),
          ),
          elevation: 0,
        ),
        child: Text(
          'Registrarse',
          style: TextStyle(
            color: Color(0xFF7B1FA2),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

// Clase para crear el patrón de burbujas en el fondo
class BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final random = Random(12345);
    for (var i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 30 + 5;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void addUser() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('usuarios').add({
        'nombre': _nameController.text,
        'fecha_nacimiento': _birthDateController.text,
        'edad': int.tryParse(_ageController.text) ?? 0,
        'escuela': _schoolController.text,
        'correo': _emailController.text,
        'contraseña': _passwordController
            .text, // ⚠️ Considera usar hashing en la contraseña
      }).then((docRef) {
        print("Usuario agregado con ID: ${docRef.id}");
      }).catchError((error) {
        print("Error al agregar usuario: $error");
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _ageController.dispose();
    _schoolController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Usuario')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                  controller: _nameController,
                  icon: Icons.person,
                  label: "Nombre"),
              _buildDatePickerField(),
              _buildTextField(
                  controller: _ageController,
                  icon: Icons.cake,
                  label: "Edad",
                  keyboardType: TextInputType.number),
              _buildTextField(
                  controller: _schoolController,
                  icon: Icons.school,
                  label: "Escuela"),
              _buildTextField(
                  controller: _emailController,
                  icon: Icons.email,
                  label: "Correo electrónico",
                  keyboardType: TextInputType.emailAddress),
              _buildTextField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  label: "Contraseña",
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )),
              SizedBox(height: 20),
              ElevatedButton(onPressed: addUser, child: Text('Registrar')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField() {
    return _buildTextField(
      controller: _birthDateController,
      icon: Icons.calendar_today,
      label: "Fecha de nacimiento",
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            _birthDateController.text =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          });
        }
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool readOnly = false,
    Widget? suffixIcon,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa $label';
          }
          return null;
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _LevelsPage();
      case 1:
        return _AchievementsPage();
      case 2:
        return _ProfilePage();
      default:
        return _LevelsPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF7B1FA2),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white24,
              ),
              child: Icon(Icons.calculate, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'Comic Sans MS',
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings, size: 28),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: MateManiaDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: _buildMainContent(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.book, size: 32),
              activeIcon: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.book, size: 32),
              ),
              label: 'Niveles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events, size: 32),
              activeIcon: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.emoji_events, size: 32),
              ),
              label: 'Logros',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 32),
              activeIcon: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, size: 32),
              ),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF7B1FA2),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: _onItemTapped,
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrainingPage()),
                );
              },
              label: Text('Entrenamiento'),
              icon: Icon(Icons.fitness_center),
              backgroundColor: Color(0xFF7B1FA2),
            )
          : null,
    );
  }
}

class _LevelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "¡Bienvenido!",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Elige un nivel para comenzar",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 30),
          _buildLevelCard(
            context,
            "Nivel Fácil",
            Icons.star_border,
            Colors.green,
            EasyLevelPage(),
            "Perfecto para comenzar",
          ),
          _buildLevelCard(
            context,
            "Nivel Intermedio",
            Icons.star_half,
            Colors.orange,
            IntermediateLevelPage(),
            "Aumenta el desafío",
          ),
          _buildLevelCard(
            context,
            "Nivel Difícil",
            Icons.star,
            Colors.red,
            HardLevelPage(),
            "Pon a prueba tus habilidades",
          ),
          _buildLevelCard(
            context,
            "Nivel por Tiempo",
            Icons.timer,
            Colors.blue,
            TimedLevelPage(),
            "¡Contra el reloj!",
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, String title, IconData icon,
      Color color, Widget page, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 30),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AchievementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildAchievementSection(
              "Nivel Fácil",
              Icons.star_border,
              Colors.green,
              [
                _buildProgress("Ejercicios Completados", 45, 50),
                _buildProgress("Respuestas Correctas", 40, 50),
                _buildProgress("Respuestas Incorrectas", 80, 100),
              ],
            ),
            SizedBox(height: 20),
            _buildAchievementSection(
              "Nivel Intermedio",
              Icons.star_half,
              Colors.orange,
              [
                _buildProgress("Ejercicios Completados", 30, 50),
                _buildProgress("Respuestas Correctas", 25, 50),
                _buildProgress("Respuestas Incorrectas", 70, 100),
              ],
            ),
            SizedBox(height: 20),
            _buildAchievementSection(
              "Nivel Difícil",
              Icons.star,
              Colors.red,
              [
                _buildProgress("Ejercicios Completados", 15, 50),
                _buildProgress("Respuestas Correctas", 10, 50),
                _buildProgress("Respuestas Incorrectas", 60, 100),
              ],
            ),
            SizedBox(height: 20),
            _buildAchievementSection(
              "Nivel por Tiempo",
              Icons.timer,
              Colors.blue,
              [
                _buildProgress("Ejercicios Completados", 20, 50),
                _buildProgress("Mejor Tiempo", 45, 60),
                _buildProgress("Respuestas Incorrectas", 75, 100),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Tus Logros",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple[800],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "¡Sigue practicando para mejorar tus habilidades!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementSection(
      String title, IconData icon, Color color, List<Widget> progressBars) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 30),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Divider(color: color.withOpacity(0.3)),
          ...progressBars,
        ],
      ),
    );
  }

  Widget _buildProgress(String label, int current, int total) {
    final percentage = (current / total * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            Text(
              "$current/$total",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple[800],
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            FractionallySizedBox(
              widthFactor: current / total,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple[300]!, Colors.purple[800]!],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            // Sección de foto de perfil
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.purple[300],
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.purple[800],
                    radius: 20,
                    child: IconButton(
                      icon:
                          Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      onPressed: () {
                        // Lógica para cambiar la foto
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Información del usuario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildInfoCard(
                    title: "Información Personal",
                    children: [
                      _buildInfoRow(Icons.person, "Nombre", "Yunuet Castillo"),
                      _buildInfoRow(Icons.cake, "Edad", "12 años"),
                      _buildInfoRow(
                          Icons.school, "Escuela", "Primaria Emiliano Zapata"),
                      _buildInfoRow(Icons.email, "Email", "yunuet@gmail.com"),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildInfoCard(
                    title: "Estadísticas",
                    children: [
                      _buildProgressBar("Nivel", 0.7, "Avanzado"),
                      SizedBox(height: 15),
                      _buildProgressBar("Ejercicios Completados", 0.85, "85%"),
                      SizedBox(height: 15),
                      _buildProgressBar("Ejercicios Incorrectos", 0.92, "92%"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple[800],
            ),
          ),
          Divider(color: Colors.purple[200]),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple[300], size: 24),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(String label, double value, String progressText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              widthFactor: value,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple[300]!, Colors.purple[800]!],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          progressText,
          style: TextStyle(
            color: Colors.purple[800],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

//  nuevas pantallas
class TrainingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar personalizado
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "Entrenamiento",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              // Descripción
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  "Selecciona una operación para practicar",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Contenedor principal con fondo semi-transparente
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOperationCard(
                        context,
                        title: "Sumas",
                        description: "Practica operaciones básicas de suma",
                        icon: Icons.add_circle_outline,
                        color: Color(0xFF4CAF50),
                        operation: '+',
                      ),
                      _buildOperationCard(
                        context,
                        title: "Restas",
                        description: "Mejora tus habilidades de resta",
                        icon: Icons.remove_circle_outline,
                        color: Color(0xFFFF9800),
                        operation: '-',
                      ),
                      _buildOperationCard(
                        context,
                        title: "Multiplicación",
                        description: "Practica las tablas de multiplicar",
                        icon: Icons.close,
                        color: Color(0xFFE91E63),
                        operation: '*',
                      ),
                      _buildOperationCard(
                        context,
                        title: "División",
                        description: "Aprende a dividir paso a paso",
                        icon: Icons.horizontal_rule,
                        color: Color(0xFF2196F3),
                        operation: '/',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOperationCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String operation,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OperationPage(operation: operation),
            ),
          ),
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.9),
                  color.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icono con fondo de cristal
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(width: 20),
                // Texto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                // Flecha con fondo de cristal
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OperationPage extends StatefulWidget {
  final String operation;
  OperationPage({required this.operation});

  @override
  _OperationPageState createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage>
    with SingleTickerProviderStateMixin {
  late int num1;
  late int num2;
  late int correctAnswer;
  late List<int> options;
  int? selectedAnswer;
  int attemptsLeft = 2;
  bool showFeedback = false;
  bool isCorrect = false;
  int correctStreak = 0;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(_controller);
    generateNewProblem();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void generateNewProblem() {
    Random random = Random();
    if (widget.operation == '/') {
      num2 = random.nextInt(10) + 1;
      num1 = num2 * (random.nextInt(10) + 1);
      correctAnswer = num1 ~/ num2;
    } else {
      num1 = random.nextInt(20) + 1;
      num2 = random.nextInt(20) + 1;
      switch (widget.operation) {
        case '+':
          correctAnswer = num1 + num2;
          break;
        case '-':
          if (num2 > num1) {
            int temp = num1;
            num1 = num2;
            num2 = temp;
          }
          correctAnswer = num1 - num2;
          break;
        case '*':
          correctAnswer = num1 * num2;
          break;
        default:
          correctAnswer = 0;
      }
    }

    options = [correctAnswer];
    while (options.length < 4) {
      int option = correctAnswer + random.nextInt(11) - 5;
      if (!options.contains(option) && option >= 0) {
        options.add(option);
      }
    }
    options.shuffle();
    selectedAnswer = null;
    showFeedback = false;
  }

  void checkAnswer() {
    if (selectedAnswer == null) return;

    setState(() {
      isCorrect = selectedAnswer == correctAnswer;
      showFeedback = true;

      if (isCorrect) {
        correctStreak++;
      } else {
        attemptsLeft--;
        correctStreak = 0;
      }

      if (attemptsLeft == 0 || isCorrect) {
        Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              if (attemptsLeft == 0) attemptsLeft = 2;
              generateNewProblem();
            });
          }
        });
      }
    });

    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    String operationTitle = '';
    Color primaryColor;
    Color secondaryColor;
    IconData operationIcon;

    switch (widget.operation) {
      case '+':
        operationTitle = 'Práctica de Sumas';
        primaryColor = Color(0xFF2E7D32); // Verde oscuro
        secondaryColor = Color(0xFF81C784); // Verde claro
        operationIcon = Icons.add_circle_outline;
        break;
      case '-':
        operationTitle = 'Práctica de Restas';
        primaryColor = Color(0xFFE65100); // Naranja oscuro
        secondaryColor = Color(0xFFFFB74D); // Naranja claro
        operationIcon = Icons.remove_circle_outline;
        break;
      case '*':
        operationTitle = 'Práctica de Multiplicación';
        primaryColor = Color(0xFFC2185B); // Rosa oscuro
        secondaryColor = Color(0xFFF06292); // Rosa claro
        operationIcon = Icons.close;
        break;
      case '/':
        operationTitle = 'Práctica de División';
        primaryColor = Color(0xFF1565C0); // Azul oscuro
        secondaryColor = Color(0xFF64B5F6); // Azul claro
        operationIcon = Icons.horizontal_rule;
        break;
      default:
        operationTitle = 'Práctica';
        primaryColor = Color(0xFF7B1FA2); // Morado oscuro
        secondaryColor = Color(0xFFBA68C8); // Morado claro
        operationIcon = Icons.calculate;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar personalizado
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Icon(operationIcon, color: Colors.white, size: 30),
                    SizedBox(width: 8),
                    Text(
                      operationTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.local_fire_department,
                              color: Colors.amber),
                          SizedBox(width: 4),
                          Text(
                            '$correctStreak',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Tarjeta de operación
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.2),
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                          border: Border.all(
                            color: primaryColor.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.timer_outlined,
                                      color: primaryColor, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    "Intentos restantes: $attemptsLeft",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildNumberContainer(
                                    num1.toString(), primaryColor),
                                SizedBox(width: 12),
                                _buildOperationSymbol(
                                    widget.operation, primaryColor),
                                SizedBox(width: 12),
                                _buildNumberContainer(
                                    num2.toString(), primaryColor),
                                SizedBox(width: 12),
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "=",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        primaryColor.withOpacity(0.2),
                                        primaryColor.withOpacity(0.1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: primaryColor.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "?",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: options
                                    .map((option) => Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: selectedAnswer == option
                                                ? primaryColor.withOpacity(0.1)
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: selectedAnswer == option
                                                  ? primaryColor
                                                  : Colors.grey.shade300,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: RadioListTile<int>(
                                            value: option,
                                            groupValue: selectedAnswer,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedAnswer = value;
                                              });
                                            },
                                            title: Text(
                                              option.toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: selectedAnswer == option
                                                    ? primaryColor
                                                    : Colors.black87,
                                                fontWeight:
                                                    selectedAnswer == option
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                              ),
                                            ),
                                            activeColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: selectedAnswer != null
                                  ? () {
                                      checkAnswer();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle_outline, size: 24),
                                  SizedBox(width: 10),
                                  Text(
                                    'Comprobar',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (showFeedback)
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: isCorrect
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: isCorrect
                                        ? Colors.green.withOpacity(0.3)
                                        : Colors.red.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isCorrect
                                          ? Icons.check_circle
                                          : Icons.error_outline,
                                      color:
                                          isCorrect ? Colors.green : Colors.red,
                                      size: 24,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      isCorrect
                                          ? '¡Correcto! ¡Muy bien!'
                                          : 'Incorrecto. Inténtalo de nuevo.',
                                      style: TextStyle(
                                        color: isCorrect
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
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
        ),
      ),
    );
  }

  Widget _buildNumberContainer(String number, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildOperationSymbol(String operation, Color color) {
    String symbol = operation;
    switch (operation) {
      case '*':
        symbol = '×';
        break;
      case '/':
        symbol = '÷';
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HardLevelPage extends StatefulWidget {
  @override
  _HardLevelPageState createState() => _HardLevelPageState();
}

class _HardLevelPageState extends State<HardLevelPage> {
  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder return, actual implementation needed
  }
}

class EasyLevelPage extends StatefulWidget {
  @override
  _EasyLevelPageState createState() => _EasyLevelPageState();
}

class _EasyLevelPageState extends State<EasyLevelPage> {
  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder return, actual implementation needed
  }
}

class IntermediateLevelPage extends StatefulWidget {
  @override
  _IntermediateLevelPageState createState() => _IntermediateLevelPageState();
}

class _IntermediateLevelPageState extends State<IntermediateLevelPage> {
  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder return, actual implementation needed
  }
}

class TimedLevelPage extends StatefulWidget {
  @override
  _TimedLevelPageState createState() => _TimedLevelPageState();
}

class _TimedLevelPageState extends State<TimedLevelPage> {
  // Implementation of the TimedLevelPage state
  @override
  Widget build(BuildContext context) {
    // Implementation of the build method
    return Container(); // Placeholder return, actual implementation needed
  }
}

class MateManiaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFF7B1FA2),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'MateManía',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              title: 'Configuración',
              onTap: () {
                // Implementar navegación a configuración
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.help_outline,
              title: 'Ayuda',
              onTap: () {
                // Implementar navegación a ayuda
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.exit_to_app,
              title: 'Cerrar Sesión',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.white.withOpacity(0.1),
    );
  }
}
