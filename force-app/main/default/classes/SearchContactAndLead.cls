public with sharing class SearchContactAndLead {
    public static List<List<sObject>> searchContactsAndLeads(String search){

            List<List<sObject>> searchResults = [FIND: search IN ALL FIELDS 
            RETURNING Contact(FirstName,LastName),Lead(FirstName,LastName)];

        return searchResults;
    }

}
