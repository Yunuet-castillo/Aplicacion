import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Agregar Google Fonts

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logros',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme), // Usar Roboto de Google Fonts
      ),
      debugShowCheckedModeBanner: false, // Eliminar el debug banner
      home: LogrosScreen(),
    );
  }
}

class LogrosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 4,
        title: Text(
          'Logros',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.green.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Indicadores en la primera fila
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IndicatorWidget(
                    percentage: 0.64,
                    color: Colors.green.shade400,
                    label: '6%',
                  ),
                  SizedBox(width: 20),
                  IndicatorWidget(
                    percentage: 0.40,
                    color: Colors.red,
                    label: '4%',
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Indicadores en la segunda fila
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IndicatorWidget(
                    percentage: 0.90,
                    color: Colors.blue,
                    label: '0%',
                  ),
                  SizedBox(width: 20),
                  IndicatorWidget(
                    percentage: 0.10,
                    color: Colors.green.shade100,
                    label: '0%',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade800,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Niveles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Logros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  final double percentage;
  final Color color;
  final String label;

  const IndicatorWidget({
    required this.percentage,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100.0,
              height: 100.0,
              child: CircularProgressIndicator(
                value: percentage,
                strokeWidth: 10.0,
                color: color,
                backgroundColor: Colors.grey[300],
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          '${(percentage * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
