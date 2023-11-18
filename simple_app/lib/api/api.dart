class Api {
  Api();

  static const String baseUrl = 'https://peanut.ifxdb.com';

  static const String login = '$baseUrl/api/ClientCabinetBasic/IsAccountCredentialsCorrect';
  static const String accountInfo = '$baseUrl/api/ClientCabinetBasic/GetAccountInformation';
  static const String phoneNumber = '$baseUrl/api/ClientCabinetBasic/GetLastFourNumbersPhone';
  static const String openTrades = '$baseUrl/api/ClientCabinetBasic/GetOpenTrades';

}