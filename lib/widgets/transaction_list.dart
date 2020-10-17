import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// models
import 'package:personal_expenses/models/transaction.dart';



class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430.0,
      padding: EdgeInsets.only(top: 10.0),
      child: transactions.isEmpty ? Column(
        children: <Widget>[
          Text('No transaction added yet!', 
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20.0,),
          Container(
            height: 200.0,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Card(
            elevation: 5.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text(
                      '\$${transactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                 DateFormat.yMMMd().format(transactions[index].date),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx( transactions[index].id),
              ),
            ),
          );
        },
      ),
    );
  }
}