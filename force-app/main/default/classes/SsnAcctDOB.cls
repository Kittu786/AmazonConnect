@RestResource(urlMapping='/dobssn/*')
global with sharing class SsnAcctDOB{
    
    @HttpGet
    global static Account getActBySSN() {
        RestRequest request = RestContext.request;
        
        string actId =request.requestURI.substringBetween('/Accountssn/', '/dobcon/');
        string todate = request.requestURI.substringAfter('/dobcon/');
        
        //String todate = '2009-09-04';
        String[] strDate = todate.split('-');
        system.debug('strDate '+strDate);
        Integer myIntDate = integer.valueOf(strDate[2]);
        Integer myIntMonth = integer.valueOf(strDate[1]);
        Integer myIntYear = integer.valueOf(strDate[0]);
        date dt = Date.newInstance(myIntYear, myIntMonth, myIntDate);   
        system.debug('dt '+dt);
       
       
                   
       
       
        Account result =  [select id,Phone,SSN__c,Name,BillingAddress,(select id,Birthdate from Contacts where Birthdate= :dt),(select id,Card_Number__c from Credit_Cards__r) from Account where SSN__c= :actId LIMIT 1];
        return result;
    }
    
    @HttpPut
    global static ID upsertAccountPhone(String id,String Phone) {
                                    Account acctPhone = new Account(
                                        Id=id,
                                        Phone=phone
                                        );
                                    
                                    upsert acctPhone;
                                    return acctPhone.Id;
                                }
  }