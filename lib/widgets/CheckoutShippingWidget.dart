import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'ProductDetails.dart';

class CheckoutShippingWidget extends StatefulWidget {
  static final TextStyle checkoutTextStyle = TextStyle(
      color: Colors.purple[900],
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w500);
  static final TextStyle checkoutTextStyleHint = TextStyle(
      color: Colors.purple[900].withOpacity(.4),
      fontSize: 15,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w500);

  static final TextStyle checkoutTextStyleBig = TextStyle(
      color: Colors.purple[900].withOpacity(.85),
      fontSize: 30,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w600);

  final TextStyle checkoutTextStyleMedium = TextStyle(
      color: Colors.purple[900].withOpacity(.85),
      fontSize: 18,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w600);

  @override
  _CheckoutShippingWidgetState createState() => _CheckoutShippingWidgetState();
}

enum PaymentMethods { creditCard, cash }

class _CheckoutShippingWidgetState extends State<CheckoutShippingWidget> {
  List<String> listOfCounties = new List();
  List<String> listOfCities = new List();
  List<dynamic> citiesAndCounties;
  String _countySelection = "Alege";
  String _citySelection = "Alege";
  PaymentMethods _paymentMethod = PaymentMethods.creditCard;

  @override
  void initState() {
    super.initState();
    listOfCounties.add("Alege");
    listOfCities.add("Alege");
    rootBundle.loadString("assets/judete.json").then((result) {
      citiesAndCounties = json.decode(result)["judete"];
      for (int i = 0; i < citiesAndCounties.length; i++) {
        setState(() {
          this.listOfCounties.add(citiesAndCounties[i]["nume"]);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
//    print(citiesAndCounties[0]["localitati"][0]["nume"]);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        height: size.height,
        margin: EdgeInsets.only(top: 0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60, left: 0, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_upward,
                        size: 20,
                        color: ProductDetails.arrowBackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Shipping Details",
              style: CheckoutShippingWidget.checkoutTextStyleBig,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.purple[900], width: 1),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(
                    "Select a county",
                    style: CheckoutShippingWidget.checkoutTextStyleHint,
                  ),
                  dropdownColor: Colors.purple[50],
                  style: CheckoutShippingWidget.checkoutTextStyle,
                  isExpanded: true,
                  onChanged: (newVal) {
                    setState(() {
                      _countySelection = newVal;
                      _citySelection = "Alege";
                    });
                    populateCitySpinner(newVal);
                    print(listOfCities);
                  },
                  value: _countySelection,
                  items: listOfCounties.map((county) {
                    return new DropdownMenuItem(
                      child: new Text(
                        county,
                      ),
                      value: county,
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              width: size.width,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.purple[900], width: 1),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(
                    "Select a city/village",
                    style: CheckoutShippingWidget.checkoutTextStyleHint,
                  ),
                  dropdownColor: Colors.purple[50],
                  style: CheckoutShippingWidget.checkoutTextStyle,
                  isExpanded: true,
                  onChanged: (newVal) {
                    setState(() {
                      _citySelection = newVal;
                    });
                  },
                  value: _citySelection,
                  items: listOfCities.map((city) {
                    return new DropdownMenuItem(
                      child: new Text(
                        city,
                      ),
                      value: city,
                    );
                  }).toList(),
                ),
              ),
            ),
            CustomInputFields("Street / Flat / Number"),
            CustomInputFields("Phone"),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "Payment type",
                      style: widget.checkoutTextStyleMedium,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Credit card',
                      style: CheckoutShippingWidget.checkoutTextStyle,
                    ),
                    leading: Radio(
                      activeColor: Colors.purple,
                      value: PaymentMethods.creditCard,
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  ),
                  ListTile(
                    title: Text(
                      'Cash on delivery',
                      style: CheckoutShippingWidget.checkoutTextStyle,
                    ),
                    leading: Radio(
                      activeColor: Colors.purple,
                      value: PaymentMethods.cash,
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  ),
//                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    height: size.height / 14,
                    width: size.width * 0.90,
                    decoration: BoxDecoration(
                      color: Colors.purple[100].withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple[900], width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FlatButton(
                        splashColor: Colors.purple[500],
                        onPressed: () {},
                        child: Text(
                          "Order",
                          style: TextStyle(
                              color: Colors.purple[900],
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Text(
                      "* Delivery fees are applicable for orders below 300 ron.",
                      style: CheckoutShippingWidget.checkoutTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void populateCitySpinner(String cityName) {
    listOfCities = new List();
    listOfCities.add("Alege");
    for (int i = 0; i < this.citiesAndCounties.length; i++) {
      if (citiesAndCounties[i]["nume"] == cityName) {
        for (int j = 0; j < citiesAndCounties[i]["localitati"].length; j++) {
          listOfCities.add(citiesAndCounties[i]["localitati"][j]["nume"]);
        }
      }
    }
  }
}

class CustomInputFields extends StatelessWidget {
  final String _hint;

  CustomInputFields(this._hint);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      margin: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.purple[900], width: 1)),
      child: TextField(
        style: CheckoutShippingWidget.checkoutTextStyle,
        autocorrect: false,
        autofocus: false,
        decoration: InputDecoration(
            hintText: _hint,
            hintStyle: CheckoutShippingWidget.checkoutTextStyleHint,
            border: InputBorder.none),
      ),
    );
  }
}
