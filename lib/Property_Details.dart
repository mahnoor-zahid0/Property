import 'dart:math';

import 'package:flutter/material.dart';
import 'constants/colors.dart'; // Update the path to AppColors

class PropertyDetailPage extends StatelessWidget {
  final String title;
  final String location;
  final double rating;
  final String distance;
  final List<String> images; // List of images to display

  const PropertyDetailPage({
    Key? key,
    required this.title,
    required this.location,
    required this.rating,
    required this.distance,
    required this.images,  // Receiving the images list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display images of the property
              for (var image in images)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),

              // Property Details
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                location,
                style: TextStyle(color: AppColors.greyColor),
              ),
              const SizedBox(height: 8),

              // Property Rating and Distance
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 20,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text('$rating'),
                  const SizedBox(width: 8),
                  Text(distance),
                ],
              ),
              const SizedBox(height: 20),

              // Description Section
              const Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'This is a detailed description of the property. It provides all the necessary information to help potential buyers/renters make a decision.',
                style: TextStyle(color: AppColors.greyColor),
              ),
              const SizedBox(height: 20),

              // Book Now button
              ElevatedButton(
                onPressed: () {
                  // Booking logic
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // EMI Calculator button - Open Bottom Sheet
              ElevatedButton(
                onPressed: () {
                  // Show EMI Calculator as a bottom sheet
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // To control height of the bottom sheet
                    builder: (BuildContext context) {
                      return EMICalculatorPage(); // EMI Calculator page as bottom sheet
                    },
                  );
                },
                child: Text('EMI Calculator'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    // Validate and parse values from the text controllers
    double propertyPrice = double.tryParse(propertyPriceController.text) ?? 0.0;
    double downPayment = double.tryParse(downPaymentController.text) ?? 0.0;
    double loanAmount = propertyPrice - downPayment;
    double interestRate = double.tryParse(interestRateController.text) ?? 0.0;
    int loanTermMonths = int.tryParse(loanTermController.text) ?? 0;

    if (loanAmount <= 0 || interestRate <= 0 || loanTermMonths <= 0) {
      // Show a message if any required value is missing or invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter valid values for all fields.")),
      );
      return;
    }

    // Convert annual interest rate to monthly interest rate
    double monthlyInterestRate = interestRate / 12 / 100;

    // EMI calculation using the provided formula
    double emiValue = (loanAmount * monthlyInterestRate * pow((1 + monthlyInterestRate), loanTermMonths)) /
        (pow((1 + monthlyInterestRate), loanTermMonths) - 1);

    setState(() {
      emi = emiValue;  // Update the state to display the EMI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
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

            // Display EMI in a proper field
            if (emi > 0)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      'Your Monthly EMI: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${emi.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
