import 'dart:io';
import 'dart:js_util';

enum operationType { SUM, SUBTRACT, MULTIPLY, DIVIDE }

class Calculator {
  List<num> numbers = [];
  List<num> lastOperation = [];
  operationType lastOperationType = operationType.SUM;

  void operate(operationType type) {
    switch (type) {
      case operationType.SUM:
        numbers.add(getFirstTwoOfStack(numbers)
            .reduce((value, element) => value + element));
        numbers.removeRange(numbers.length - 3, numbers.length - 2);
        printStack(numbers);
        lastOperationType = operationType.SUM;
        break;
      case operationType.SUBTRACT:
        numbers.add(getFirstTwoOfStack(numbers)
            .reduce((value, element) => value - element));
        numbers.removeRange(numbers.length - 3, numbers.length - 2);
        printStack(numbers);
        lastOperationType = operationType.SUBTRACT;
        break;
      case operationType.MULTIPLY:
        numbers.add(getFirstTwoOfStack(numbers)
            .reduce((value, element) => value * element));
        numbers.removeRange(numbers.length - 3, numbers.length - 2);
        printStack(numbers);
        lastOperationType = operationType.MULTIPLY;
        break;
      case operationType.DIVIDE:
        numbers.add(getFirstTwoOfStack(numbers)
            .reduce((value, element) => value / element));
        numbers.removeRange(numbers.length - 3, numbers.length - 2);
        printStack(numbers);
        lastOperationType = operationType.DIVIDE;
        break;
    }
  }
}

List<num> getFirstTwoOfStack(List<num> list) {
  var reversed = list.reversed;
  return new List.from(reversed.take(2));
}

void printStack(List<num> stack) {
  print("Operation done. The resulting stack is: " + stack.toString());
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