@isTest
private class SetGrievanceType {
    @isTest
    static void testGrievanceTypeHarassment() {
        Case c = new Case(Subject='Harassment issue', Origin='Email', Status='New');
        insert c;
        System.assertEquals('Harassment', c.Grievance_Type__c);
    }

    @isTest
    static void testGrievanceTypePayroll() {
        Case c = new Case(Subject='Payroll query', Origin='Email', Status='New');
        insert c;
        System.assertEquals('Payroll', c.Grievance_Type__c);
    }
}