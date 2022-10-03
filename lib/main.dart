import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
          fontFamily: 'Quicksand',
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: const TextStyle(
              color: Colors.white,
            ),
          ),
          appBarTheme: AppBarTheme(
              toolbarTextStyle: ThemeData
                  .light()
                  .textTheme
                  .
              headline6
                  ?.merge(const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.amber),
        ), title: 'Personal Expenses'
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];

  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    print(appLifecycleState);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime(
        DateTime
            .now()
            .year,
        DateTime
            .now()
            .month,
        DateTime
            .now()
            .day,
      ).subtract(
        const Duration(
          days: 7,
        ),
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    print(context);
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions
          .removeWhere((Transaction transaction) => transaction.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(ThemeData theme,
      Widget transactionListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: theme.textTheme.headline6,
          ),
          Switch.adaptive(
              activeColor: theme.colorScheme.secondary,
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              }),
        ],
      ),
      transactionListWidget
    ];
  }

  List<Widget> _buildPortaitContent(MediaQueryData mediaQuery, AppBar appBar,
      Widget transactionListWidget) {
    return [
      SizedBox(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      transactionListWidget,
    ];
  }

  PreferredSizeWidget _buildCupertinoNavigationBar(String title,
      Function addNewTransaction) {
    return CupertinoNavigationBar(
      middle: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: const Icon(CupertinoIcons.add),
            onTap: () => addNewTransaction,
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String title, Function addNewTransaction) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => addNewTransaction,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build() MyHomePageState');
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData theme = Theme.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    const String title = 'Personal Expenses';
    final PreferredSizeWidget appBar = Platform.isIOS
        ? _buildCupertinoNavigationBar(
        title, () => _startAddNewTransaction(context))
        : _buildAppBar(title, () => _startAddNewTransaction(context));
    final Widget transactionListWidget = SizedBox(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_transactions, _deleteTransaction),
    );
    final Widget pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(
                theme,
                transactionListWidget,
              ),
            if (!isLandscape)
              ..._buildPortaitContent(
                mediaQuery,
                appBar as AppBar,
                transactionListWidget,
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
      navigationBar: appBar as ObstructingPreferredSizeWidget?,
      child: pageBody,
    )
        : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
