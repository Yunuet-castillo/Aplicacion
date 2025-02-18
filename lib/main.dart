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

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            '¡Bienvenido a MateManía!',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color.fromARGB(255, 129, 100, 190),
              Color.fromARGB(255, 129, 100, 190),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.teal.shade50.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Inicia Sesión",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(Icons.person, "Usuario"),
                  SizedBox(height: 10),
                  _buildTextField(Icons.lock, "Password", isPassword: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  title: 'Matemania',
                                )),
                      );
                      // Lógica para iniciar sesión
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                    ),
                    child: Text(
                      "Aceptar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationForm()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                    ),
                    child: Text(
                      "Regístrate",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Método para crear los TextFields reutilizables
  Widget _buildTextField(IconData icon, String hint,
      {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

// Clase de ejemplo para RegistrationForm

Widget _buildTextField(IconData icon, String hintText,
    {bool isPassword = false}) {
  return TextField(
    obscureText: isPassword,
    style: TextStyle(color: const Color.fromARGB(255, 129, 100, 190)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 115, 92, 161)),
      hintText: hintText,
      hintStyle: TextStyle(color: const Color.fromARGB(255, 165, 151, 206)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _collectionReference;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _collectionReference = _firestore.collection('usuarios');
  }

  Future<void> getUsuarios() async {
    try {
      QuerySnapshot querySnapshot = await _collectionReference.get();
      for (var doc in querySnapshot.docs) {
        print("Usuario: ${doc.data()}");
      }
    } catch (e) {
      print("Error obteniendo usuarios: $e");
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
      appBar: AppBar(
        title: const Text('MateManía'),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '¡Bienvenido!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Completa el formulario para registrarte',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          "Nombre Completo",
                          _nameController,
                          "Ingresa tu nombre completo",
                          Icons.person,
                        ),
                        _buildDatePickerField(),
                        _buildTextField(
                          "Edad",
                          _ageController,
                          "Ingresa tu edad",
                          Icons.cake,
                          isNumber: true,
                        ),
                        _buildTextField(
                          "Escuela",
                          _schoolController,
                          "Ingresa tu escuela",
                          Icons.school,
                        ),
                        _buildTextField(
                          "Correo Electrónico",
                          _emailController,
                          "Ingresa tu correo",
                          Icons.email,
                          isEmail: true,
                        ),
                        _buildPasswordField(),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              // TODO: Agregar lógica para registro en Firebase Auth o Firestore
                              print(
                                  "Formulario válido. Continuar con el registro.");
                              // Navegación de ejemplo (ajustar según tu código)
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => MyHomePage(title: 'MateMania')),
                              // );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 169, 143, 219),
                          ),
                          label: const Text(
                            '¡Comenzar!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool isPassword = false,
    bool isEmail = false,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon:
              Icon(icon, color: const Color.fromARGB(255, 108, 67, 220)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa $label';
          }
          if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Por favor, ingresa un correo válido';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return _buildTextField(
      "Contraseña",
      _passwordController,
      "Ingresa tu contraseña",
      Icons.lock,
      isPassword: true,
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _birthDateController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: "Fecha de Nacimiento",
          hintText: "Selecciona tu fecha de nacimiento",
          prefixIcon: const Icon(Icons.calendar_today,
              color: Color.fromARGB(255, 108, 67, 220)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            _birthDateController.text =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          }
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

  // Navegar entre pantallas principales
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Definir las vistas según el índice del BottomNavigationBar
  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _LevelsPage(); // Aquí pondrás tu vista para niveles
      case 1:
        return _AchievementsPage(); // Aquí pondrás tu vista para logros
      case 2:
        return _ProfilePage(); // Aquí pondrás tu vista para perfil
      default:
        return _LevelsPage(); // Definir qué vista mostrar por defecto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.title,
            style: TextStyle(fontFamily: 'Comic Sans MS', fontSize: 26)),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: MateManiaDrawer(), // Tu Drawer personalizado
      body: _buildMainContent(), // Aquí se muestra el contenido principal
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book, size: 40),
            label: 'Niveles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events, size: 40),
            label: 'Logros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 40),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 202, 133, 210),
        onTap: _onItemTapped,
      ),
    );
  }
}

