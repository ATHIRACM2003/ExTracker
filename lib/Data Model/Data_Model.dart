
//Creating a class user to store the data;
class Data_Model {
  final String id;
  int amount;
  final String type;
  final String note;
  final DateTime date;
  final String category;
  final String  budget_limit_value_send;

  Data_Model({
    required this.id,
    required this.amount,
    required this.type,
    required this.note,
    required this.date,
    required this.category,
    required this.budget_limit_value_send,
  });
}