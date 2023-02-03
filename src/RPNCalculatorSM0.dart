import 'dart:io';

List<num> calculatorStack = <num>[];
var operatorsAccepted = ['+','-','/','*'];

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

abstract class Calculator{
  var result;
  calculate();
}

main(){
  print('Welcome to the RPN Calculator');
  while(true){
    String input = stdin.readLineSync() ?? '';
    if(!isNumeric(input) && !operatorsAccepted.contains(input)){
      print('please insert a valid number');
    }else{
      if(isNumeric(input)){
        calculatorStack.add(num.parse(input));
        print('Number added to the stack, the actual stack is:');
        print(calculatorStack.toString());
      }else{

        print('Operation done. The actual stack is:');
        print(calculatorStack.toString());
      }
    }
  }
}




