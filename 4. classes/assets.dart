abstract class Asset {
  double getValue();
}

mixin class HasLocation { //IMP: Should have been only mixin, and not a class.
  printLocation(String location){
    print('Current location: $location');
  }
}

class Stock extends Asset{
  final String symbol;
  final int quantity;
  final double pricePerShare;

  Stock({
    required this.symbol,
    required this.quantity,
    required this.pricePerShare
  });

  @override 
  double getValue(){
    return this.pricePerShare*this.quantity;
  }
}

class RealEstate extends Asset with HasLocation{
  final double marketValue;
  
  RealEstate({required this.marketValue});

  @override
  double getValue(){
    return this.marketValue;
  }
}

void main(){
  Stock google = Stock(symbol: 'GOOG',quantity:  50,pricePerShare:  200);
  RealEstate house = RealEstate(marketValue: 200);

  List<Asset> assets = [];
  assets.add(google);
  assets.add(house);

  for (Asset asset in assets){
    print('${asset.getValue()}');
  }

  print('${house.printLocation('NCL')}'); /*IMP: Should have only called the method as it directly prints. 
  Putting it inside a print statement is causing itto also print null as the method returns null*/

}