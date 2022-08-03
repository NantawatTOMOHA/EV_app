import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:my_flutter/screen/payment.dart';

Map station = {
  'id': 1,
  'name': 'สถานีชาร์จรถยนต์ไฟฟ้า บริษัท 909 มหาคุณ จำกัด',
  'distance': 0.3131,
  'Latitude': 13.72206606,
  'Longitude': 100.7614321,
  'status': 'Available'
};

int min = 30;

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  List<bool> isSelected1 = [true];
  List<bool> isSelected2 = [false];
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  String firstFewWords(String bigSentence) {
    int startIndex = 0;
    late int indexOfSpace;

    for (int i = 0; i < 4; i++) {
      indexOfSpace = bigSentence.indexOf(' ', startIndex);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return bigSentence;
      }
      startIndex = indexOfSpace + 1;
    }
    return bigSentence.substring(0, indexOfSpace) + '...';
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Booking Charger',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromRGBO(20, 20, 20, 1),
          elevation: 1,
        ),
        body: Container(
            color: Color.fromRGBO(20, 20, 20, 1),
            child: Column(children: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    firstFewWords(station['name'].toString()),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                subtitle: Row(children: [
                  Text(
                    'Status     ',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(62, 255, 31, 1),
                    ),
                  ),
                  Text(
                    '  ' + (station['status']).toString(),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ]),
                trailing: Text(
                  '(' + (station['distance'] * 1000).toStringAsFixed(1) + ' M)',
                  style: TextStyle(color: Color.fromRGBO(212, 17, 17, 1)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ToggleButtons(
                borderWidth: 2,
                borderColor: Color.fromRGBO(32, 32, 32, 1),
                selectedBorderColor: Color.fromRGBO(212, 17, 17, 1),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(32, 32, 32, 1),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 43),
                    width: screenWidth - 40,
                    child: Column(children: [
                      Text(
                        'AC',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 64,
                        ),
                      ),
                      Text(
                        'Normal Charge',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ]),
                  )
                ],
                onPressed: (int index) {
                  setState(() {
                    isSelected1[index] = true;
                    isSelected2[index] = false;
                  });
                },
                isSelected: isSelected1,
              ),
              SizedBox(
                height: 10,
              ),
              ToggleButtons(
                borderWidth: 2,
                borderColor: Color.fromRGBO(32, 32, 32, 1),
                selectedBorderColor: Color.fromRGBO(212, 17, 17, 1),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(32, 32, 32, 1),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 43),
                    width: screenWidth - 40,
                    child: Column(children: [
                      Text(
                        'DC',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 64,
                        ),
                      ),
                      Text(
                        'Quick Charge',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ]),
                  )
                ],
                onPressed: (int index) {
                  setState(() {
                    isSelected1[index] = false;
                    isSelected2[index] = true;
                  });
                },
                isSelected: isSelected2,
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    '   Connecter type',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  buttonHeight: 50,
                  buttonWidth: screenWidth - 40,
                  itemHeight: 30,
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color.fromRGBO(212, 17, 17, 1),
                      width: 2,
                    ),
                    color: Color.fromRGBO(50, 55, 65, 1),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  fixedSize: const Size(256, 34),
                  primary: const Color.fromRGBO(76, 77, 79, 1), // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PaymentScreen();
                  }));
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ])));
  }
}
