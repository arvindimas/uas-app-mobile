import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/color_palette.dart';

class IncomeComponent extends StatelessWidget {
  final Map<String, dynamic> transaction;

  IncomeComponent({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return _buildTransactionItem(transaction, ColorPalette.green20, ColorPalette.green60);
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction, Color cardColor, Color iconColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          // Handle tapping on the income item if needed.
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Display relevant information about the income transaction.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['description'],
                      style: TextStyle(
                        color: ColorPalette.dark100,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Rp ${transaction['amount']}",
                      style: TextStyle(
                        color: ColorPalette.dark100,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${_formatDate(transaction['created_at'])}",
                      style: TextStyle(
                        color: ColorPalette.dark100,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: ColorPalette.yellow100,
                    ),
                    onPressed: () async {
                      // Handle editing the income.
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: ColorPalette.red100,
                    ),
                    onPressed: () async {
                      // Handle deleting the income.
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
  }
}
