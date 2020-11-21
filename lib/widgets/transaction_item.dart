import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final bool isPortrait;
  final Function deleteTx;
  
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.isPortrait,
    @required this.deleteTx,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _color;

  @override
  void initState() {
    const colors = [
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.lightBlue,
    ];

    _color = colors[Random().nextInt(4)];
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: _color,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
           DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: widget.isPortrait ? IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTx( widget.transaction.id),
        ) : FlatButton.icon(
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
          textColor: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTx( widget.transaction.id),
        ),
      ),
    );
  }
}