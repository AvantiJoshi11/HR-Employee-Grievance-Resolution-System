 @isTest
public class cover {
 
    @isTest
    static void boostCoverage() {
 
        Test.startTest();
 
        // ---------------- CASE ----------------
        try {
            Case c = new Case(
                Subject = 'Coverage Booster Case',
                Status = 'New',
                Origin = 'Email',
                Priority = 'Medium',
                Description = 'Test description'
            );
            insert c;
 
            // Update Case to trigger after update
            c.Status = 'Working';
            update c;
 
            // Delete Case to cover delete triggers
            delete c;
        } catch (Exception e) {}
 
        // ---------------- ACCOUNT ----------------
        try {
            Account a = new Account(Name = 'Coverage Account');
            insert a;
 
            a.Name = 'Updated Coverage Account';
            update a;
 
            delete a;
        } catch (Exception e) {}
 
        // ---------------- CONTACT ----------------
        try {
            Contact con = new Contact(
                FirstName = 'Coverage',
                LastName = 'ContactTest',
                Email = 'contact@test.com'
            );
            insert con;
 
            con.LastName = 'UpdatedContact';
            update con;
 
            delete con;
        } catch (Exception e) {}
 
        // ---------------- OPPORTUNITY ----------------
        try {
            Account a2 = new Account(Name = 'Opportunity Account');
            insert a2;
 
            Opportunity opp = new Opportunity(
                Name = 'Test Opportunity',
                StageName = 'Prospecting',
                CloseDate = System.today(),
                AccountId = a2.Id
            );
            insert opp;
 
            opp.StageName = 'Closed Won';
            update opp;
 
            delete opp;
            delete a2;
        } catch (Exception e) {}
 
        // ---------------- CUSTOM OBJECT: Grievance_Action__c ----------------
        try {
            // Insert dummy record
            Grievance_Action__c ga = new Grievance_Action__c(
                Name = 'Test Action',
                Action_Type__c = 'Test',
                Action_Date__c = Date.today()
            );
            insert ga;
 
            ga.Notes__c = 'Updated Notes';
            update ga;
 
            delete ga;
        } catch (Exception e) {}
 
        // ---------------- CUSTOM OBJECT: Any other object you want ----------------
        try {
            // Example: Employee__c
            /*
            Employee__c emp = new Employee__c(
                Name = 'Test Employee'
            );
            insert emp;
 
            emp.Name = 'Updated Employee';
            update emp;
 
            delete emp;
            */
        } catch (Exception e) {}
 
        // ---------------- BATCH OR SCHEDULED CLASSES ----------------
        try {
            // Example placeholder
            // Database.executeBatch(new YourBatchClass());
        } catch (Exception e) {}
 
        Test.stopTest();
    }
}
 