import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';

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
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
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

  void _startAddNewTransaction() {
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

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery,
      AppBar appBar,
      ThemeData theme,
      Widget transactionListWidget,
      ) {
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
      if (_showChart)
        SizedBox(
          height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
              0.7,
          child: Chart(_recentTransactions),
        ),
      transactionListWidget
    ];
  }

  List<Widget> _buildPortaitContent(
      MediaQueryData mediaQuery,
      AppBar appBar,
      Widget transactionListWidget,
      ) {
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

  PreferredSizeWidget _buildCupertinoNavigationBar(
      String title, VoidCallback addNewTransaction) {
    return CupertinoNavigationBar(
      middle: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: addNewTransaction,
            child: const Icon(CupertinoIcons.add),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      String title, VoidCallback addNewTransaction) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: addNewTransaction,
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
        ? _buildCupertinoNavigationBar(title, _startAddNewTransaction)
        : _buildAppBar(title, _startAddNewTransaction);
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
                mediaQuery,
                appBar as AppBar,
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
        onPressed: _startAddNewTransaction,
        child: const Icon(Icons.add),
      ),
    );
  }
}