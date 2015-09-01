@isTest
private class SObjectWsTest {
	static testMethod void testSObjectWs() {
    Test.startTest();

    JSONParser parser;

    System.RestContext.request = new RestRequest();
    System.RestContext.response = new RestResponse();

    List<Account> accounts = new List<Account>();

    for (Integer i = 0; i < 100; i++) {
      accounts.add(TestUtils.createAccount());
    }

    System.RestContext.request.requestBody =
      Blob.valueOf(JSON.serialize(accounts));

    System.RestContext.request.requestURI =
      '/' + Account.SObjectType.getDescribe().getName();

    SObjectWs.httpPost();

    parser = JSON.createParser(
      System.RestContext.response.responseBody.toString());

    List<Account> results =
      (List<Account>) parser.readValueAs(List<Account>.class);

    System.assertEquals(accounts.size(), results.size());

    for (Account a : results) {
      System.assertNotEquals(null, a.Id);
    }

    Test.stopTest();
  }
}