import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sr.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: mypp());
  }
}

class mypp extends StatefulWidget {
  const mypp({Key? key}) : super(key: key);

  @override
  State<mypp> createState() => _myppState();
}

class _myppState extends State<mypp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(15),
              height: 350,
              width: 550,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_x1ikbkcj.json'),
            ),
          ),
          Text(
            'عاوز تصير شاطر بالهكر؟',
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
                textStyle: const TextStyle(
              color: Colors.red,
              fontSize: 40,
            )),
          ),
          Container(
            width: 250,
            height: 350,
            child: Column(
              children: [
                Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_zdtukd5q.json'),
                TextButton(
                  child: const Text('اضغط هنا'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
