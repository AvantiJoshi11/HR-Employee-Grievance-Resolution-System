@isTest
private class CaseOwnerChangeTrigger {
    @isTest
    static void testCaseOwnerChange() {
        // Create a Case
        Case c = new Case(Subject='Test Case', Status='New');
        insert c;

        // Change Owner to trigger logic
        User u = [SELECT Id FROM User WHERE IsActive = TRUE LIMIT 1];
        c.OwnerId = u.Id;
        update c;

        // Verify Grievance_Action__c record created
        Grievance_Action__c action = [SELECT Action_Type__c, Notes__c FROM Grievance_Action__c WHERE Case__c = :c.Id LIMIT 1];
        System.assertEquals('Reassignment', action.Action_Type__c);
        System.assert(action.Notes__c.contains(u.Name));
    }
}