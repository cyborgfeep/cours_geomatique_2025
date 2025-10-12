class Transaction {
  String name;
  int amount;
  DateTime dateTime;
  TransactionType type;

  Transaction({
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.type,
  });
}

enum TransactionType { retrait, depot, paiement, envoi, reception }