class _LevelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLevelButton(
              context, "Entrenamiento", Icons.school, TrainingPage()),
          _buildLevelButton(
              context, "Nivel Fácil", Icons.calculate, EasyLevelPage()),
          _buildLevelButton(
              context, "Nivel Intermedio", Icons.star, IntermediateLevelPage()),
          _buildLevelButton(
              context, "Nivel Difícil", Icons.star_border, HardLevelPage()),
          _buildLevelButton(
              context, "Por Tiempo", Icons.timer, TimedLevelPage()),
        ],
      ),
    );
  }

  Widget _buildLevelButton(
      BuildContext context, String title, IconData icon, Widget nextPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: 250, // Establece un ancho fijo
        height: 60, // Establece un alto fijo
        child: ElevatedButton.icon(
          icon: Icon(icon, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage),
            );
          },
          label: Text(title, style: TextStyle(fontSize: 20)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 234, 186, 243),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
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
    return Center(
      child: Text(
        "por realizar",
        style: TextStyle(fontSize: 24, color: Colors.purple),
      ),
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
            colors: [
              const Color.fromARGB(255, 202, 133, 210),
              const Color.fromARGB(255, 255, 255, 255)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.orangeAccent,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'Yunuet Castillo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tu rango',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    Text(
                      '50/100',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.transparent,
                        color: Color.fromARGB(255, 202, 133, 210),
                      ),
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

class _EasyLevelPageState extends State<EasyLevelPage> {
  late int num1;
  late int num2;
  late int correctAnswer;
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

  void askQuestionCount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 10),
              Text(
                "¿Cuántas operaciones quieres realizar?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => setQuestionCount(5),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("5 preguntas"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => setQuestionCount(10),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.greenAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("10 preguntas"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => setQuestionCount(15),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("15 preguntas"),
              ),
            ],
          ),
        );
      },
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

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    generateExercise();
  }

  void generateExercise() {
    if (questionsAsked < totalQuestions) {
      final random = Random();
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

      setState(() {
        userAnswer = "";
      });
    } else {
      showResults();
    }
  }

  void checkAnswer() {
    if (userAnswer.isEmpty) return;

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
        return AlertDialog(
          title: Text("Resultados"),
          content: Text(
            "Respuestas correctas: $correctCount\nRespuestas incorrectas: $incorrectCount",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Volver a intentar"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel Fácil"),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (questionsAsked < totalQuestions)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "$num1 $operation $num2 = ?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 30),
                Container(
                  width: 120,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "?",
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userAnswer = value;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        userAnswer = value;
                      });
                      checkAnswer();
                    },
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: userAnswer.isNotEmpty ? checkAnswer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.black26,
                    elevation: 10,
                  ),
                  child: Text(
                    "Siguiente",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

class IntermediateLevelPage extends StatefulWidget {
  @override
  _IntermediateLevelPageState createState() => _IntermediateLevelPageState();
}

class _IntermediateLevelPageState extends State<IntermediateLevelPage> {
  late int num1;
  late int num2;
  late int correctAnswer;
  String operation = "";
  String userAnswer = "";
  int questionsAsked = 0;
  int totalQuestions = 0;
  int correctCount = 0;
  int incorrectCount = 0;

  @override
  void initState() {
    super.initState();
    num1 = 0;
    num2 = 0;
    correctAnswer = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askQuestionCount();
    });
  }

  void askQuestionCount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 10),
              Text(
                "¿Cuántas operaciones quieres realizar?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => setQuestionCount(5),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("5 preguntas"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => setQuestionCount(10),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.greenAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("10 preguntas"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => setQuestionCount(15),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("15 preguntas"),
              ),
            ],
          ),
        );
      },
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

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    generateExercise(); // Generar la primera operación después de establecer el número de preguntas
  }

  void generateExercise() {
    final random = Random();
    num1 = random.nextInt(50) + 50; // Entre 50 y 99
    num2 = random.nextInt(50) + 50; // Entre 50 y 99

    List<String> operations = ['+', '-', '*', '/'];
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
        num1 = num1 * num2; // Asegura que el resultado sea un número entero
        correctAnswer = num1 ~/ num2;
        break;
      default:
        correctAnswer = 0;
    }

    setState(() {});
  }

  void checkAnswer() {
    if (userAnswer.isEmpty) return;

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
        return AlertDialog(
          title: Text("Resultados"),
          content: Text(
            "Respuestas correctas: $correctCount\nRespuestas incorrectas: $incorrectCount",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Volver a intentar"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel Intermedio"),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (questionsAsked < totalQuestions)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "$num1 $operation $num2 = ?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 30),
                Container(
                  width: 120,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "?",
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userAnswer = value;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        userAnswer = value;
                      });
                      checkAnswer();
                    },
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: userAnswer.isNotEmpty ? checkAnswer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.black26,
                    elevation: 10,
                  ),
                  child: Text(
                    "Siguiente",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

class HardLevelPage extends StatefulWidget {
  @override
  _HardLevelPageState createState() => _HardLevelPageState();
}

class _HardLevelPageState extends State<HardLevelPage> {
  late int num1;
  late int num2;
  late double correctAnswer;
  String operation = "";
  String userAnswer = "";
  int questionsAsked = 0;
  int totalQuestions = 0;
  int correctCount = 0;
  int incorrectCount = 0;
  List<double> options = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askQuestionCount();
    });
  }

  void askQuestionCount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 10),
              Text(
                "¿Cuántas operaciones quieres realizar?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => setQuestionCount(5),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("5 preguntas"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => setQuestionCount(10),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.greenAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("10 preguntas"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => setQuestionCount(15),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("15 preguntas"),
              ),
            ],
          ),
        );
      },
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

    // Cerrar el diálogo si está abierto
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    generateExercise();
  }

  void generateExercise() {
    final random = Random();

    // Números grandes para el nivel difícil
    num1 = random.nextInt(50) + 50; // Genera números entre 50 y 99
    num2 = random.nextInt(50) + 50; // Genera números entre 50 y 99

    // Selección aleatoria de la operación
    List<String> operations = ['+', '-', '*', '/'];
    operation = operations[random.nextInt(operations.length)];

    switch (operation) {
      case '+':
        correctAnswer = num1 + num2.toDouble();
        break;
      case '-':
        correctAnswer = num1 - num2.toDouble();
        break;
      case '*':
        correctAnswer = num1 * num2.toDouble();
        break;
      case '/':
        num1 = num1 * num2; // Asegura que el resultado sea un entero
        correctAnswer = num1 / num2.toDouble();
        break;
      default:
        correctAnswer = 0;
    }

    // Genera opciones con variación
    options = [
      correctAnswer,
      correctAnswer + random.nextInt(10) + random.nextDouble(),
      correctAnswer - (random.nextInt(10) + random.nextDouble()),
      correctAnswer + (random.nextDouble() * 5 - 2),
    ];
    options.shuffle();

    setState(() {});
  }

  void checkAnswer() {
    if (userAnswer.isNotEmpty) {
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
  }

  void showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Resultados"),
          content: Text(
            "Respuestas correctas: $correctCount\nRespuestas incorrectas: $incorrectCount",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Volver a intentar"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel Difícl"),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (questionsAsked < totalQuestions)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "$num1 $operation $num2 = ?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 30),
                Container(
                  width: 120,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "?",
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userAnswer = value;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        userAnswer = value;
                      });
                      checkAnswer();
                    },
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: userAnswer.isNotEmpty ? checkAnswer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.black26,
                    elevation: 10,
                  ),
                  child: Text(
                    "Siguiente",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
  int totalQuestions = 0;
  int correctCount = 0;
  int incorrectCount = 0;
  late Stopwatch stopwatch;
  bool isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    num1 = 0;
    num2 = 0;
    correctAnswer = 0.0;
    stopwatch = Stopwatch();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askQuestionCount();
    });
  }

  void askQuestionCount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 10),
              Text(
                "¿Cuántas operaciones quieres realizar?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => setQuestionCount(5),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("5 preguntas"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => setQuestionCount(10),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.greenAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("10 preguntas"),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => setQuestionCount(15),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: Text("15 preguntas"),
              ),
            ],
          ),
        );
      },
    );
  }

  void setQuestionCount(int count) {
    setState(() {
      totalQuestions = count;
      questionsAsked = 0;
      correctCount = 0;
      incorrectCount = 0;
    });
    Navigator.of(context).pop();
    generateExercise();
  }

  void generateExercise() {
    final random = Random();

    num1 = random.nextInt(40) + 10;
    num2 = random.nextInt(40) + 10;

    List<String> operations = ['+', '-', '*'];
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
    }

    setState(() {});
  }

  void checkAnswer() {
    if (userAnswer.isNotEmpty) {
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
  }

  void showResults() {
    stopwatch.stop();
    final elapsedTime = stopwatch.elapsed;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Resultados"),
          content: Text(
            "Respuestas correctas: $correctCount\nRespuestas incorrectas: $incorrectCount\nTiempo: ${elapsedTime.inSeconds} segundos",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Volver a intentar"),
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

  String formatTime(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void toggleTimer() {
    setState(() {
      if (isTimerRunning) {
        stopwatch.stop();
      } else {
        stopwatch.start();
      }
      isTimerRunning = !isTimerRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nivel por tiempo"),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (questionsAsked < totalQuestions)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "$num1 $operation $num2 = ?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 30),
                Container(
                  width: 120,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "?",
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userAnswer = value;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        userAnswer = value;
                      });
                      checkAnswer();
                    },
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: userAnswer.isNotEmpty ? checkAnswer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.black26,
                    elevation: 10,
                  ),
                  child: Text(
                    "Siguiente",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

class MateManiaDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFE1BEE7), // Fondo colorido
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(156, 39, 176, 1),
              ),
              child: Text(
                'Configuración',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'ComicSans', // Fuente amigable
                ),
              ),
            ),
            _createDrawerItem(
              icon: Icons.edit,
              text: 'Cambiar nombre',
              color: Colors.orange,
              onTap: () => _showEditDialog(context, 'nombre'),
            ),
            _createDrawerItem(
              icon: Icons.vpn_key,
              text: 'Contraseña',
              color: Colors.red,
              onTap: () => _showPasswordDialog(context),
            ),
            _createDrawerItem(
              icon: Icons.comment,
              text: 'Comentarios',
              color: Colors.teal,
              onTap: () => _showEditDialog(context, 'comentario'),
            ),
            _createDrawerItem(
              icon: Icons.history, // O usa Icons.hourglass_top si prefieres
              text: 'Progreso e Historial',
              color: const Color.fromARGB(255, 33, 243, 191),
              onTap: () => _navigate(context, 'Progreso e Historial'),
            ),
            _createDrawerItem(
              icon: Icons.power_settings_new,
              text: 'Cerrar Sesión',
              color: Colors.blue,
              onTap: () => _navigate(context, 'Cerrar Sesión'),
            ),
            _createDrawerItem(
              icon: Icons.power_settings_new,
              text: 'Salir',
              color: const Color.fromARGB(255, 243, 233, 33),
              onTap: () => _showExitWarning(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required Color color,
      required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 30, // Tamaño grande para íconos llamativos
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'ComicSans',
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showEditDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cambiar $title'),
          content: TextField(
            decoration: InputDecoration(hintText: "Ingrese nuevo $title"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Guardar"),
              onPressed: () {
                // Lógica para guardar el cambio
                Navigator.of(context).pop();
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
          title: Text('Cambiar contraseña'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration:
                    InputDecoration(hintText: "Ingrese nueva contraseña"),
                obscureText: true,
              ),
              TextField(
                decoration:
                    InputDecoration(hintText: "Verifique nueva contraseña"),
                obscureText: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Guardar"),
              onPressed: () {
                // Lógica para guardar la nueva contraseña
                Navigator.of(context).pop();
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
          title: Text("Advertencia"),
          content: Text("¿Estás seguro de que quieres salir de MateMania?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Aceptar"),
              onPressed: () {
                // Lógica para salir de la aplicación
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigate(BuildContext context, String screen) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navegando a $screen...')),
    );
  }
}
