@isTest
private class SObjectComparableTest {

  private static List<Account> accounts;

	static testMethod void testSObjectComparable() {
    initTestData();

    Test.startTest();

    List<SObjectComparable> comparableList = new List<SObjectComparable>();

    for (Account a : accounts) {
      comparableList.add(new SObjectComparable(a, 'Name'));
    }

    comparableList.sort();

    String previousName;

    for (SObjectComparable sc : comparableList) {
      if (!String.isBlank(previousName)) {
        System.assertEquals(true,
          ((Account) sc.getObjectToSort()).Name >= previousName);
      }
      
      previousName = ((Account) sc.getObjectToSort()).Name;
    }

    Test.stopTest();
  }

  private static void initTestData() {
    accounts = new List<Account>();

    for (Integer i = 0; i < 100; i++) {
      accounts.add(TestUtils.createAccount());
    }

    for (Integer i = 0; i < 100; i++) {
      accounts.add(accounts[i].clone(false, true, false, false));
    }

    insert accounts;
  }
}