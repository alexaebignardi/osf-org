@IsTest
private class PermissionsTests {
  
  @TestSetup
  static void testSetup() {
    // GIVEN: Create an Account and a Private_Object__c record linked to it
    Account acct = TestFactory.getAccount('No view For You!', true);
    Private_Object__c privateObj = new Private_Object__c(Account__c = acct.Id, Notes__c = 'foo');
    insert privateObj;
  }
  
  @IsTest
  static void testNegativePermissionSet() {
    // GIVEN: Create a standard user without the permission set
    User userNew = TestFactory.generateUser('Standard User');
    System.runAs(userNew) {
      // WHEN: Query Private_Object__c records
      Test.startTest();
        Private_Object__c[] privateObj = [SELECT Id, Account__c, Notes__c FROM Private_Object__c];
      Test.stopTest();
      // THEN: Assert user cannot see any records
      System.assertEquals(
        0,
        privateObj.size(),
        'A user without the permission set shouldn\'t see any records');
    }
  }
  
  @IsTest
  static void testPositivePermissionSet() {
    // GIVEN: Create a standard user
    User userWithPerm = TestFactory.generateUser('Standard User');
    
    // Retrieve the permission set that grants "view all" on Private_Object__c
    PermissionSet permSet = [
      SELECT Id
      FROM PermissionSet
      WHERE Name = 'Private_Object_Access'
      LIMIT 1
    ];
    
    // Assign the permission set to the user
    insert new PermissionSetAssignment(
      AssigneeId = userWithPerm.Id,
      PermissionSetId = permSet.Id
    );
    
    System.runAs(userWithPerm) {
      // WHEN: Query Private_Object__c records
      Test.startTest();
        Private_Object__c[] privateObjs = [SELECT Id, Account__c, Notes__c FROM Private_Object__c];
      Test.stopTest();
      
      // THEN: Assert user can see at least one record
      System.assert(privateObjs.size() > 0, 'User with Private_Object_Access should see Private_Object__c records');
    }
  }
}
