import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const actualText = "Lorem ipsum dolor";

    double maxHeight = 72; // FIGURE OUT THIS VALUE
    double maxWidth = 72; // FIGURE OUT THIS VALUE
    int maxLines = 1; // FIGURE OUT THIS VALUE

    // calculating the text width
    TextSpan text = const TextSpan(
      text: actualText,
      style: TextStyle(fontSize: 13, color: Colors.white),
    );

    TextPainter textPainter = TextPainter(
      text: text,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    if (textPainter.width < 72) {
      // this is only for one liner that takes less than 72 width
      maxWidth = 72;
    } else if (textPainter.width > 72 && textPainter.width < 90) {
      // this is for multi liner that takes less than 90 width but more than 72
      maxWidth = textPainter.width;
      maxLines = 3;
    } else {
      // this is for multi liner that takes more than 90 width where the height has to be changed to 90
      // even if the text width is more than 198, the constraint is set to 198 so that the text does not overflow
      maxWidth = textPainter.width;
      maxHeight = 90;
      maxLines = 3;
    }

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: 88.0 - (maxHeight > 90 ? 90 : 88.0 - maxHeight),
            left: 4.0,
          ),
          padding: const EdgeInsets.all(8.0),
          constraints: const BoxConstraints(
            // as the maximum width is 198 and maximum height is 90
            maxWidth: 198,
            maxHeight: 90,
          ), // For border
          height: maxHeight,
          // width is set to maxWidth which is getting the text width
          // as the chat bubble needs to be dynamic width based on the text
          width: maxWidth,
          decoration: BoxDecoration(
            color: Colors.greenAccent.shade700,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 4.0),
                constraints: const BoxConstraints(maxWidth: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text(
                        "AUTHOR",
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                actualText,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
