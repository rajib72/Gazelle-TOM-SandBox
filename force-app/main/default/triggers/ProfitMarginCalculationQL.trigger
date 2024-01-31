trigger ProfitMarginCalculationQL on ChikPeaTOM__Quote_Line__c (before update) {
    Id supplierId;
    Id planId;
    
    for(ChikPeaTOM__Quote_Line__c ql : Trigger.New){
        if(ql.Supplier__c != null){
            supplierId = ql.Supplier__c;
         planId = ql.ChikPeaTOM__Service_Plan__c;
        }
    }
    
    Plan_Cost__c planCost = [Select Id , Name , Opex__c , Capex__c  FROM Plan_Cost__c WHERE Plan__c = :planId AND Supplier__c = :supplierId];
    
    for(ChikPeaTOM__Quote_Line__c ql : Trigger.New){
        ql.Capex_Profit_Margin__c = ql.ChikPeaTOM__Unit_NRC__c - planCost.Capex__c;
        ql.Opex_Profit_Margin__c = ql.ChikPeaTOM__Unit_MRC__c - planCost.Opex__c;
    }
    

}