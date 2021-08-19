using {my.bookshop as my} from '../db/index';

@path : 'contact'
service ContactService 
{
    entity Contacts as projection on my.Contacts;

    entity Places   as projection on my.Places excluding 
    {
        createdBy,
        modifiedBy
    }
}

annotate ContactService.Contacts with @odata.draft.enabled;
