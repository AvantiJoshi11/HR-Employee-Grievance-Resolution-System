@isTest
public class GrievanceControllerTest {
    
    @isTest
    static void testGetCaseStatsAndDistribution() {
        // Insert sample Cases
        Case c1 = new Case(Origin='Email', Status='New', Grievance_Type__c='Payroll');
        Case c2 = new Case(Origin='Email', Status='Closed', Grievance_Type__c='Harassment');
        Case c3 = new Case(Origin='Email', Status='New', Grievance_Type__c='Policy', SLA_Due_Date__c=Date.today().addDays(-1));
        insert new List<Case>{c1, c2, c3};
        
        Test.startTest();
        Map<String, Integer> stats = GrievanceController.getCaseStats();
        System.assert(stats.containsKey('open'), 'Stats should include open cases');
        System.assert(stats.containsKey('closed'), 'Stats should include closed cases');
        System.assert(stats.containsKey('slaBreached'), 'Stats should include SLA breached cases');
        
        List<Map<String, Object>> distribution = GrievanceController.getGrievanceTypeDistribution();
        System.assertEquals(3, distribution.size(), 'Distribution should have 3 grievance types');
        Test.stopTest();
    }
}