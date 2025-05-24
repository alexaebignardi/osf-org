public class AccountHandler{
    public static Account insertNewAccount(String accountName){
        Account acct = new Account();
        acct.Name = accountName;
        try{

            insert acct;
            return acct;
        } catch (DmlException e){
            System.debug('A DML exception has occurred: ' + e.getMessage());
            return null;

        }
    }

}