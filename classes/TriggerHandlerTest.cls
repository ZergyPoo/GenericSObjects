@isTest
private class TriggerHandlerTest {
	static testMethod void testTriggerHandler() {
    Test.startTest();

    TriggerHandler.createTasksForObjects(null);

    List<Account> accounts = new List<Account>();

    for (Integer i = 0; i < 100; i++) {
      accounts.add(TestUtils.createAccount());
    }

    insert accounts;

    Map<Id, Account> accountMap = new Map<Id, Account>(accounts);

    List<Task> tasks =
      [select Id,
              WhatId
       from Task
       where WhatId in :accountMap.keySet()];

    System.assertEquals(accounts.size(), tasks.size());

    Test.stopTest();
  }
}