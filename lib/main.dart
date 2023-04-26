import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) => HeightAdjustableContainers(
          screenHeight: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}

class HeightAdjustableContainers extends StatefulWidget {
  final double screenHeight;

  const HeightAdjustableContainers({Key? key, required this.screenHeight})
      : super(key: key);

  @override
  _HeightAdjustableContainersState createState() =>
      _HeightAdjustableContainersState();
}

class _HeightAdjustableContainersState
    extends State<HeightAdjustableContainers> {
  late double _redContainerHeight;
  late double _blueContainerHeight;

  @override
  void initState() {
    super.initState();
    _redContainerHeight =  widget.screenHeight * 0.5;
    _blueContainerHeight =  widget.screenHeight * 0.5;
  }

  void resetGame() {
    setState(() {
      _redContainerHeight = widget.screenHeight / 2;
      _blueContainerHeight = widget.screenHeight / 2;
    });
  }

  void _incrementRedContainerHeight() {
    setState(() {
      _redContainerHeight += 40.0;
      _blueContainerHeight -= 40.0;
      _checkWinner();
    });
  }

  void _incrementBlueContainerHeight() {
    setState(() {
      _blueContainerHeight += 40.0;
      _redContainerHeight -= 40.0;
      _checkWinner();
    });
  }
  void _checkWinner() {
    if (_redContainerHeight >= 0.9 * widget.screenHeight) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents the dialog from being dismissed
        builder: (context) => Dialog(
          backgroundColor: Colors.grey[800],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Red Container Wins!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Congratulations!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        resetGame();
                      },
                      child: const Text('Reset', style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: const Text('Home', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else if (_blueContainerHeight >= 0.9 * widget.screenHeight) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents the dialog from being dismissed
        builder: (context) => Dialog(
          backgroundColor: Colors.grey[800],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Blue Container Wins!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Congratulations!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        resetGame();
                      },
                      child: const Text('Reset', style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: const Text('Home', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _incrementRedContainerHeight,
              child: Container(
                color: Colors.red,
                width: double.infinity,
                height: _redContainerHeight != null ? _redContainerHeight : 0.0,
              ),
            ),
            GestureDetector(
              onTap: _incrementBlueContainerHeight,
              child: Container(
                color: Colors.blue,
                width: double.infinity,
                height: _blueContainerHeight != null ? _blueContainerHeight : 0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
