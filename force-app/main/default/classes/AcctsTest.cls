@isTest
public class AcctsTest{
    
    

    public static testmethod void createCaseTest(){
    
       Account act  = new Account();
       act.Name = 'test';
       act.Phone = '+17607058888';
       act.Email__c = 'ajay@gmail.com';
              
       insert act;
       
       Contact ct = new Contact();
       ct.LastName = 'Test';
       ct.Phone = '(760) 705-8888';
       ct.AccountId = act.id;
       insert ct;
       
       Credit_Card__c crd = new Credit_Card__c();
       crd.Card_Number__c = '1234';
       crd.Name__c = act.id;
       insert crd;
       Acctsinfo.createCase('test','New','Phone','Credit Card Lost','High',act.id,ct.id,'1234','ajay@gmail.com');
      // Accts.upsertCase('testing','Escalated','Email','Medium',cs.id,'New Account');
      // upsert cs;
       Case cs = new Case();
       cs.Subject = 'test';
       cs.Status = 'New';
       cs.Origin = 'Phone';
       cs.Type = 'Credit Card Lost';
       cs.Priority = 'High';
       cs.AccountId = act.id;
       cs.ContactId = ct.id;
       cs.Block_Credit_Card_Number__c  = '1234';
       cs.Customer_Email__c  = 'ajay@gmail.com';
       upsert cs;
       Acctsinfo.upsertCase('testing','Escalated','Email','Medium',cs.id,'New Account');      
    }

   
}