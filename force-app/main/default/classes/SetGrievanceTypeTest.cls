@isTest
public class SetGrievanceTypeTest {
 
    @isTest
    static void testHarassmentCase() {
        Case c = new Case(
            Origin = 'Email',
            Subject = 'Harassment Issue',
            Description = 'Employee harassment'
        );
        insert c;
 
        Case insertedCase = [SELECT Grievance_Type__c FROM Case WHERE Id = :c.Id];
        System.assertEquals('Harassment', insertedCase.Grievance_Type__c);
    }
 
    @isTest
    static void testPayrollCase() {
        Case c = new Case(
            Origin = 'Email',
            Subject = 'Payroll Delay',
            Description = 'Salary issue'
        );
        insert c;
 
        Case insertedCase = [SELECT Grievance_Type__c FROM Case WHERE Id = :c.Id];
        System.assertEquals('Payroll', insertedCase.Grievance_Type__c);
    }
 
    @isTest
    static void testPolicyCase() {
        Case c = new Case(
            Origin = 'Email',
            Subject = 'Policy Query',
            Description = 'HR policy'
        );
        insert c;
 
        Case insertedCase = [SELECT Grievance_Type__c FROM Case WHERE Id = :c.Id];
        System.assertEquals('Policy', insertedCase.Grievance_Type__c);
    }
 
    @isTest
    static void testOtherCase() {
        Case c = new Case(
            Origin = 'Email',
            Subject = 'Random Issue',
            Description = 'Something not matching'
        );
        insert c;
 
        Case insertedCase = [SELECT Grievance_Type__c FROM Case WHERE Id = :c.Id];
        System.assertEquals('Other', insertedCase.Grievance_Type__c);
    }
 
    @isTest
    static void testNonEmailOrigin() {
        Case c = new Case(
            Origin = 'Phone',
            Subject = 'Harassment',
            Description = 'Harassment case'
        );
        insert c;
 
        Case insertedCase = [SELECT Grievance_Type__c FROM Case WHERE Id = :c.Id];
        System.assertEquals(null, insertedCase.Grievance_Type__c);
    }
}