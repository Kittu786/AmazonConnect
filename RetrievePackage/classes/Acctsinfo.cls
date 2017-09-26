@RestResource(urlMapping='/Acctdetail/*')
global with sharing class Acctsinfo{
    
    @HttpGet
    global static Account getActById() {
        RestRequest request = RestContext.request;
        String actId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        system.debug('actId '+actId);
        Account result =  [select id,Phone,Name,Email__c,BillingAddress,(select id,Card_Number__c from Credit_Cards__r),(select id,Name,Phone from Contacts) from Account where Phone = :actId LIMIT 1];
        return result;
    }
    
      
    @HttpPost
    
    global static ID createCase(String subject, String status,
                                String origin, String priority,String Type,Id AccountId,Id ContactId,String BlockCreditCardNum,string Email) {
                                    
                                    Case thisCase = new Case(
                                        Subject=subject,
                                        Status=status,
                                        Origin=origin,
                                        Type = Type,
                                        Priority=priority,
                                        AccountId=AccountId,
                                        ContactId = ContactId,
                                        Block_Credit_Card_Number__c = BlockCreditCardNum,
                                        Customer_Email__c = Email
                                        
                                    );
                                    
                                    insert thisCase;
                                    system.debug('*thisCase '+thisCase.Id);
                                    
                                   /* Case thisCase1 = new Case(
                                        Subject=subject,
                                        Status='New',
                                        Origin=origin,
                                        Type = 'New Credit Card',
                                        Priority=priority,
                                        AccountId=AccountId,
                                        Parent = thisCase,
                                        Block_Credit_Card_Number__c = BlockCreditCardNum
                                    );*/
                                    
                                   // insert thisCase1;
                                   // system.debug('*thisCase '+thisCase1.Id);
                                    
                                    if(thisCase.Type == 'Credit Card Lost'){
                                        
                                       /* Credit_Card__c crd = [select id,Card_Number__c,Staus__c from Credit_Card__c where Name__c =: AccountId and Card_Number__c=:BlockCreditCardNum];
                                        
                                        crd.Staus__c = 'Deactive';
                                        update crd;
                                        system.debug('*crd '+crd);*/
                                        
                                        
                                    }
                                    return thisCase.Id;
                                    
                                    
                                    
                                }  
    
    @HttpPut
    global static ID upsertCase(String subject, String status,
                                String origin, String priority, String id,String Type) {
                                    Case thisCase = new Case(
                                        Id=id,
                                        Subject=subject,
                                        Status=status,
                                        Origin=origin,
                                        Type = Type,
                                        Priority=priority);
                                   upsert thisCase;
                                   return thisCase.Id;
                                }
    
    
    
}