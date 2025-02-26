import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    // theme: ThemeData(
    //   primaryColor: Colors.indigo,
    //   scaffoldBackgroundColor: Colors.black,
    // ),
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
  var _currencies = ["Rupees", "Dollars", "Pounds"];
  final _minimumPadding = 5.0;
  var _currentSelectedItem = "Rupees";
  TextEditingController principleController=TextEditingController();
  TextEditingController roiController=TextEditingController();
  TextEditingController termController=TextEditingController();
  var _displayResult='';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Simple Interest Calculator",
          style: TextStyle(
            color: Colors.indigo,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: [
            getAssetImage(),
            Padding(
              padding: EdgeInsets.only(
                top: _minimumPadding,
                bottom: _minimumPadding,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: principleController,
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
              child: TextField(
                keyboardType: TextInputType.number,
                controller: roiController,
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
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: termController,
                    decoration: InputDecoration(
                      labelText: 'Years',
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
                                _displayResult = _calculateTotalReturns();
                              });
                            },
                            child: Text(
                              'Calculate',
                              style: TextStyle(color: Colors.indigo),
                            ))),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.black,
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
      ),
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
    double totalAmmountPayable = (principle*roi*term)/100;
    String result = 'After $term years,'
        ' your investment will be worth $totalAmmountPayable $_currentSelectedItem';
    return result;
  }
  void _reset(){
    principleController.text='';
    roiController.text='';
    termController.text='';
    _displayResult='';
    _currentSelectedItem=_currencies[0];
  }
}
