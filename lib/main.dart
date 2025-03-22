import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepPurple,

      )
    ),

  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ["Rupees", "Dollars", "Pounds"];
  final _minimumPadding = 5.0;
  var _currentSelectedItem = "Rupees";
  TextEditingController principleController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var _displayResult = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Simple Interest Calculator",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            //margin: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: [
                getAssetImage(),
                Padding(
                  padding: EdgeInsets.only(
                    top: _minimumPadding,
                    bottom: _minimumPadding,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: principleController,
                    validator: <String>(value) {
                      if (value.isEmpty) {
                        return 'Please enter principle amount';
                      }
                      //return null;
                    },

                    decoration: InputDecoration(
                      labelText: 'Principle',
                      hintText: 'Enter Principle e.g 12000',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: roiController,
                    validator: <String>(value) {
                      if (value.isEmpty) {
                        return 'Please enter rate of interest';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Rate of interest',
                      hintText: 'In percent',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: termController,
                        validator: <String>(value) {
                          if (value.isEmpty) {
                            return 'Please enter term in years';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Term'
                          ,
                          hintText: 'Times in years',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        // value: 'Rupees',
                        onChanged: <String>(selectedItem) {
                          setState(() {
                            _currentSelectedItem = selectedItem;
                          });
                        },
                        value: _currentSelectedItem,
                      ),
                    ),
                  ]),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (_formkey.currentState!.validate()) {
                                      _displayResult = _calculateTotalReturns();
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple
                                ),
                                child: Text(
                                  'Calculate',

                                  style: TextStyle(color: Colors.black,
                                      fontSize: 18.0
                                  ),
                                ))),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (_formkey.currentState!.validate()) {
                                      _reset();
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green
                                ),
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                    color: Colors.white, fontSize: 18.0,
                                  ),
                                ))),
                      ],
                    )
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(_displayResult),
                )
              ],
            ),
          ),)
    );
  }

  Widget getAssetImage() {
    AssetImage assetImage = AssetImage(
      'images/money.png',
    );
    Image image = Image(image: assetImage);
    return Container(
        child: image, margin: EdgeInsets.all(_minimumPadding * 10));
  }

  String _calculateTotalReturns() {
    double principle = double.parse(principleController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmmountPayable = (principle * roi * term) / 100;
    String result = 'After $term years,'
        ' your investment will be worth $totalAmmountPayable $_currentSelectedItem';
    return result;
  }

  void _reset() {
    principleController.text = '';
    roiController.text = '';
    termController.text = '';
    _displayResult = '';
    _currentSelectedItem = _currencies[0];
  }
}