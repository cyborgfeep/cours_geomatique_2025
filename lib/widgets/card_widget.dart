import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../screens/scan_screen.dart';

class CardWidget extends StatefulWidget {
  final double? width;
  final double? height;
  const CardWidget({super.key, this.width, this.height});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*Permet d'aller d'une page vers une
        autre avec l'option de fermer la page precedente*/
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ScanScreen()),
          (route) => true,
        );
      },
      child: Center(
        child: Container(
          width: widget.width ?? 280,
          height: widget.height ?? 160,
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
            ),
          ),
          child: Center(
            child: Container(
              width: 120,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 105,
                    height: 105,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: PrettyQrView.data(
                      data:
                          'google.comhddhtgdhfhfghfhhdgfhgfdhfgddhfgdhgfgfhgfhfghgfhfghhgfhgfhgfhfghf',
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 15),
                      SizedBox(width: 5),
                      Text("Scanner"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
