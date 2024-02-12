trigger ProfitMarginCalculationQL on ChikPeaTOM__Quote_Line__c (before update) {
    Id supplierId;
    Id planId;
    
    for(ChikPeaTOM__Quote_Line__c ql : Trigger.New){
        System.debug('ql.Supplier__c'+ql.Supplier__c);
        if(ql.Supplier__c != null){
            supplierId = ql.Supplier__c;
            planId = ql.ChikPeaTOM__Service_Plan__c;
        }
        System.debug('planId'+planId);
    }
    
    if(planId !=null && supplierId!=null){
        Plan_Cost__c planCost = [Select Id , Name , Opex__c , Capex__c  FROM Plan_Cost__c WHERE Plan__c = :planId AND Supplier__c = :supplierId];

        System.debug('planCost'+planCost);
        
        for(ChikPeaTOM__Quote_Line__c ql : Trigger.New){
            ql.Capex_Profit_Margin__c = ql.ChikPeaTOM__Unit_NRC__c - planCost.Capex__c;
            ql.Opex_Profit_Margin__c = ql.ChikPeaTOM__Unit_MRC__c - planCost.Opex__c;
        }

    }
    

}