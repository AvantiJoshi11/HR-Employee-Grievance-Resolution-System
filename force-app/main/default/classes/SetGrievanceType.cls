@isTest
private class SetGrievanceType {
    @isTest
    static void testGrievanceTypeHarassment() {
        Case c = new Case(Subject='Harassment issue', Origin='Email', Status='New');
        insert c;
        System.assertEquals('Harassment', c.Grievance_Type__c);
    }

   
}