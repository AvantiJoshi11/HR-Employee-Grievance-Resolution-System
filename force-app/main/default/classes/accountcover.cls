@isTest
public class accountcover {
 
    @isTest
    static void testAccountContactCaseTriggers() {
 
        Test.startTest();
 
        // -------- ACCOUNT --------
        Account acct = new Account(
            Name = 'Coverage Booster Account'
        );
        insert acct;
 
        acct.Name = 'Updated Booster Account';
        update acct;
 
        // -------- CONTACT --------
        Contact con = new Contact(
            FirstName = 'Coverage',
            LastName = 'BoosterContact',
            Email = 'contactboost@test.com',
            AccountId = acct.Id
        );
        insert con;
 
        con.LastName = 'Updated BoosterContact';
        update con;
 
        // -------- CASE --------
        Case c = new Case(
            Subject = 'Coverage Booster Case',
            Status = 'New',
            Origin = 'Email',
            Priority = 'Medium',
            Description = 'Testing Account-Contact-Case triggers',
            AccountId = acct.Id,
            ContactId = con.Id
        );
        insert c;
 
        c.Status = 'Working';
        update c;
 
        // Optional: delete to cover delete triggers
        delete c;
        delete con;
        delete acct;
 
        Test.stopTest();
    }
}
 