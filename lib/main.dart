import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  title:
  Text("simple interest calcultor");
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "simple interest calcultor",
      home: SIform(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent),
    ),
  );
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIformstate();
  }
}

class _SIformstate extends State<SIform> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ["Rupees", "Dollars", "Pounds"];
  final _minmiumPadding = 5.0;

  var _currentItemSelected = "Rupees";

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("simple interest calculator"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(
                  top: _minmiumPadding, bottom: _minmiumPadding),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principalController,
                validator: (String value){
                  if(value.isEmpty){
                    return "please enter principal amount";
                  }
                },
                decoration: InputDecoration(
                  labelText: "principal",
                  hintText: "enter principal e.g. 12000",
                  labelStyle: textStyle,
                  errorStyle: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 15.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minmiumPadding, bottom: _minmiumPadding),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiController,
                validator: (String value){
                  if(value.isEmpty){
                    return "please enter rate of interest";
                  }
                },
                decoration: InputDecoration(
                  labelText: "rate of interrest",
                  hintText: "enter rate in perccentage e.g. 10%",
                  labelStyle: textStyle,
                  errorStyle: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 15.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minmiumPadding, bottom: _minmiumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      validator: (String value){
                        if(value.isEmpty){
                          return "please enter the term";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "term",
                        hintText: "time in years",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  Container(
                    width: _minmiumPadding * 5,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValueSelected) {
                        _onDropdownItemSelected(newValueSelected);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minmiumPadding, bottom: _minmiumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        "calculate",
                        style: textStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState.validate()){
                          this.displayResult = calculateTotalReturns();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        "reset",
                        style: textStyle,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_minmiumPadding),
              child: Text(
                this.displayResult,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/bank.webp');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);

    return Container(
      child: image,
      margin: EdgeInsets.all(_minmiumPadding * 10),
    );
  }

  void _onDropdownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        "after $term years ,your investment will worth $totalAmountPayable $_currentItemSelected";
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    _currentItemSelected = _currencies[0];
  }
}
