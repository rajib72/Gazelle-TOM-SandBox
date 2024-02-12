trigger GetOrderLineData on ChikPeaTOM__Work_Order__c (before insert) {
    for(ChikPeaTOM__Work_Order__c obj : Trigger.new) {
        Id orderLine = obj.ChikPeaTOM__Order_Line__c;
        
        ChikPeaTOM__Order_Line__c olList = [Select Id,ChikPeaTOM__Contract_Period__c,ChikPeaTOM__Parent_Line__c,ChikPeaTOM__Qty_based_NRC__c,
                                                ChikPeaTOM__Primary_Site__c,ChikPeaTOM__Subscription_End_Date__c,ChikPeaTOM__Subscription_Start_Date__c,
                                                ChikPeaTOM__Unit_MRC__c,ChikPeaTOM__Unit_NRC__c,ChikPeaTOM__Bandwidth__c from ChikPeaTOM__Order_Line__c
                                                where id =:orderLine];
        
        obj.Contract_Period_Months__c=olList.ChikPeaTOM__Contract_Period__c;
        obj.Parent_Line__c=olList.ChikPeaTOM__Parent_Line__c;
        obj.Qty_based_NRC__c=olList.ChikPeaTOM__Qty_based_NRC__c;
        obj.Primary_Site__c=olList.ChikPeaTOM__Primary_Site__c;
        obj.Subscription_End_Date__c=olList.ChikPeaTOM__Subscription_End_Date__c;
        obj.Subscription_Start_Date__c=olList.ChikPeaTOM__Subscription_Start_Date__c;
        obj.Unit_MRC__c=olList.ChikPeaTOM__Unit_MRC__c;
        obj.Unit_NRC__c=olList.ChikPeaTOM__Unit_NRC__c;
        obj.Bandwidth__c=olList.ChikPeaTOM__Bandwidth__c;
        obj.Qty__c=olList.ChikPeaTOM__Qty__c;

    }
}