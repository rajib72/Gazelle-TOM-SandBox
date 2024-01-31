public class SOWController {
	Public String recordID {get;set;}
    public Opportunity SOWDetail{get;set;}
    Public String oppName {get;set;}
    Public String accountName {get;set;}
    Public String accountId {get;set;}
    public Account accList {get;set;}
    public Contact contactDetails {get;set;}
    Public String contactName {get;set;}
    Public String contactEmail {get;set;}
    Public String contactPhone {get;set;}
    Public String billingCountry {get;set;}
    Public String billingPostalCode {get;set;}
    Public String billingState {get;set;}
    Public String billingCity {get;set;}
    Public String billingStreet {get;set;}
    
    public Opportunity_Line_Premise__c oppLinePremise{get;set;}
    public String contactAddressPremiseName {get;set;}
    public String contactAddressPremiseBuildingName{get;set;}
    public String contactAddressPremiseCity{get;set;}
    public String contactAddressPremiseState{get;set;}
    public String contactAddressPremisePostalCode{get;set;}
    public ChikPeaTOM__Quote__c quoteDetails{get;set;}
    public List<ChikPeaTOM__Quote_Line__c> quoteLineDetails{get;set;}
    
    public SOWController(Apexpages.StandardController controller){
        recordID = controller.getid();
        
        SOWDetail=[SELECT Id, name,AccountId from Opportunity WHERE Id =:recordID];
        
        accList=[SELECT Id,name,BillingCountry, BillingPostalCode, BillingState, BillingCity, BillingStreet, 
              	BillingLatitude, BillingLongitude from Account WHERE Id =:SOWDetail.AccountId];
        oppName=SOWDetail.name;
        accountName=accList.name;
        accountID = accList.Id;
        billingCountry = accList.BillingCountry;
        billingPostalCode =accList.BillingPostalCode;
        billingState = accList.BillingState;
        billingCity = accList.BillingCity;
        billingStreet = accList.BillingStreet;
        
        contactDetails=[Select id,Name,Email,Phone from Contact where AccountId = :accountID];
        contactName = contactDetails.Name;
        contactEmail = contactDetails.Email;
        contactPhone = contactDetails.Phone;
        
        oppLinePremise=[SELECT Id, name, Premise__r.name, Premise__r.Suite_Building__c, Premise__r.ChikPeaTOM__City__c, Premise__r.ChikPeaTOM__State__c, Premise__r.ChikPeaTOM__Postal_Code__c 
                        							FROM Opportunity_Line_Premise__c 
                        							WHERE Primary__c=true and Opportunity__c=:recordID];
        contactAddressPremiseName=oppLinePremise.Premise__r.name;
        contactAddressPremiseBuildingName=oppLinePremise.Premise__r.Suite_Building__c;
        contactAddressPremiseCity=oppLinePremise.Premise__r.ChikPeaTOM__City__c;
        contactAddressPremiseState=oppLinePremise.Premise__r.ChikPeaTOM__State__c;
        contactAddressPremisePostalCode=oppLinePremise.Premise__r.ChikPeaTOM__Postal_Code__c;
        
        quoteDetails = [Select id,name from ChikPeaTOM__Quote__c where Opportunity__c =:recordID LIMIT 1];
        
        quoteLineDetails = [Select id,name,ChikPeaTOM__Service_Plan__r.Name,ChikPeaTOM__Qty__c from ChikPeaTOM__Quote_Line__c where ChikPeaTOM__Quote__c =:quoteDetails.id];
    }
}