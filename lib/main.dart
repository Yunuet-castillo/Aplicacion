import 'package:flutter/material.dart';

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
                      // para iniciar sesión
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
                      // para registrarse
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
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

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
                        _buildDatePickerField(), // Fecha de nacimiento debajo del nombre
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(title: 'MateMania'),
                                ),
                              );
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
                            '¡Comenzar! ',
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: "Contraseña",
          hintText: "Ingresa tu contraseña",
          prefixIcon:
              const Icon(Icons.lock, color: Color.fromARGB(255, 108, 67, 220)),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa tu contraseña';
          }
          return null;
        },
      ),
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
      appBar: AppBar(title: Text("Entrenamiento")),
      body: Center(
        child: Text("por realizar", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class EasyLevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nivel Fácil")),
      body: Center(
        child: Text("por realizar", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class IntermediateLevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nivel Intermedio")),
      body: Center(
        child: Text("por realizar", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class HardLevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nivel Difícil")),
      body: Center(
        child: Text("por realizar", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class TimedLevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Por Tiempo")),
      body: Center(
        child: Text("por realizar", style: TextStyle(fontSize: 24)),
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
