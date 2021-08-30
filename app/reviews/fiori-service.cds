/*
  Annotations for the Browse Books App
*/

using ContactService from '../../srv/contact-service';

annotate ContactService.Contacts with @(UI : {
    HeaderInfo : {
        TypeName : 'Contact',
        TypeNamePlural : 'Contacts',
        Title : {Value : name},
        Description : {Value : phone},
    },
    PresentationVariant : {
        Text : 'Default',
        SortOrder : [{
            Property : name,
            // Descending : true
        }],
        Visualizations : ['@UI.LineItem']
    },
    SelectionFields : [
        phone,
        name,
        place_ID
    ],
    // HeaderFacets : [{
    //     $Type : 'UI.ReferenceFacet',
    //     Target : '@UI.DataPoint#rating'
    // }, ],
    Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#General',
            Label : 'General tab'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Review',
            Label : 'All Information',
        }
    ],
    FieldGroup #General : {Data : [
        {
            Value : createdAt,
            Label : '{i18n>Created}'
        },
        {
            Value : createdBy,
            Label : '{i18n>CreatedBy}'
        },
        {
            Value : modifiedAt,
            Label : '{i18n>Modified}'
        },
        {
            Value : modifiedBy,
            Label : '{i18n>ModifiedBy}'
        },
        {
            Value : place_ID,
            Label : 'Place'
        },
    ]},
    FieldGroup #Review : {Data : [
        {
            Value : address,
            Label : 'Complete Address'
        },
        {
            Value : phone,
            Label : 'Phone'
        },
        {
            Value : name,
            Label : 'Name'
        }
    ]},
}) {
    // rating @title : '{i18n>Rating}';
    phone @title : 'Phone';
    name @title : 'Name'  @UI.MultiLineText;
};

// annotate ContactService.Contacts with
// @(UI : {
//     Identification : [
//         {
//             Value : ID,
//             ![@UI.Hidden]
//         },
//         {Value : phone},
//         // {
//         //     // Value : modifiedBy,
//         //     $Type : 'UI.DataFieldForAnnotation',
//         //     Target : '@UI.FieldGroup#AddC'
//         //     // Label : 'Modifier'
//         // }
//     ],
//     // SelectionFields : [
//     //     phone,
//     //     name
//     // ],
//     // Header : [
//     //     {
//     //         Value: name
//     //     }
//     // ],
//     LineItem : [
//         {
//             Value : modifiedAt,
//             Label : 'Date'
//         },
//         {
//             Value : name,
//             Label : 'Name'
//         },
//         {
//             Value : phone,
//             Label : 'Phone'
//         },
//         {
//             Value : place.title,
//             Label : 'Place'
//         },
//         {
//             // Value : modifiedBy,
//             $Type : 'UI.DataFieldForAnnotation',
//             Target : '@UI.FieldGroup#AddC'
//             // Label : 'Modifier'
//         },
//         {
//             // Value : modifiedBy,
//             $Type : 'UI.DataFieldForAction',
//             // Value : modifiedBy,
//             Label : 'Edit this (c)',
//             Action : 'ContactService.addContacts',
//             // RequiresContext : false,
//             // Label : 'Modifier'
//         },
//         {
//             // Value : modifiedBy,
//             $Type : 'UI.DataFieldForAction',
//             // Value : modifiedBy,
//             Label : 'Insert here (c)',
//             Action : 'ContactService.EntityContainer/insertContacts',
//             // RequiresContext : true,
//             // Action : 'ContactService.EntityContainer/Contacts_insertContacts',
//         },
//         {
//             // Value : modifiedBy,
//             $Type : 'UI.DataFieldForAction',
//             // Value : modifiedBy,
//             Label : 'Insert a new place (c)',
//             Action : 'ContactService.EntityContainer/insertPlaces',
//             // RequiresContext : true,
//             // Action : 'ContactService.EntityContainer/Contacts_insertContacts',
//         }
//             // 
//         // {
//         //     $Type : 'UI.DataFieldForAnnotation',
//         //     // // Label : 'La la la',
//         //     Target : '@UI.FieldGroup#AddC',
        
//         // },
//     ],
//     FieldGroup #AddC : 
//     {
        
        
//         Data : 
//         [
//             // {
//             //     $Type : 'UI.DataFieldForAnnotation',
//             //     Label : 'Edit this',
//             //     Target : 
//             //     // Value: name
//             // },    
//             // {Value: name},
//             {
//                 $Type : 'UI.DataFieldForAction',
//                 Label : 'Edit this (cc)',
//                 Action : 'ContactService.addContacts',
//             // InvocationGrouping : #ChangeSet
//             }, 
        
//         ]
//     },
//     // DataPoint #rating : {
//     //     Value : rating,
//     //     Visualization : #Rating,
//     //     MinimumValue : 0,
//     //     MaximumValue : 5
//     // }
// });