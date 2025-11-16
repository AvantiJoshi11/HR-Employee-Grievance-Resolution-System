trigger SetGrievanceType on Case (before insert) {
    for (Case c : Trigger.new) {
        if (c.Origin == 'Email') {
            String subject = c.Subject != null ? c.Subject.toLowerCase() : '';
            String body = c.Description != null ? c.Description.toLowerCase() : '';

            if (subject.contains('harassment') || body.contains('harassment')) {
                c.Grievance_Type__c = 'Harassment';
            } else if (subject.contains('payroll') || body.contains('payroll')) {
                c.Grievance_Type__c = 'Payroll';
            } else if (subject.contains('policy') || body.contains('policy')) {
                c.Grievance_Type__c = 'Policy';
            } else {
                c.Grievance_Type__c = 'Other';
            }
        }
    }
}