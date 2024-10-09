import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_ordering_app/widgets/card_number_input_formatter.dart';
import 'package:food_ordering_app/widgets/show_snack_bar.dart';

class AddCardForm extends StatefulWidget {
  final void Function(
    String cardImage, // تعديل هنا لتمرير نوع البطاقة
    String cardNumber,
    String expiryDate,
  ) onAddCard;

  const AddCardForm({super.key, required this.onAddCard});

  @override
  State<AddCardForm> createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _selectedCardType = 'Credit Card'; // لتخزين نوع البطاقة المختار

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final cardNumber = _cardNumberController.text.replaceAll(' ', '');
      final expiryDate = _expiryDateController.text;

      // تحديد صورة البطاقة بناءً على الاختيار
      String cardImage;
      if (_selectedCardType == 'Visa') {
        cardImage = 'assets/images/visa_image.png'; // صورة الفيزا
      } else {
        cardImage = 'assets/images/master_card.png'; // صورة الكريدت كارد
      }

      customShowSnackBar(
          context: context, content: 'New Card Added Successfully');

      widget.onAddCard(cardImage, cardNumber, expiryDate);
      Navigator.of(context).pop();
    }
  }

  void _showCardNumberErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid Card Number'),
          content: const Text(
            'Card number must be exactly 16 digits.',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedCardType = 'Credit Card';
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: _selectedCardType == 'Credit Card'
                      ? Colors.orange
                      : Colors.white,
                  side: const BorderSide(color: Colors.orange),
                ),
                child: Text(
                  'Credit Card',
                  style: TextStyle(
                    color: _selectedCardType == 'Credit Card'
                        ? Colors.white
                        : Colors.orange,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedCardType = 'Visa';
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: _selectedCardType == 'Visa'
                      ? Colors.orange
                      : Colors.white,
                  side: const BorderSide(color: Colors.orange),
                ),
                child: Text(
                  'Visa',
                  style: TextStyle(
                    color: _selectedCardType == 'Visa'
                        ? Colors.white
                        : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _cardNumberController,
            decoration: const InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.orange,
                ),
                labelText: 'Card Number'),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CardNumberInputFormatter(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter card number';
              }
              if (value.replaceAll(' ', '').length != 16) {
                _showCardNumberErrorDialog();
                return 'Card number must be exactly 16 digits';
              }
              return null;
            },
          ),
          TextFormField(
            cursorColor: Colors.black,
            controller: _expiryDateController,
            decoration: const InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.orange,
                ),
                labelText: 'Expiry Date (MM/YY)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter expiry date';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text(
              'Add Card',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
