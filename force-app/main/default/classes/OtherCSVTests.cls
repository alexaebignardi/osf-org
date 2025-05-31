@isTest
private class OtherCSVTests {

    @TestSetup
    static void setup() {
        // Load Accounts from the static resource CSV
        Test.loadData(Account.sObjectType, 'otherAccountData');
    }

    @isTest
    static void testLoadOtherAccountsFromStaticResource() {
        // Start test context
        Test.startTest();

        // Query the accounts loaded by @TestSetup
        List<Account> accounts = [SELECT Id FROM Account];

        // End test context
        Test.stopTest();

        // Assert exactly 15 accounts were loaded from the CSV
        System.assertEquals(15, accounts.size(), 'Exactly 15 accounts should have been loaded from CSV.');
    }
}
