import 'dart:io';

enum operationType { SUM, SUBTRACT, MULTIPLY, DIVIDE, UNDO }
var operatorsAccepted = ['+','-','/','*','undo'];

class Calculator {
  List<num> numbers = [];
  List<num> lastOperation = [];
  List<num> numbersToUndo = [];
  operationType lastOperationType = operationType.UNDO;

  void operate(operationType type) {
    switch (type) {
      case operationType.SUM:
        numbers.add(getFirstTwoOfStack(numbers)
            .reduce((value, element) => value + element));
        numbersToUndo.addAll(numbers.reversed.take(2));
        numbersToUndo.clear();
        numbers.removeRange(numbers.length - 3, numbers.length - 1);
        printStack(numbers);
        lastOperationType = operationType.SUM;
        break;
      case operationType.SUBTRACT:
        numbers.add(getFirstTwoOfStack(numbers)
            .reduce((value, element) => value - element));
        numbers.removeRange(numbers.length - 3, numbers.length - 1);
        numbersToUndo.clear();
        numbersToUndo.addAll(numbers.reversed.take(2));
        printStack(numbers);
        lastOperationType = operationType.SUBTRACT;
        break;
      case operationType.MULTIPLY:
        numbers.add(getFirstTwoOfStack(numbers)
            .reduce((value, element) => value * element));
        numbers.removeRange(numbers.length - 3, numbers.length - 1);
        numbersToUndo.clear();
        numbersToUndo.addAll(numbers.reversed.take(2));
        printStack(numbers);
        lastOperationType = operationType.MULTIPLY;
        break;
      case operationType.DIVIDE:
        numbers.add(getFirstTwoOfStack(numbers)
            .reduce((value, element) => value / element));
        numbers.removeRange(numbers.length - 3, numbers.length - 1);
        numbersToUndo.clear();
        numbersToUndo.addAll(numbers.reversed.take(2));
        printStack(numbers);
        lastOperationType = operationType.DIVIDE;
        break;
      case operationType.UNDO:
        if(lastOperationType == operationType.UNDO){
          print('Not able to UNDO, you can only undo your last operation :(');
          printStackND(numbers);
        }else{
          numbers.removeLast();
          numbers.addAll(numbersToUndo);
          printStack(numbers);
          lastOperationType = operationType.UNDO;
        }
    }
  }
}

List<num> getFirstTwoOfStack(List<num> list) {
  return new List.from(list.reversed.take(2));
}

void printStack(List<num> stack) {
  print("Operation done. The resulting stack is: " + stack.toString());
}

void printStackND(List<num> stack) {
  print("The resulting stack is: " + stack.toString());
}
abstract class Command implements Function {
  void act();
}

class Sum implements Command {
  Calculator calculator;

  Sum(this.calculator);

  void act() {
    calculator.operate(operationType.SUM);
  }
}

class Subtract implements Command {
  Calculator calculator;

  Subtract(this.calculator);

  void act() {
    calculator.operate(operationType.SUBTRACT);
  }
}

class Multiply implements Command {
  Calculator calculator;

  Multiply(this.calculator);

  void act() {
    calculator.operate(operationType.MULTIPLY);
  }
}

class Divide implements Command {
  Calculator calculator;

  Divide(this.calculator);

  void act() {
    calculator.operate(operationType.DIVIDE);
  }
}

class Undo implements Command {
  Calculator calculator;

  Undo(this.calculator);

  void act() {
    calculator.operate(operationType.UNDO);
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

void main(){
  print('Welcome to the RPN Calculator made by Sergio');
  final calculator = new Calculator();

  while(true){
    String input = stdin.readLineSync() ?? '';
    input.toLowerCase();
    if(!isNumeric(input) && !operatorsAccepted.contains(input)){
      print('please insert a valid number');
    }else{
      if(isNumeric(input)){
        calculator.numbers.add(num.parse(input));
        printStack(calculator.numbers);
      }else{
        switch(input){
          case '+':
            new Sum(calculator).act();
            break;
          case '-':
            new Subtract(calculator).act();
            break;
          case '*':
            new Multiply(calculator).act();
            break;
          case '/':
            new Divide(calculator).act();
            break;
          case 'undo':
            new Undo(calculator).act();
            break;
        }
      }
    }
  }
}