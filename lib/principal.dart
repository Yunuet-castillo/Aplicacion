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
        fontFamily: 'ComicSans', // Fuente amigable para niños
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 26, fontFamily: 'Comic Sans MS'),
          labelLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'MateManía'),
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
            colors: [Colors.pinkAccent, Colors.orangeAccent],
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
              fontFamily: 'Comic Sans MS',
            ),
            textAlign: TextAlign.center,
          ),
        ),
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
      endDrawer: MateManiaDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.cyanAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLevelButton("Entrenamiento", Icons.school, () {}),
              _buildLevelButton("Nivel Fácil", Icons.calculate, () {}),
              _buildLevelButton("Nivel Intermedio", Icons.star, () {}),
              _buildLevelButton("Nivel Difícil", Icons.star_border, () {}),
              _buildLevelButton("Por Tiempo", Icons.timer, () {}),
            ],
          ),
        ),
      ),
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
        selectedItemColor: Colors.yellow,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildLevelButton(String text, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: 320,
        height: 75,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            elevation: 10,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.white),
              const SizedBox(width: 10),
              Text(text,
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Comic Sans MS',
                      color: Colors.white)),
            ],
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
        color: Colors.lightBlueAccent.shade100, // Fondo colorido
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
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
              onTap: () => _navigate(context, 'Cambiar nombre'),
            ),
            _createDrawerItem(
              icon: Icons.vpn_key,
              text: 'Contraseña',
              color: Colors.red,
              onTap: () => _navigate(context, 'Contraseña'),
            ),
            _createDrawerItem(
              icon: Icons.comment,
              text: 'Comentarios',
              color: Colors.teal,
              onTap: () => _navigate(context, 'Comentarios'),
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
              color: Colors.blue,
              onTap: () => _navigate(context, 'Salir'),
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

  void _navigate(BuildContext context, String screen) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navegando a $screen...')),
    );
  }
}
