main(){
  //print("hello world");

  final someList = [1,2,3,4,5];
  final someOtherList = [6,7,8,9,10];


  //reduce function

  final total = someList.reduce((value, element) => value+element);
  print(total);


  /*
  //expand function

  final List<List<int>> nestedList = [someList, someOtherList];

  final expandedList = nestedList.expand((element) => element);

  for(var e in expandedList){
    print("number: "+e.toString());
  }
   */




}
