class CartItem{
  final String name;
  final int quantity;
  final num price;

  CartItem(this.name, this.quantity, this.price);
}

class OrderLine{
  final String name;
  final num price;

  OrderLine(this.name, this.price);
}

class Address {
  final String country;
  final String streetAddress;

  Address(this.country, this.streetAddress);
}

class Order{
  final List<OrderLine> line;
  final num totalPrice;
  final Address billing;
  final Address shipping;

  Order(this.line, this.totalPrice, {required this.billing, required this.shipping});
}

final shoppingCart = [
  CartItem('Motherboard', 1, 750),
  CartItem('CPU', 1, 1999.95),
  CartItem('Memory', 4, 463.11),
  CartItem('SSD', 1, 2000)
];

main(){
  final orderLines = shoppingCart.expand((item) => List.generate(item.quantity, (_) => OrderLine(item.name, item.price)));

  final totalPrice = orderLines.map((line) => line.price).reduce((value, element) => value + element);

  final order = Order(orderLines.toList(), totalPrice, billing: Address('Denmark','Spangsbjerg Kirkevej'), shipping: Address('Denmark','Nielsbohrsvej'));

}