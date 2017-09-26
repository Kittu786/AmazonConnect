@RestResource(urlMapping='/TotalTransactions/*')
global with sharing class TransTotal{
    
    @HttpGet
    global static Integer getTrans() {
    
        Integer cnt;
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
      /* String credId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1); */
            
       string actId = request.requestURI.substringBetween('/AccountransId/', '/Crdnum/');
        string credId = request.requestURI.substringAfter('/Crdnum/');
        
        
        /*Credit_Card__c  credres =  [select id,Card_Number__c,(select Amount__c,Date_Of_Transaction__c,Description__c from Transactions__r) from Credit_Card__c where Card_Number__c = :credId LIMIT 1];
        Transaction__c trns = [select count() from Transaction__c];
        return credres;*/
        
        List<Credit_Card__c > credes= [select id,Card_Number__c,(select id from Transactions__r where Date_Of_Transaction__c> :DateTime.now().addHours(-48).date()  ) from Credit_Card__c where Name__c=:actId and Card_Number__c = :credId];
        system.debug(credes);
        for (Credit_Card__c crds: credes) {
    // do something with it...
         
        cnt = crds.Transactions__r.size();
        
        
        
}
        //system.debug(crds.Transactions__r.size());
        system.debug(cnt); 
   return cnt;
    
    }
 }