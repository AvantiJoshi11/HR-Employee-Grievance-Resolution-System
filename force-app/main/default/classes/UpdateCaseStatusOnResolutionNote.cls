@isTest
private class UpdateCaseStatusOnResolutionNote {
    @isTest
    static void testUpdateStatus() {
        Case c = new Case(Subject='Resolution Test', Status='New');
        insert c;

        c.Resolution_Note__c = 'Closed the case as per policy';
        update c;

        System.assertEquals('Closed', c.Status);
    }
}