using {my.bookshop as my} from '../db/index';

@path : 'contact'
service ContactService 
{
    entity Contacts as projection on my.Contacts
    actions {
        action addContacts(name : String, phone : String, place : String @ValueList.entity : 'Places'); //returns Contacts;
        // action insertContacts(name : String @(title : 'New Name'), phone : String @title : 'New Phone', place : String @ValueList.entity : 'Places' @title:'New Place');
        // action insertContacts(name : String @(title : 'New Name'), phone : String @title : 'New Phone', place : String @title:'New Place');
    };

    action insertContacts(name : String @(title : 'New Name'), phone : String @title : 'New Phone', place : String @title:'New Place' @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Places',
        Parameters : 
        [{
            $Type : 'Common.ValueListParameterInOut',
            LocalDataProperty : 'place',
            ValueListProperty : 'ID',

        },
        {
            $Type : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'title',
        }]
    });

    action insertPlaces(name : String @(title: 'Name of the new place to create'));

    entity Places   as projection on my.Places excluding 
    {
        createdBy,
        modifiedBy
    }

    // actions{
    //     action insertContacts(name : String, phone : String, place : String); 
    // };
}

annotate ContactService.Contacts with @odata.draft.enabled;
annotate ContactService.Places with @odata.draft.enabled;
// annotate ContactService.Contacts actions {
//     // @(
//     //     Common.SideEffects : {
//     //         TargetProperties : ['_it/rating'],
//     //         TargetEntities : [
//     //             _it,
//     //             _it.reviews
//     //         ]
//     //     },
//     //     cds.odata.bindingparameter.name : '_it',
//     //     Core.OperationAvailable : _it.isReviewable
//     // )
//     addContacts(name @title : 'Name', phone  @title : 'Phone')
// }
