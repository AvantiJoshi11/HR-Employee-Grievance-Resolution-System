trigger CaseOwnerChangeTrigger on Case (after update) {
    List<Grievance_Action__c> actionsToInsert = new List<Grievance_Action__c>();

    for (Case c : Trigger.new) {
        Case oldCase = Trigger.oldMap.get(c.Id);

        
        if (c.OwnerId != oldCase.OwnerId) {
            
            String newOwnerName = '';
            if (c.OwnerId != null) {
                User newOwner = [SELECT Name FROM User WHERE Id = :c.OwnerId LIMIT 1];
                newOwnerName = newOwner.Name;
            }

            // Create GrievanceAction record
            Grievance_Action__c action = new Grievance_Action__c();
            action.Action_Type__c = 'Reassignment';
            action.Name = c.subject;
            action.Case__c = c.Id;
            action.Action_Date__c = Date.today();
            action.Notes__c = 'Case reassigned to ' + newOwnerName;

            actionsToInsert.add(action);
        }
    }

    if (!actionsToInsert.isEmpty()) {
        insert actionsToInsert;
    }
}