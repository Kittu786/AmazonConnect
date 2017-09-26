@isTest
public class SsnAcctTest{

    public static testmethod void testSsnAcct(){
        
       Account act  = new Account();
       act.Name = 'test';
       act.Phone = '+17607058888';
       act.Email__c = 'ajay@gmail.com';
       act.SSN__c = '9999';
       act.BillingCity='test';
       act.BillingCountry = 'Test';
       act.BillingStreet = 'test';
       act.BillingState = 'test';
        act.BillingPostalCode = '765678';
       insert act;
                
       Contact ct = new Contact();
       ct.LastName = 'Test';
       ct.AccountId = act.id;
       ct.BirthDate = Date.newInstance(1975, 01, 01);
       insert ct;
        
       Credit_Card__c crd = new Credit_Card__c();
       crd.Card_Number__c = '1234';
       crd.Name__c = act.id;
       insert crd;
       
        string todate = '1975-01-01';
      
        /*String[] strDate = todate.split('-');
        system.debug('strDate '+strDate);
        Integer myIntDate = integer.valueOf(strDate[2]);
        Integer myIntMonth = integer.valueOf(strDate[1]);
        Integer myIntYear = integer.valueOf(strDate[0]);
        date dt = Date.newInstance(myIntYear, myIntMonth, myIntDate); */  
       
             
      Id recordId = act.id;
      RestRequest request = new RestRequest();
     request.requestUri ='https://financialcloud-dev-ed.my.salesforce.com/services/apexrest/Accountssn/'+act.SSN__c+'/dobcon/'+todate ;

      request.httpMethod = 'GET';
      RestContext.request = request;
             
    SsnAcctDOB.getActBySSN();
    }

    public static testmethod void testupsertAccountPhone(){
    
    
       Account act  = new Account();
       act.Name = 'test';
       act.Phone = '+17607058888';
       act.Email__c = 'ajay@gmail.com';
       
       
       insert act;
       
       SsnAcctDOB.upsertAccountPhone(act.id,'+18008474985');
       upsert act;
           
    }
}