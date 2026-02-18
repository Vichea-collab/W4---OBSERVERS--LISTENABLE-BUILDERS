import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType {
  red('Red', Colors.red),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  blue('Blue', Colors.blue);

  final String label;
  final Color color;

  const CardType(this.label, this.color);
}

class ColorService extends ChangeNotifier {
  final Map<CardType, int> tapCounts = {
    for (final type in CardType.values) type: 0,
  };

  void increment(CardType type) {
    tapCounts[type] = (tapCounts[type] ?? 0) + 1;
    notifyListeners();
  }

  int getTapCount(CardType type) => tapCounts[type] ?? 0;
}

final ColorService colorService = ColorService();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentIndex == 0
              ? ColorTapsScreen()
              : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children:
            CardType.values
                .map((type) => ColorTap(type: type))
                .toList(),
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  Color get backgroundColor => type.color;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, child) {
        final int tapCount = colorService.getTapCount(type);
        return GestureDetector(
          onTap: () {
            colorService.increment(type);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: $tapCount',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  CardType.values
                      .map(
                        (type) => Text(
                          '${type.label} Taps: ${colorService.getTapCount(type)}',
                          style: TextStyle(fontSize: 24),
                        ),
                      )
                      .toList(),
            ),
          );
        },
      ),
    );
  }
}
