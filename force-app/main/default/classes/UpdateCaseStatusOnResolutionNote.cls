@isTest
public class UpdateCaseStatusOnResolutionNote {
 
    @isTest
    static void testResolutionNoteContainsClosed() {
 
        // Step 1: Create Case without resolution note
      Case c = new Case(
    Subject = 'Test Case',
    Status = 'New',  
    Origin = 'Email',
    Priority = 'Medium',
    Description = 'Test description',
    SuppliedEmail = 'test@example.com',
    SuppliedName = 'Test User',
    SuppliedPhone = '9999999999'
);
        insert c;
 
        // Step 2: Update with resolution note containing the word 'closed'
        c.Resolution_Note__c = 'closed ';
        update c;
 
        // Step 3: Validate Status changed
        Case updatedCase = [
            SELECT Status
            FROM Case
            WHERE Id = :c.Id
        ];
 
        System.assertEquals('Closed', updatedCase.Status);
    }
 
 
  
}