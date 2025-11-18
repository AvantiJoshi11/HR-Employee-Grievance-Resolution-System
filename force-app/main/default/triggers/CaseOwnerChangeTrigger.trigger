trigger CaseOwnerChangeTrigger on Case (after update) {
    Set<Id> newOwnerIds = new Set<Id>();
    for (Case c : Trigger.new) {
        Case oldCase = Trigger.oldMap.get(c.Id);
        if (c.OwnerId != oldCase.OwnerId && c.OwnerId != null) {
            newOwnerIds.add(c.OwnerId);
        }
    }

    Map<Id, User> ownerMap = new Map<Id, User>();
    if (!newOwnerIds.isEmpty()) {
        ownerMap = new Map<Id, User>(
            [SELECT Id, Name FROM User WHERE Id IN :newOwnerIds]
        );
    }

    List<Grievance_Action__c> actionsToInsert = new List<Grievance_Action__c>();
    for (Case c : Trigger.new) {
        Case oldCase = Trigger.oldMap.get(c.Id);
        if (c.OwnerId != oldCase.OwnerId) {
            String newOwnerName = ownerMap.containsKey(c.OwnerId) ? ownerMap.get(c.OwnerId).Name : 'Unknown';

            actionsToInsert.add(new Grievance_Action__c(
                Action_Type__c = 'Reassignment',
                Name = c.Subject,
                Case__c = c.Id,
                Action_Date__c = Date.today(),
                Notes__c = 'Case reassigned to ' + newOwnerName
            ));
        }
    }

    if (!actionsToInsert.isEmpty()) {
        insert actionsToInsert;
    }
}