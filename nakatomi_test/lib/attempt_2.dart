import 'package:flutter/material.dart';

class SecondAttempt extends StatefulWidget {
  const SecondAttempt({super.key});

  @override
  State<SecondAttempt> createState() => _SecondAttemptState();
}

class _SecondAttemptState extends State<SecondAttempt> {
  @override
  Widget build(BuildContext context) {
    double height = 72; // FIGURE OUT THIS VALUE
    double width = 88; // FIGURE OUT THIS VALUE
    int maxLines = 1; // FIGURE OUT THIS VALUE

    // const actualText = "Lorem";
    // const actualText = "Lorem ipsum";
    // const actualText = "Lorem ipsum dolor";
    // const actualText = "Lorem ipsum et annum mor";
    const actualText = "Lorem ipsum dolor sit amet, id ignota";
    // const actualText =
    //     "Lorem ipsum dolor sit amet, id ignota omnium vel. Ne has idque movet, exhgcffxgfx sample text";

    void calculateSpace() {
      TextSpan textSpan = const TextSpan(
        text: actualText,
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      );

      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      if (textPainter.width < 72) {
        //  case where the text is less than 72
        // lorem
        maxLines = 1;
        width = 72;
      } else if (textPainter.width > 72 && textPainter.width < 90) {
        // case where the text is less than 90 but greater than 72
        // lorem ipsum
        maxLines = 2;
        width = textPainter.width;
      } else if (textPainter.width > 90 && textPainter.width < 180 - 16) {
        // case where the text is less than 180 without padding but greater than 90
        // lorem ipsum dolor
        maxLines = 2;
        width = 90 + 16;
      } else if (textPainter.width > 180 - 16 && textPainter.width < 240) {
        // case where the text is less than 240 but greater than 180
        // for this the height has to be increased to 90 to fit the content in three lines
        // lorem ipsum dolor sit amet, id ignota

        width = textPainter.width / 2 + 16;
        maxLines = 3;
        height = 90;
      } else {
        // case where the text is greater than 240 and width can be dynamically increased
        // box constraint will cap the width at 198 and the height will be 90
        // lorem ipsum dolor sit amet, id ignota omnium vel. Ne has idque movet, ex asdasd
        width = textPainter.width;
        height = 90;
        maxLines = 3;
      }
    }

    calculateSpace();

    return Scaffold(
      body: Center(
        child: Container(
          height: height,
          width: width,
          // margin: EdgeInsets.only(
          //   top: 88.0 - height,
          //   left: 4.0,
          // ),
          padding: const EdgeInsets.all(8.0),
          constraints: const BoxConstraints(
            maxWidth: 198,
            maxHeight: 90,
          ), // For border
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
                        style: TextStyle(fontSize: 9, color: Colors.white),
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
