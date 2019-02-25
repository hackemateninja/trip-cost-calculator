import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trip Cost Calculator',
      theme: ThemeData.dark(),
      home: new FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FuelFormState();

}

class _FuelFormState extends State<FuelForm>{
  String result = '';
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  final double _formDistance = 5.0;
  String _currency = 'Dollars';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip cost calculator"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance
              ),
              child:TextField(
                controller: distanceController,
                decoration: InputDecoration(
                  labelText: 'Distance',
                  hintText: 'e.g 124',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance
              ),
              child: TextField(
                controller: avgController,
                decoration: InputDecoration(
                  labelText: 'Distance per unit',
                  hintText: 'e.g 17',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance
              ),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'price',
                  hintText: 'e.g 1.5',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            DropdownButton<String>(
              items: _currencies.map((String value){
                return DropdownMenuItem<String> (
                  value: value,
                  child: Text(value)
                );
              }).toList(),
              value: _currency,
              onChanged: (String value){
                _onDropdownChanged(value);
              },
            ),
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).primaryColorLight,
              onPressed: (){
                setState(() {
                  result = _calculate();
                });
              },
              child: Text(
                'Submit',
                textScaleFactor: 1.5,
              ),
            ),
            Text(result)
          ],
        )
      ),
    );
  }

  void _onDropdownChanged(String value){
    setState(() {
      this._currency = value;
    });
  }

  String _calculate(){
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result = 'The total cost of your trip is: ${_totalCost.toStringAsFixed(2)} $_currency';
    return _result;
  }

}