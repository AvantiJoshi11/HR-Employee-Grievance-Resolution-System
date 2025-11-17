@isTest
public class CaseOwnerChangeTrigger {
 
    @isTest
    static void testCaseOwnerChangedCreatesAction() {
 
        // Create 2 Users
        User u1 = new User(
            FirstName = 'Test',
            LastName = 'User1',
            Email = 'user1@test.com',
            Username = 'user1@test.com',
            Alias = 'u1',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
            LanguageLocaleKey = 'en_US'
        );
        insert u1;
 
        User u2 = new User(
            FirstName = 'Test',
            LastName = 'User2',
            Email = 'user2@test.com',
            Username = 'user2@test.com',
            Alias = 'u2',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            ProfileId = u1.ProfileId,
            LanguageLocaleKey = 'en_US'
        );
        insert u2;
 
        // Create Case owned by u1
        Case c = new Case(
            Subject = 'Test Case',
            Status = 'New',
            Origin = 'Phone',
            OwnerId = u1.Id
        );
        insert c;
 
        // Change owner to u2
        c.OwnerId = u2.Id;
 
        Test.startTest();
        update c;
        Test.stopTest();
 
        // Validate Grievance Action was created
        Grievance_Action__c action = [
            SELECT Id, Notes__c 
            FROM Grievance_Action__c 
            WHERE Case__c = :c.Id
            LIMIT 1
        ];
 
        System.assertNotEquals(null, action, 'Action should be created');
        System.assertEquals(
            'Case reassigned to ' + u2.Name, 
            action.Notes__c, 
            'Notes should match'
        );
    }
 
 
    @isTest
    static void testOwnerNotChangedNoActionCreated() {
 
        User u = new User(
            FirstName = 'Test',
            LastName = 'User3',
            Email = 'user3@test.com',
            Username = 'user3@test.com',
            Alias = 'u3',
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
            LanguageLocaleKey = 'en_US'
        );
        insert u;
 
        // Create Case
        Case c = new Case(
            Subject = 'Test Case 2',
            Status = 'New',
            Origin = 'Phone',
            OwnerId = u.Id
        );
        insert c;
 
        // Update something else but NOT Owner
        c.Status = 'Working';
 
        Test.startTest();
        update c;
        Test.stopTest();
 
        // No action should be created
        Integer countActions = [
            SELECT COUNT() 
            FROM Grievance_Action__c 
            WHERE Case__c = :c.Id
        ];
 
        System.assertEquals(0, countActions, 'Action should NOT be created');
    }
}
 