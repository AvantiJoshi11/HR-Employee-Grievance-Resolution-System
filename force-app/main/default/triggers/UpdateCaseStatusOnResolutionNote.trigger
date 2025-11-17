trigger UpdateCaseStatusOnResolutionNote on Case (before update) {
    for (Case c : Trigger.new) {
        Case oldCase = Trigger.oldMap.get(c.Id);
        
        
        if (c.Resolution_Note__c != null && c.Resolution_Note__c.toLowerCase().contains('closed')) {
            c.Status = 'Closed';
        }
    }
}