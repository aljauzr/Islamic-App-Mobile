import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'profile_screen.dart';
import 'package:intl/intl.dart';
import 'dart:async';

const primaryColor = Color(0xFF647c64);

class FiturTambahanScreen extends StatefulWidget {
  FiturTambahanScreen({Key? key}) : super(key: key);

  @override
  State<FiturTambahanScreen> createState() => _FiturTambahanScreenState();
}

class _FiturTambahanScreenState extends State<FiturTambahanScreen> {
  // BOTTOM NAVBAR CONDITION
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
    }
    if (_selectedIndex == 1) {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
    }
  }
  // END OF BOTTOM NAVBAR CONDITION

  String sourceCurrency = 'USD';
  String targetCurrency = 'IDR';
  TextEditingController sourceController = TextEditingController();
  TextEditingController targetController = TextEditingController();

  void convertCurrency() {
    double sourceValue = double.tryParse(sourceController.text) ?? 0.0;
    double result;

    if (sourceCurrency == 'USD' && targetCurrency == 'IDR') {
      result = sourceValue * 14000; // Conversion rate from USD to IDR
    } else if (sourceCurrency == 'USD' && targetCurrency == 'SGD') {
      result = sourceValue * 1.35; // Conversion rate from USD to SGD
    } else if (sourceCurrency == 'IDR' && targetCurrency == 'USD') {
      result = sourceValue / 14000; // Conversion rate from IDR to USD
    } else if (sourceCurrency == 'IDR' && targetCurrency == 'SGD') {
      result = sourceValue / 10450; // Conversion rate from IDR to SGD
    } else if (sourceCurrency == 'SGD' && targetCurrency == 'USD') {
      result = sourceValue / 1.35; // Conversion rate from SGD to USD
    } else if (sourceCurrency == 'SGD' && targetCurrency == 'IDR') {
      result = sourceValue * 10450; // Conversion rate from SGD to IDR
    } else {
      result = sourceValue; // Same currency, no conversion needed
    }

    targetController.text = result.toStringAsFixed(2);
  }

  String selectedTimeZone = 'WIB';
  String currentTime = '';

  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateCurrentTime();
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void updateCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = '';

    switch (selectedTimeZone) {
      case 'WIB':
        formattedTime = DateFormat('HH:mm:ss').format(now);
        break;
      case 'WIT':
        formattedTime = DateFormat('HH:mm:ss').format(now.add(Duration(hours: 1)));
        break;
      case 'WITA':
        formattedTime = DateFormat('HH:mm:ss').format(now.add(Duration(hours: 2)));
        break;
      case 'London':
        formattedTime = DateFormat('HH:mm:ss').format(now.subtract(Duration(hours: 7)));
        break;
    }

    setState(() {
      currentTime = formattedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profil",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Container(
              height: constraints.maxHeight, // Set the height to the screen's height
              color: primaryColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "Konversi Mata Uang",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  DropdownButton<String>(
                                    value: sourceCurrency,
                                    items: <String>['USD', 'IDR', 'SGD']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        sourceCurrency = newValue ?? 'USD';
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: TextField(
                                      controller: sourceController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Mata Uang Asal',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  DropdownButton<String>(
                                    value: targetCurrency,
                                    items: <String>['USD', 'IDR', 'SGD']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        targetCurrency = newValue ?? 'IDR';
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: TextField(
                                      controller: targetController,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        labelText: 'Hasil',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: convertCurrency,
                                child: Text('Konversi'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  primary: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "Waktu Saat Ini",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              DropdownButton<String>(
                                value: selectedTimeZone,
                                items: <String>['WIB', 'WIT', 'WITA', 'London']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      color: primaryColor, // Set the background color
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedTimeZone = newValue ?? 'WIB';
                                    updateCurrentTime();
                                  });
                                },
                                style: TextStyle(color: Colors.white),
                                dropdownColor: primaryColor,
                              ),
                              SizedBox(height: 10),
                              Text(
                                currentTime,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: primaryColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
