import 'dart:math';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MateManiaApp());

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
      body: Stack(
        children: [
          // Fondo con gradiente
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
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
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Botón de regreso
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Título
                    Text(
                      'Crear Cuenta',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 40),
                    // Formulario
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              controller: _nameController,
                              icon: Icons.person_outline,
                              label: "Nombre completo",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu nombre';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            _buildDatePickerField(),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: _ageController,
                              icon: Icons.cake_outlined,
                              label: "Edad",
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu edad';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: _schoolController,
                              icon: Icons.school_outlined,
                              label: "Escuela",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu escuela';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: _emailController,
                              icon: Icons.email_outlined,
                              label: "Correo electrónico",
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || !value.contains('@')) {
                                  return 'Ingresa un correo válido';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: _passwordController,
                              icon: Icons.lock_outline,
                              label: "Contraseña",
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xFF7B1FA2),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return 'La contraseña debe tener al menos 6 caracteres';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Implementar lógica de registro
                                    print('Nombre: ${_nameController.text}');
                                    print(
                                        'Fecha: ${_birthDateController.text}');
                                    print('Edad: ${_ageController.text}');
                                    print('Escuela: ${_schoolController.text}');
                                    print('Email: ${_emailController.text}');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Procesando registro...'),
                                        backgroundColor: Color(0xFF7B1FA2),
                                      ),
                                    );
                                  }
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
                                  'Registrarse',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField() {
    return _buildTextField(
      controller: _birthDateController,
      icon: Icons.calendar_today_outlined,
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Color(0xFF7B1FA2)),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      validator: validator,
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
                _buildProgress("Respuestas incorrectas", 75, 100),
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
    return Scaffold(
      body: Container(
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
                        icon: Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
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
                        _buildInfoRow(
                            Icons.person, "Nombre", "Yunuet Castillo"),
                        _buildInfoRow(Icons.cake, "Edad", "12 años"),
                        _buildInfoRow(Icons.school, "Escuela",
                            "Primaria Emiliano Zapata"),
                        _buildInfoRow(Icons.email, "Email", "yunuet@gmail.com"),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildInfoCard(
                      title: "Estadísticas",
                      children: [
                        _buildProgressBar("Nivel", 0.7, "Avanzado"),
                        SizedBox(height: 15),
                        _buildProgressBar(
                            "Ejercicios Completados", 0.85, "85%"),
                        SizedBox(height: 15),
                        _buildProgressBar("Precisión", 0.92, "92%"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
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
      appBar: AppBar(
        title: Text("Entrenamiento"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade200, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Modo de Entrenamiento",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                "Selecciona una operación para practicar:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  _buildTrainingButton(
                    context,
                    title: "Suma",
                    icon: Icons.add,
                    color: Colors.greenAccent,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OperationPage(operation: '+'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTrainingButton(
                    context,
                    title: "Resta",
                    icon: Icons.remove,
                    color: Colors.orangeAccent,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OperationPage(operation: '-'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTrainingButton(
                    context,
                    title: "Multiplicación",
                    icon: Icons.close,
                    color: Colors.pinkAccent,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OperationPage(operation: '*'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTrainingButton(
                    context,
                    title: "División",
                    icon: Icons.horizontal_rule,
                    color: Colors.blueAccent,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OperationPage(operation: '/'),
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

  Widget _buildTrainingButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
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

class _OperationPageState extends State<OperationPage> {
  late int num1;
  late int num2;
  late int correctAnswer;
  late List<int> options;
  String? selectedOption;
  int attemptsLeft = 2; // Máximo dos intentos

  @override
  void initState() {
    super.initState();
    generateExercise();
  }

  void generateExercise() {
    final random = Random();
    num1 = random.nextInt(10) + 1;
    num2 = random.nextInt(10) + 1;

    switch (widget.operation) {
      case '+':
        correctAnswer = num1 + num2;
        break;
      case '-':
        correctAnswer = num1 - num2;
        break;
      case '*':
        correctAnswer = num1 * num2;
        break;
      case '/':
        num1 = num1 * num2;
        correctAnswer = num1 ~/ num2;
        break;
      default:
        correctAnswer = 0;
    }

    options = [
      correctAnswer,
      correctAnswer + random.nextInt(5) + 1,
      correctAnswer - random.nextInt(5) - 1,
      correctAnswer + random.nextInt(10) - 5
    ];

    options.shuffle();
    selectedOption = null;
    attemptsLeft = 2; // Reiniciar intentos en una nueva pregunta

    setState(() {});
  }

  void checkAnswer() {
    if (selectedOption == correctAnswer.toString()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("¡Excelente, Respuesta correcta!"),
          backgroundColor: Colors.green,
        ),
      );
      generateExercise();
    } else {
      attemptsLeft--;

      if (attemptsLeft > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Respuesta incorrecta, Intentalo de nuevo. Te quedan $attemptsLeft intentos."),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "¡Se acabaron los intentos! La respuesta correcta era $correctAnswer."),
            backgroundColor: Colors.red,
          ),
        );
        Future.delayed(Duration(seconds: 2), generateExercise);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Practicando ${widget.operation}"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$num1 ${widget.operation} $num2 = ?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: options.map((option) {
                return RadioListTile<String>(
                  title: Text(option.toString()),
                  value: option.toString(),
                  groupValue: selectedOption,
                  onChanged: attemptsLeft > 0
                      ? (value) {
                          setState(() {
                            selectedOption = value;
                          });
                        }
                      : null, // Bloquear selección si no hay intentos
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (selectedOption != null && attemptsLeft > 0)
                  ? checkAnswer
                  : null,
              child: Text("Confirmar"),
            ),
          ],
        ),
      ),
    );
  }
}

class EasyLevelPage extends StatefulWidget {
  @override
  _EasyLevelPageState createState() => _EasyLevelPageState();
}

class _EasyLevelPageState extends State<EasyLevelPage>
    with SingleTickerProviderStateMixin {
  int num1 = 0;
  int num2 = 0;
  int correctAnswer = 0;
  String operation = "";
  String userAnswer = "";
  int questionsAsked = 0;
  int totalQuestions = 0;
  int correctCount = 0;
  int incorrectCount = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askQuestionCount();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void askQuestionCount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF7B1FA2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "¿Cuántas operaciones?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.2),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionButton(
                  5, "5 ejercicios", Icons.looks_one, Colors.green),
              SizedBox(height: 10),
              _buildOptionButton(
                  10, "10 ejercicios", Icons.looks_two, Colors.orange),
              SizedBox(height: 10),
              _buildOptionButton(
                  15, "15 ejercicios", Icons.looks_3, Colors.purple),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(
      int count, String text, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => setQuestionCount(count),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
      ),
    );
  }

  void setQuestionCount(int count) {
    setState(() {
      totalQuestions = count;
      correctCount = 0;
      incorrectCount = 0;
      questionsAsked = 0;
      userAnswer = "";
    });
    Navigator.pop(context);
    generateExercise();
  }

  void generateExercise() {
    final random = Random();
    setState(() {
      num1 = random.nextInt(10) + 1;
      num2 = random.nextInt(10) + 1;
      final operations = ['+', '-', '*'];
      operation = operations[random.nextInt(operations.length)];

      switch (operation) {
        case '+':
          correctAnswer = num1 + num2;
          break;
        case '-':
          correctAnswer = num1 - num2;
          break;
        case '*':
          correctAnswer = num1 * num2;
          break;
      }
    });
  }

  void checkAnswer() {
    if (userAnswer.isEmpty) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    setState(() {
      if (int.tryParse(userAnswer) == correctAnswer) {
        correctCount++;
      } else {
        incorrectCount++;
      }
      questionsAsked++;
      userAnswer = "";
    });

    if (questionsAsked < totalQuestions) {
      generateExercise();
    } else {
      showResults();
    }
  }

  void showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double accuracy = (correctCount / totalQuestions) * 100;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "¡Ejercicio Completado!",
            style: TextStyle(
              color: Color(0xFF7B1FA2),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildResultItem(
                "Respuestas Correctas",
                correctCount,
                Icons.check_circle,
                Colors.green,
              ),
              SizedBox(height: 10),
              _buildResultItem(
                "Respuestas Incorrectas",
                incorrectCount,
                Icons.cancel,
                Colors.red,
              ),
              SizedBox(height: 10),
              _buildResultItem(
                "Precisión",
                accuracy.round(),
                Icons.percent,
                Colors.blue,
                isPercentage: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                "Volver a intentar",
                style: TextStyle(
                  color: Color(0xFF7B1FA2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                askQuestionCount();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultItem(String label, int value, IconData icon, Color color,
      {bool isPercentage = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            isPercentage ? "$value%" : value.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel Fácil"),
        backgroundColor: Color(0xFF7B1FA2),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Indicador de progreso
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progreso",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$questionsAsked/$totalQuestions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: totalQuestions > 0
                          ? questionsAsked / totalQuestions
                          : 0,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: child,
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(30),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "$num1 $operation $num2 = ?",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7B1FA2),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  width: 150,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF7B1FA2),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "?",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 30,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        userAnswer = value;
                                      });
                                    },
                                    onSubmitted: (value) {
                                      if (value.isNotEmpty) {
                                        checkAnswer();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              onPressed:
                                  userAnswer.isNotEmpty ? checkAnswer : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF7B1FA2),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                "Comprobar",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
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
          ),
        ),
      ),
    );
  }
}

class IntermediateLevelPage extends StatefulWidget {
  @override
  _IntermediateLevelPageState createState() => _IntermediateLevelPageState();
}

class _IntermediateLevelPageState extends State<IntermediateLevelPage>
    with SingleTickerProviderStateMixin {
  int num1 = 0;
  int num2 = 0;
  int correctAnswer = 0;
  String operation = "";
  String userAnswer = "";
  int questionsAsked = 0;
  int totalQuestions = 0;
  int correctCount = 0;
  int incorrectCount = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askQuestionCount();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void askQuestionCount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF7B1FA2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "¿Cuántas operaciones?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.2),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionButton(
                  5, "5 ejercicios", Icons.looks_one, Colors.green),
              SizedBox(height: 10),
              _buildOptionButton(
                  10, "10 ejercicios", Icons.looks_two, Colors.orange),
              SizedBox(height: 10),
              _buildOptionButton(
                  15, "15 ejercicios", Icons.looks_3, Colors.purple),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(
      int count, String text, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => setQuestionCount(count),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
      ),
    );
  }

  void setQuestionCount(int count) {
    setState(() {
      totalQuestions = count;
      correctCount = 0;
      incorrectCount = 0;
      questionsAsked = 0;
      userAnswer = "";
    });
    Navigator.pop(context);
    generateExercise();
  }

  void generateExercise() {
    final random = Random();
    setState(() {
      num1 = random.nextInt(50) + 50; // Números entre 50 y 99
      num2 = random.nextInt(50) + 50;
      final operations = ['+', '-', '*', '/'];
      operation = operations[random.nextInt(operations.length)];

      switch (operation) {
        case '+':
          correctAnswer = num1 + num2;
          break;
        case '-':
          correctAnswer = num1 - num2;
          break;
        case '*':
          correctAnswer = num1 * num2;
          break;
        case '/':
          // Asegurar división exacta
          num1 = num1 * num2;
          correctAnswer = num1 ~/ num2;
          break;
      }
    });
  }

  void checkAnswer() {
    if (userAnswer.isEmpty) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    setState(() {
      if (int.tryParse(userAnswer) == correctAnswer) {
        correctCount++;
      } else {
        incorrectCount++;
      }
      questionsAsked++;
      userAnswer = "";
    });

    if (questionsAsked < totalQuestions) {
      generateExercise();
    } else {
      showResults();
    }
  }

  void showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double accuracy = (correctCount / totalQuestions) * 100;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "¡Ejercicio Completado!",
            style: TextStyle(
              color: Color(0xFF7B1FA2),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildResultItem(
                "Respuestas Correctas",
                correctCount,
                Icons.check_circle,
                Colors.green,
              ),
              SizedBox(height: 10),
              _buildResultItem(
                "Respuestas Incorrectas",
                incorrectCount,
                Icons.cancel,
                Colors.red,
              ),
              SizedBox(height: 10),
              _buildResultItem(
                "Precisión",
                accuracy.round(),
                Icons.percent,
                Colors.blue,
                isPercentage: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                "Volver a intentar",
                style: TextStyle(
                  color: Color(0xFF7B1FA2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                askQuestionCount();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultItem(String label, int value, IconData icon, Color color,
      {bool isPercentage = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            isPercentage ? "$value%" : value.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel Intermedio"),
        backgroundColor: Color(0xFF7B1FA2),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Indicador de progreso
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progreso",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$questionsAsked/$totalQuestions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: totalQuestions > 0
                          ? questionsAsked / totalQuestions
                          : 0,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: child,
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(30),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "$num1 $operation $num2 = ?",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7B1FA2),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  width: 150,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF7B1FA2),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "?",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 30,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        userAnswer = value;
                                      });
                                    },
                                    onSubmitted: (value) {
                                      if (value.isNotEmpty) {
                                        checkAnswer();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              onPressed:
                                  userAnswer.isNotEmpty ? checkAnswer : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF7B1FA2),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                "Comprobar",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
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
  int num1 = 0;
  int num2 = 0;
  double correctAnswer = 0.0;
  String operation = "";
  String userAnswer = "";
  int questionsAsked = 0;
  int totalQuestions = 0;
  int correctCount = 0;
  int incorrectCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askQuestionCount();
    });
  }

  void setQuestionCount(int count) {
    setState(() {
      totalQuestions = count;
      correctCount = 0;
      incorrectCount = 0;
      questionsAsked = 0;
      userAnswer = "";
    });
    Navigator.pop(context);
    generateExercise();
  }

  void generateExercise() {
    final random = Random();
    setState(() {
      num1 = random.nextInt(90) + 10; // Números entre 10 y 99
      num2 = random.nextInt(90) + 10;

      List<String> operations = ['+', '-', '*', '/'];
      operation = operations[random.nextInt(operations.length)];

      switch (operation) {
        case '+':
          correctAnswer = (num1 + num2).toDouble();
          break;
        case '-':
          correctAnswer = (num1 - num2).toDouble();
          break;
        case '*':
          correctAnswer = (num1 * num2).toDouble();
          break;
        case '/':
          // Asegurar división exacta
          num1 = (num1 * num2);
          correctAnswer = num1 / num2;
          break;
      }
    });
  }

  void checkAnswer() {
    if (userAnswer.isEmpty) return;

    double parsedAnswer = double.tryParse(userAnswer) ?? 0.0;
    if (parsedAnswer == correctAnswer) {
      correctCount++;
    } else {
      incorrectCount++;
    }

    setState(() {
      questionsAsked++;
      userAnswer = "";
    });

    if (questionsAsked >= totalQuestions) {
      showResults();
    } else {
      generateExercise();
    }
  }

  void showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double accuracy = (correctCount / totalQuestions) * 100;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "¡Ejercicio Completado!",
            style: TextStyle(
              color: Color(0xFF7B1FA2),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildResultItem(
                "Respuestas Correctas",
                correctCount,
                Icons.check_circle,
                Colors.green,
              ),
              SizedBox(height: 10),
              _buildResultItem(
                "Respuestas Incorrectas",
                incorrectCount,
                Icons.cancel,
                Colors.red,
              ),
              SizedBox(height: 10),
              _buildResultItem(
                "Precisión",
                accuracy.round(),
                Icons.percent,
                Colors.blue,
                isPercentage: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                "Volver a intentar",
                style: TextStyle(
                  color: Color(0xFF7B1FA2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                askQuestionCount();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultItem(String label, int value, IconData icon, Color color,
      {bool isPercentage = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            isPercentage ? "$value%" : value.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel Difícil"),
        backgroundColor: Color(0xFF7B1FA2),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Indicador de progreso
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Progreso",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$questionsAsked/$totalQuestions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: totalQuestions > 0
                          ? questionsAsked / totalQuestions
                          : 0,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(30),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "$num1 $operation $num2 = ?",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF7B1FA2),
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                width: 150,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7B1FA2),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "?",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 30,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      userAnswer = value;
                                    });
                                  },
                                  onSubmitted: (value) {
                                    if (value.isNotEmpty) {
                                      checkAnswer();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed:
                                userAnswer.isNotEmpty ? checkAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF7B1FA2),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              "Comprobar",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
        ),
      ),
    );
  }

  void askQuestionCount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF7B1FA2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "¿Cuántas operaciones?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.2),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionButton(
                  5, "5 ejercicios", Icons.looks_one, Colors.green),
              SizedBox(height: 10),
              _buildOptionButton(
                  10, "10 ejercicios", Icons.looks_two, Colors.orange),
              SizedBox(height: 10),
              _buildOptionButton(
                  15, "15 ejercicios", Icons.looks_3, Colors.purple),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(
      int count, String text, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () => setQuestionCount(count),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}

