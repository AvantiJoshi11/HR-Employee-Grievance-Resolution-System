public with sharing class GrievanceController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getCaseStats() {
        Map<String, Integer> stats = new Map<String, Integer>();
        stats.put('open', [SELECT COUNT() FROM Case WHERE Status != 'Closed']);
        stats.put('closed', [SELECT COUNT() FROM Case WHERE Status = 'Closed']);
        stats.put('slaBreached', [SELECT COUNT() FROM Case WHERE SLA_Due_Date__c < TODAY AND Status != 'Closed']);
        return stats;
    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getGrievanceTypeDistribution() {
        List<Map<String, Object>> result = new List<Map<String, Object>>();
        AggregateResult[] groupedResults = [
            SELECT Grievance_Type__c type, COUNT(Id) cnt FROM Case GROUP BY Grievance_Type__c
        ];
        for (AggregateResult ar : groupedResults) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('type', (String)ar.get('type'));
            row.put('count', (Integer)ar.get('cnt'));
            result.add(row);
        }
        return result;
    }
}