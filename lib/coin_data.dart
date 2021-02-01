import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC', // Bitcoin
  'ETH', // Etherium
  'LTC', // LiteCoin
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '50FD9B0C-A25B-43A1-AFEF-71ED8A877ADD';

class CoinData {
  // Create the Asynchronous method getCoinData() that returns a Future
  // (the price data)
  Future getCoinData(String selectedCurrency) async {
    // Create a URL combining the coinAPIURL with the currencies we're
    // interested in, BTC to USD
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      // Make a GET Request to the URL and wait for response
      http.Response response = await http.get(requestURL);
      // Check that the request was successful
      if (response.statusCode == 200) {
        // Use the 'data:convert' package to decose the JSON data that comes
        // back from the coinapi.io
        var decodedData = jsonDecode(response.body);
        // Get the last price of Bitcoin with the key 'last'
        double lastPrice = decodedData['rate'];
        // Output last price from the method

        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        // Handle any errors that occur during the request
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