class TimedLevelPage extends StatefulWidget {
  @override
  _TimedLevelPageState createState() => _TimedLevelPageState();
}

class _TimedLevelPageState extends State<TimedLevelPage> {
  late int num1;
  late int num2;
  late double correctAnswer;
  String operation = "";
  String userAnswer = "";
  int questionsAsked = 0;
  final int totalQuestions = 20; // Fijo en 20 operaciones
  int correctCount = 0;
  int incorrectCount = 0;
  int timeLeft = 30; // 30 segundos
  late Timer timer;
  bool isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    num1 = 0;
    num2 = 0;
    correctAnswer = 0.0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showStartDialog();
    });
  }

  @override
  void dispose() {
    if (isTimerRunning) {
      timer.cancel();
    }
    super.dispose();
  }

  void showStartDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "¡Modo Contra Reloj!",
            style: TextStyle(
              color: Color(0xFF7B1FA2),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timer,
                size: 60,
                color: Color(0xFF7B1FA2),
              ),
              SizedBox(height: 20),
              Text(
                "Tienes 30 segundos para resolver\n20 operaciones matemáticas",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "¿Estás listo?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1FA2),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("¡Comenzar!"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7B1FA2),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                startGame();
              },
            ),
          ],
        );
      },
    );
  }

  void startGame() {
    setState(() {
      timeLeft = 30;
      questionsAsked = 0;
      correctCount = 0;
      incorrectCount = 0;
      isTimerRunning = true;
    });
    generateExercise();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          showResults();
        }
      });
    });
  }

  void generateExercise() {
    final random = Random();
    setState(() {
      num1 = random.nextInt(90) + 10; // Números entre 10 y 99
      num2 = random.nextInt(90) + 10;

      List<String> operations = ['+', '-', '*', '/'];
      operation = operations[random.nextInt(operations.length)];

      switch (operation) {
        case '+':
          correctAnswer = (num1 + num2).toDouble();
          break;
        case '-':
          correctAnswer = (num1 - num2).toDouble();
          break;
        case '*':
          correctAnswer = (num1 * num2).toDouble();
          break;
        case '/':
          // Asegurar división exacta
          num1 = (num1 * num2);
          correctAnswer = num1 / num2;
          break;
      }
    });
  }

  void checkAnswer() {
    if (userAnswer.isEmpty) return;

    double parsedAnswer = double.tryParse(userAnswer) ?? 0.0;
    if (parsedAnswer == correctAnswer) {
      correctCount++;
    } else {
      incorrectCount++;
    }

    setState(() {
      questionsAsked++;
      userAnswer = "";
    });

    if (questionsAsked >= totalQuestions) {
      showResults();
    } else {
      generateExercise();
    }
  }

  void showResults() {
    if (isTimerRunning) {
      timer.cancel();
      isTimerRunning = false;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double accuracy =
            questionsAsked > 0 ? (correctCount / questionsAsked * 100) : 0;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "¡Tiempo Terminado!",
            style: TextStyle(
              color: Color(0xFF7B1FA2),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildResultItem(
                "Operaciones Realizadas",
                questionsAsked,
                Icons.calculate,
                Colors.purple,
              ),
              SizedBox(height: 10),
              _buildResultItem(
                "Respuestas Correctas",
                correctCount,
                Icons.check_circle,
                Colors.green,
              ),
              SizedBox(height: 10),
              _buildResultItem(
                "Respuestas Incorrectas",
                incorrectCount,
                Icons.cancel,
                Colors.red,
              ),
              SizedBox(height: 10),
              _buildResultItem(
                "Precisión",
                accuracy.round(),
                Icons.percent,
                Colors.blue,
                isPercentage: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                "Volver a intentar",
                style: TextStyle(
                  color: Color(0xFF7B1FA2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                showStartDialog();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contra Reloj"),
        backgroundColor: Color(0xFF7B1FA2),
        elevation: 0,
      ),
      body: Container(
        // ... mantener la decoración existente ...
        child: SafeArea(
          child: Column(
            children: [
              // Timer display con animación
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      timeLeft.toString(),
                      style: TextStyle(
                        color: timeLeft <= 5 ? Colors.red : Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "segundos restantes",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // ... mantener el resto del contenido existente ...
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultItem(String label, int value, IconData icon, Color color,
      {bool isPercentage = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            isPercentage ? "$value%" : value.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
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
            colors: [
              Color(0xFF7B1FA2),
              Color(0xFFE1BEE7),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
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
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Color(0xFF7B1FA2),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Configuración',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: [
                  _createDrawerItem(
                    icon: Icons.edit,
                    text: 'Cambiar nombre',
                    description: 'Actualiza tu nombre de usuario',
                    color: Colors.green,
                    onTap: () => _showEditDialog(context, 'nombre'),
                  ),
                  _createDrawerItem(
                    icon: Icons.vpn_key,
                    text: 'Contraseña',
                    description: 'Modifica tu contraseña',
                    color: Colors.orange,
                    onTap: () => _showPasswordDialog(context),
                  ),
                  _createDrawerItem(
                    icon: Icons.comment,
                    text: 'Comentarios',
                    description: 'Deja tus sugerencias',
                    color: Colors.blue,
                    onTap: () => _showEditDialog(context, 'comentario'),
                  ),
                  _createDrawerItem(
                    icon: Icons.history,
                    text: 'Progreso e Historial',
                    description: 'Revisa tu avance',
                    color: Colors.purple,
                    onTap: () => _navigate(context, 'Progreso e Historial'),
                  ),
                  Divider(color: Colors.white30, thickness: 1),
                  _createDrawerItem(
                    icon: Icons.logout,
                    text: 'Cerrar Sesión',
                    description: 'Salir de tu cuenta',
                    color: Colors.red,
                    onTap: () => _navigate(context, 'Cerrar Sesión'),
                  ),
                  _createDrawerItem(
                    icon: Icons.exit_to_app,
                    text: 'Salir',
                    description: 'Cerrar la aplicación',
                    color: Colors.redAccent,
                    onTap: () => _showExitWarning(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'MateManía v1.0',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required String description,
    required Color color,
    required GestureTapCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 26,
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showEditDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Cambiar $title',
            style: TextStyle(
              color: Color(0xFF7B1FA2),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Ingrese nuevo $title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Guardar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7B1FA2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Implementar lógica para guardar cambios
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Cambiar contraseña',
            style: TextStyle(
              color: Color(0xFF7B1FA2),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Nueva contraseña",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirmar contraseña",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Guardar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7B1FA2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Implementar lógica para cambiar contraseña
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showExitWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro?",
            style: TextStyle(
              color: Color(0xFF7B1FA2),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "¿Realmente deseas salir de MateManía?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Salir"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Implementar lógica para salir
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _navigate(BuildContext context, String route) {
    Navigator.pop(context); // Cierra el drawer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegando a $route...'),
        backgroundColor: Color(0xFF7B1FA2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    // Aquí puedes agregar la navegación real a las diferentes rutas
  }
}
