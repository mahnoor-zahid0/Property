import 'dart:math';

import 'package:flutter/material.dart';

class EMICalculatorPage extends StatefulWidget {
  @override
  _EMICalculatorPageState createState() => _EMICalculatorPageState();
}

class _EMICalculatorPageState extends State<EMICalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  TextEditingController propertyPriceController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController loanTermController = TextEditingController();

  // Variable to store the calculated EMI
  double emi = 0.0;

  void calculateEMI() {
    double propertyPrice = double.parse(propertyPriceController.text);
    double downPayment = double.parse(downPaymentController.text);
    double loanAmount = propertyPrice - downPayment;
    double interestRate = double.parse(interestRateController.text) / 100;
    int loanTermMonths = int.parse(loanTermController.text) * 12;

    double monthlyInterestRate = interestRate / 12;
    double emiValue = (loanAmount * monthlyInterestRate * pow((1 + monthlyInterestRate), loanTermMonths)) /
        (pow((1 + monthlyInterestRate), loanTermMonths) - 1); // Use pow from dart:math

    setState(() {
      emi = emiValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: propertyPriceController,
                decoration: InputDecoration(labelText: 'Property Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter property price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: downPaymentController,
                decoration: InputDecoration(labelText: 'Down Payment'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter down payment';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: interestRateController,
                decoration: InputDecoration(labelText: 'Annual Interest Rate (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter interest rate';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: loanTermController,
                decoration: InputDecoration(labelText: 'Loan Term (Years)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter loan term';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    calculateEMI();
                  }
                },
                child: Text('Calculate EMI'),
              ),
              SizedBox(height: 20),
              if (emi > 0)
                Text(
                  'Your Monthly EMI: \$${emi.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
