
import 'dart:async';
import 'package:http/http.dart' as http;
// TODO check how I got binance key and if this still works
final String binance_API_KEY = ""; // rigister at 
main(){

  getCoins();

}

class CoinAPI {
  final String name;
  final String symbol;
  final String rank;
  final String priceUSD;
  final  String weakpntchange;
  CoinAPI.fromJson(Map jsonMap):
        name = jsonMap['name'],
        symbol = jsonMap['symbol'],
        rank = jsonMap['rank'],
        priceUSD = jsonMap['price_usd'],
        weakpntchange = jsonMap['percent_change_7d'];

  String toString() => 'Coin: $name $symbol $weakpntchange';
}
Future<Stream<CoinAPI>> getCoins() async {
  var url = 'https://rest.coinapi.io/v1/exchangerate/USD?time=2018-03-01&apikey='+binance_API_KEY;

  /* http.get(url).then(
      (res) => print(res.body)
  );*/

  var client = new http.Client(
  );
  var streamedRes = await client.send(
      new http.Request('get', Uri.parse(url))
  );

  return streamedRes.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((jsonBody) => (jsonBody as List) )
      .map((jsonCoin) => CoinAPI.fromJson(jsonCoin));

}