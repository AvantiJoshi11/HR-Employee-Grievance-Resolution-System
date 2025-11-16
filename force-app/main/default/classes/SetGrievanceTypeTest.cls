@isTest
public class SetGrievanceTypeTest {
    
    @isTest
    static void testHarassmentCase() {
        Case c = new Case(
            Origin = 'Email',
            Subject = 'Harassment issue in workplace',
            Description = 'Employee reported harassment by manager',
            Status = 'New'
        );
        insert c;
        System.assertEquals('Harassment', c.Grievance_Type__c, 'Grievance type should be Harassment');
    }
    
    @isTest
    static void testPayrollCase() {
        Case c = new Case(
            Origin = 'Email',
            Subject = 'Payroll discrepancy',
            Description = 'Salary not credited properly',
            Status = 'New'
        );
        insert c;
        System.assertEquals('Payroll', c.Grievance_Type__c, 'Grievance type should be Payroll');
    }
    
    @isTest
    static void testPolicyCase() {
        Case c = new Case(
            Origin = 'Email',
            Subject = 'Policy clarification',
            Description = 'Need clarification on leave policy',
            Status = 'New'
        );
        insert c;
        System.assertEquals('Policy', c.Grievance_Type__c, 'Grievance type should be Policy');
    }
    
    @isTest
    static void testOtherCase() {
        Case c = new Case(
            Origin = 'Email',
            Subject = 'General query',
            Description = 'No specific keyword',
            Status = 'New'
        );
        insert c;
        System.assertEquals('Other', c.Grievance_Type__c, 'Grievance type should be Other');
    }
    
    @isTest
    static void testNonEmailOrigin() {
        Case c = new Case(
            Origin = 'Web',
            Subject = 'Payroll issue',
            Description = 'Salary issue',
            Status = 'New'
        );
        insert c;
        System.assertEquals(null, c.Grievance_Type__c, 'Grievance type should not be set for non-email origin');
    }
}