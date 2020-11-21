import 'package:flutter/material.dart';

// models
import 'package:personal_expenses/models/transaction.dart';

// Widgets
import 'package:personal_expenses/widgets/transaction_item.dart';



class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: transactions.isEmpty ? LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Text('No transaction added yet!', 
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20.0),
              Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      ) : ListView(
        children: transactions.map((tx) {
          return TransactionItem(
            key: ValueKey(tx.id),
            transaction: tx,
            isPortrait: isPortrait,
            deleteTx: deleteTx,
          );
        }).toList(),
      ),
    );
  }
}
