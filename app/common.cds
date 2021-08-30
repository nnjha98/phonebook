/*
  Common Annotations shared by all apps
*/
using {my.bookshop as my} from '../db/index';
using ContactService from '../srv/contact-service';

////////////////////////////////////////////////////////////////////////////
//
//	Books Lists
//
// annotate my.Places with
// @(
//     Common.SemanticKey : [title],
//     UI : {
//         Identification : [{Value : title}],
//         SelectionFields : [
//             ID
//         ],
//         LineItem : [
//             {Value : ID},
//             {Value : title},
//         ]
//     }
// ) {
//     author
//     @ValueList.entity : 'Authors';
// };



////////////////////////////////////////////////////////////////////////////
//
//	Books Elements
//
annotate my.Places with {
    ID
    @title : '{i18n>ID}'
    @UI.HiddenFilter;
    title
    @title : 'Place';
}
//////////////////////

annotate my.Places with
@(UI : {
    Identification : [
        {Value : title},
    ],
    SelectionFields : [
        title
    ],
    LineItem : [
        {
            Value : modifiedAt,
            Label : 'Modification Date of this place entry'
        },
        {
            Value : title,
            Label : 'Name of the Place'
        },
    ],
    
   
});

////////////////////////////////////////////////////////////////////////////
//
//	Reviews List
//
annotate my.Contacts with
@(UI : {
    Identification : [
        {
            Value : ID,
            ![@UI.Hidden]
        },
        {Value : phone},
        // {
        //     // Value : modifiedBy,
        //     $Type : 'UI.DataFieldForAnnotation',
        //     Target : '@UI.FieldGroup#AddC'
        //     // Label : 'Modifier'
        // }
    ],
    SelectionFields : [
        phone,
        name
    ],
    // Header : [
    //     {
    //         Value: name
    //     }
    // ],
    LineItem : [
        {
            Value : modifiedAt,
            Label : 'Date'
        },
        {
            Value : name,
            Label : 'Name'
        },
        {
            Value : phone,
            Label : 'Phone'
        },
        {
            Value : place.title,
            Label : 'Place'
        },
        {
            // Value : modifiedBy,
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.FieldGroup#AddC'
            // Label : 'Modifier'
        },
        {
            // Value : modifiedBy,
            $Type : 'UI.DataFieldForAction',
            // Value : modifiedBy,
            Label : 'Edit this (c)',
            Action : 'ContactService.addContacts',
            // RequiresContext : false,
            // Label : 'Modifier'
        },
        {
            // Value : modifiedBy,
            $Type : 'UI.DataFieldForAction',
            // Value : modifiedBy,
            Label : 'Insert here (c)',
            Action : 'ContactService.EntityContainer/insertContacts',
            // RequiresContext : true,
            // Action : 'ContactService.EntityContainer/Contacts_insertContacts',
        },
        {
            // Value : modifiedBy,
            $Type : 'UI.DataFieldForAction',
            // Value : modifiedBy,
            Label : 'Insert a new place (c)',
            Action : 'ContactService.EntityContainer/insertPlaces',
            // RequiresContext : true,
            // Action : 'ContactService.EntityContainer/Contacts_insertContacts',
        }
            // 
        // {
        //     $Type : 'UI.DataFieldForAnnotation',
        //     // // Label : 'La la la',
        //     Target : '@UI.FieldGroup#AddC',
        
        // },
    ],
    FieldGroup #AddC : 
    {
        
        
        Data : 
        [
            // {
            //     $Type : 'UI.DataFieldForAnnotation',
            //     Label : 'Edit this',
            //     Target : 
            //     // Value: name
            // },    
            // {Value: name},
            {
                $Type : 'UI.DataFieldForAction',
                Label : 'Edit this (cc)',
                Action : 'ContactService.addContacts',
            // InvocationGrouping : #ChangeSet
            }, 
        
        ]
    },
    // DataPoint #rating : {
    //     Value : rating,
    //     Visualization : #Rating,
    //     MinimumValue : 0,
    //     MaximumValue : 5
    // }
});

annotate my.Contacts with {
    ID
    @title : '{i18n>ID}'
    @UI.HiddenFilter;
    phone
    @title : 'Phone';
    place
    @ValueList.entity : 'Places'
    @title : 'Place'
    @Common : {
        Text : place.title,
        TextArrangement : #TextOnly
    };
    date
    @title : '{i18n>Date}';
    address
    @title : 'Complete Address';
    // text
    // @title : '{i18n>Text}'
    // @UI.MultiLineText;
}


////////////////////////////////////////////////////////////////////////////
//
//	Fiori requires generated IDs to be annotated with @Core.Computed
//
using {cuid} from '@sap/cds/common';

annotate cuid with {
    ID
    @Core.Computed
}

annotate ContactService.Contacts actions {
    // @(
    //     Common.SideEffects : {
    //         TargetProperties : ['_it/rating'],
    //         TargetEntities : [
    //             _it,
    //             _it.reviews
    //         ]
    //     },
    //     cds.odata.bindingparameter.name : '_it',
    //     Core.OperationAvailable : _it.isReviewable
    // )
    addContacts(name @title : 'New name (keep blank to keep unchanged)', phone  @title : 'New phone (keep blank to keep unchanged)', place @title : 'New place (keep blank to keep unchanged)') //@ValueList.entity : 'Places')
}

// annotate insertContacts(name @title : 'New name (keep blank to keep unchanged)', phone  @title : 'New phone (keep blank to keep unchanged)', place @title : 'New place (keep blank to keep unchanged)' @ValueList.entity : 'Places');