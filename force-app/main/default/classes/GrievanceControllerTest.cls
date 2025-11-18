@isTest
public class GrievanceControllerTest {

    @testSetup
    static void setupData() {
        // Use valid picklist values from your org
        List<Case> cases = new List<Case>{
            new Case(Subject='Open Case 1', Status='New', Origin='Phone', Grievance_Type__c='Harassment'),
            new Case(Subject='Open Case 2', Status='Working', Origin='Email', Grievance_Type__c='Payroll'),
            new Case(Subject='Closed Case', Status='Closed', Origin='Web', Grievance_Type__c='Policy')
        };
        insert cases;
    }

    @isTest
    static void testGetCaseStats() {
        Test.startTest();
        Map<String, Integer> stats = GrievanceController.getCaseStats();
        Test.stopTest();

        System.assertNotEquals(null, stats);
        System.assert(stats.containsKey('open'));
        System.assert(stats.containsKey('closed'));
        System.assert(stats.containsKey('slaBreached'));

        System.assertEquals(2, stats.get('open'));
        System.assertEquals(1, stats.get('closed'));
        System.assertEquals(0, stats.get('slaBreached'));
    }

    
}