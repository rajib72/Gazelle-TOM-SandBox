public class GenerateInvoiceFromServiceOrder {
    @AuraEnabled
    public static List<ChikPeaTOM__Service_Order__c> CheckServiceOrderStatus(Id Recid){
        List<ChikPeaTOM__Service_Order__c> SOlist=[SELECT Id,Name,ChikPeaTOM__Status__c FROM ChikPeaTOM__Service_Order__c WHERE Id=:Recid];
        String status=SOlist[0].ChikPeaTOM__Status__c;
        System.debug('Status = '+Status);

        return SOlist;
    }

    @AuraEnabled
    public static Map<String, Object> GetInvoice(list<id> soId){
        Map<String, Object> response = new Map<String, Object>();
        List<ChikPeaO2B__Invoice__c> Invlist = new List<ChikPeaO2B__Invoice__c>();

        List<ChikPeaTOM__Service_Order__c> SOlist=[SELECT Id,Name,ChikPeaTOM__Account__c,ChikPeaTOM__Status__c FROM ChikPeaTOM__Service_Order__c WHERE Id=:soId AND ChikPeaTOM__Status__c='In Process'];
        System.debug('SOlist = '+SOlist);

        List<ChikPeaTOM__Order_Line__c> OrderLinelist=[SELECT Id,Name,ChikPeaTOM__Qty__c,ChikPeaTOM__Contract_Period__c,ChikPeaTOM__Primary_Site__c,ChikPeaTOM__Service_Plan__c FROM ChikPeaTOM__Order_Line__c WHERE ChikPeaTOM__Service_Order__c=:soId];
        system.debug('OrderLinelist = '+OrderLinelist);

        try{
            if(SOlist.size()>0){
                for(ChikPeaTOM__Service_Order__c so:SOlist){
                    ChikPeaO2B__Invoice__c invoice=new ChikPeaO2B__Invoice__c();
                    invoice.ChikPeaO2B__Account__c=so.ChikPeaTOM__Account__c;
                    invoice.Service_Order__c=so.Id;

                    insert invoice;

                    if(OrderLinelist.size()>0){
                        for(ChikPeaTOM__Order_Line__c ol: OrderLinelist){
                            ChikPeaO2B__Invoice_Line__c invLine=new ChikPeaO2B__Invoice_Line__c();
                            invLine.ChikPeaO2B__Invoice__c=invoice.Id;
                            invLine.Service_Plan__c=ol.ChikPeaTOM__Service_Plan__c;
                            invLine.ChikPeaO2B__Qty__c=ol.ChikPeaTOM__Qty__c;
                            invLine.Order_Line__c=ol.Id;
    
                            insert invLine;
                            System.debug('invLine = '+invLine);
                        }   
                    }
                }
        
            }
        }
        catch(Exception e){
            response.put('Error', true);
            response.put('ErrorMsg', e.getMessage());
            response.put('LineNumber', e.getLineNumber());
            system.debug('Exception ='+ e);
            // ErrorLogger.log(e, 'GenerateInvoiceFromServiceOrder'); 
        }
        return response;
    }
    public GenerateInvoiceFromServiceOrder(){

    }
}