import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var selectedRange = RangeValues(400, 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(right: 24, left: 24, top: 32, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "your agenda",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Text(
                    "Time",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "range",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              RangeSlider(
                values: selectedRange,
                onChanged: (RangeValues newRange) {
                  setState(() {
                    selectedRange = newRange;
                  });
                },
                min: 70,
                max: 1000,
                activeColor: Colors.blue[900],
                inactiveColor: Colors.grey[300],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    r"1 week",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    r"1 year",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Numbers of appoitment",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildOption("Any", false),
                  buildOption("1", false),
                  buildOption("2", true),
                  buildOption("3+", false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOption(String text, bool selected) {
    return Container(
      height: 45,
      width: 65,
      decoration: BoxDecoration(
          color: selected ? Colors.purpleAccent[900] : Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            width: selected ? 0 : 1,
            color: Colors.grey,
          )),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
