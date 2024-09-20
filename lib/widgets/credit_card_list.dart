import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/widgets/card_list_item.dart';

class CreditCardListWidget extends StatelessWidget {
  final List<DocumentSnapshot> cardList;
  final int? selectedCard;
  final ValueChanged<int?> onCardSelected;

  const CreditCardListWidget({
    Key? key,
    required this.cardList,
    required this.selectedCard,
    required this.onCardSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: cardList.length,
        itemBuilder: (context, index) {
          final cardData = cardList[index].data() as Map<String, dynamic>;
          final cardNumber = cardData['cardNumber'] ?? 'Unknown';

          return InkWell(
            onTap: () {
              onCardSelected(index);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Card(
                color: Colors.white,
                elevation: 5,
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/master_card.png',
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: const Text(
                    'Credit card',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    formatCardNumber(cardNumber),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.orange,
                    ),
                  ),
                  trailing: Radio<int>(
                    value: index,
                    groupValue: selectedCard,
                    onChanged: (int? value) {
                      onCardSelected(value);
                    },
                    activeColor: Colors.orange,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
