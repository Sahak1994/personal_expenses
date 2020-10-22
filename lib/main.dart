import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Models
import 'package:personal_expenses/models/transaction.dart';

// Widgets
import 'package:personal_expenses/widgets/transaction_list.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';

void main() {
  // To turn off landscape mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
          button: TextStyle(
            color: Colors.white
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          )
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _userTransactions = [];

  List get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction({ String title, double amount, DateTime date}) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() => _userTransactions.add(newTx));
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext _) {
        return NewTransaction(
          addNewTransaction: _addNewTransaction,
        );
      },
    );
  }

  void _deleteTx(String id) {
    setState(() =>  _userTransactions.removeWhere((tx) => tx.id == id));
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    final transactionList = Container(
      height: (
        MediaQuery.of(context).size.height -appBar.preferredSize.height
        - MediaQuery.of(context).padding.top) * 0.7,
      child: TransactionList(_userTransactions, _deleteTx),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show/Hide Chart Bar', style: Theme.of(context).textTheme.headline6,),
                Switch(
                  value: _showChart,
                  onChanged: (bool val) => setState(() => _showChart = val),
                ),
              ],
            ),
            if (!isLandscape) Container(
              height: (
                MediaQuery.of(context).size.height - appBar.preferredSize.height
                  - MediaQuery.of(context).padding.top) * 0.3,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
            if (!isLandscape) transactionList,
            if (isLandscape) _showChart ? Container(
              height: (
                MediaQuery.of(context).size.height - appBar.preferredSize.height
                  - MediaQuery.of(context).padding.top) * 0.7,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ) : transactionList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
