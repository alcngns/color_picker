
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ColorPickerPage(title: 'Color Picker'),
    );
  }
}

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key, required this.title});

  final String title;

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {

  Color selectedColor = Colors.blue;

  final Map<Color, String> colors = {
    Colors.red: "Red",
    Colors.blue: "Blue",
    Colors.yellow: "Yellow",
    Colors.green: "Green",
    Colors.purple: "Purple"
  };

  bool isCircular = false;
  bool isShowColorName = true;


  void _randomColorSet() {
    setState(() {
      final colorsList = colors.keys.toList();
      final randomColor = colorsList[(Random().nextInt(colorsList.length))];
      selectedColor = randomColor;
    });
  }

  void _showColorCode(){
    Fluttertoast.showToast(
        msg: "RGB : ("
            "${selectedColor.r.toStringAsFixed(2)}, ${selectedColor.g.toStringAsFixed(2)}, ${selectedColor.b.toStringAsFixed(2)})",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: selectedColor,
        textColor: Colors.white,
        fontSize: 18.0
    );
  }

  void _containerShapeChange(){

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .onPrimary,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                isShowColorName = !isShowColorName;
              });
            },
            itemBuilder: (context){
              return [
                PopupMenuItem(
                  value: "a",
                    child: Row(
                      children: [
                        Icon(
                          isShowColorName ? Icons.visibility_off : Icons.visibility,
                          size: 20,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8,),
                        Text("Show/Hide"),
                      ],
                    ),
                ),
              ];
            }
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(isCircular ? 100 : 10),
                  boxShadow: [
                    BoxShadow(
                      color: selectedColor,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ]
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            isShowColorName ? Text(colors[selectedColor] ?? "Selected Color") : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<Color>(
                      value: selectedColor,
                      items: colors.entries.map((entry) {
                        return DropdownMenuItem(
                            value: entry.key,
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: entry.key,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(entry.value),
                              ],
                            ));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedColor = value!;
                        });
                      }
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white12),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: _randomColorSet,
                    child: Text("Random", style: TextStyle(fontSize: 16.0),),
                  ),
                  IconButton(
                    onPressed: _showColorCode,
                    icon: Icon(Icons.info),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isCircular = !isCircular;
                      });
                    },
                    icon: Icon( isCircular ? Icons.square_outlined : Icons.circle_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}