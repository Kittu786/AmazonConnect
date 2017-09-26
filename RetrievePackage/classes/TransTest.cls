@isTest
public class TransTest{
    
    public static testmethod void testTransaction(){
        
       Credit_Card__c crd = new Credit_Card__c();
       crd.Card_Number__c = '1234';
       //crd.Name__c = act.id;
       insert crd;
       
      Transaction__c trns = new Transaction__c();
      trns.Date_Of_Transaction__c = Date.today()-2;
      trns.Credit_Card__c = crd.id;
      insert trns;
      
     Id recordId = trns.id;
   RestRequest request = new RestRequest();
   request.requestUri ='https://financialcloud-dev-ed.my.salesforce.com/services/apexrest/TotalTransactions/Crdnum'+recordId;

     request.httpMethod = 'GET';
     RestContext.request = request;
     TransTotal.getTrans();
             
        
    }


}