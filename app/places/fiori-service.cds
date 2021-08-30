using ContactService as service from '../../srv/contact-service';

annotate ContactService.Places with @(UI : {
    HeaderInfo : {
        TypeName : 'Place',
        TypeNamePlural : 'Places',
        Title : {Value : title},
        // Description : {Label : 'All the places in the world'},
    },
    PresentationVariant : {
        Text : 'Default',
        SortOrder : [{
            Property : title,
            // Descending : true
        }],
        Visualizations : ['@UI.LineItem']
    },
    SelectionFields : [
        title,
    ],
    // HeaderFacets : [{
    //     $Type : 'UI.ReferenceFacet',
    //     Target : '@UI.DataPoint#rating'
    // }, ],
    Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#General',
            Label : '{i18n>General}'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Review',
            Label : 'All Information',
        },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : 'Contacts',
        //     Target : 'contacts/@UI.LineItem'
        // }
    ],
    FieldGroup #General : {Data : [
        {
            Value : createdAt,
            Label : 'Time of entry creation'
        },
        // {
        //     Value : createdBy,
        //     Label : '{i18n>CreatedBy}'
        // },
        {
            Value : modifiedAt,
            Label : 'Time of last entry modification'
        },
        // {
        //     Value : modifiedBy,
        //     Label : '{i18n>ModifiedBy}'
        // },
        // {
        //     Value : contacts_ID,
        //     Label : 'Contact'
        // },
    ]},
    FieldGroup #Review : {Data : [
        // {
        //     Value : address,
        //     Label : 'Complete Address'
        // },
        // {
        //     Value : phone,
        //     Label : 'Phone'
        // },
        {
            Value : title,
            Label : 'Name of the Place'
        }
    ]},
}) 
{
    // rating @title : '{i18n>Rating}';
    title @title : 'Title';
    // name @title : 'Name'  @UI.MultiLineText;
};


// annotate ContactService.Contacts with @(UI : {
//     PresentationVariant : {
//         $Type : 'UI.PresentationVariantType',
//         SortOrder : [{
//             $Type : 'Common.SortOrderType',
//             Property : modifiedAt,
//             Descending : true
//         }, ],
//     },
//     LineItem : [
//         // {
//         //     $Type : 'UI.DataFieldForAnnotation',
//         //     Label : '{i18n>Rating}',
//         //     Target : '@UI.DataPoint#rating'
//         // },
//         {
//             $Type : 'UI.DataFieldForAnnotation',
//             Label : '{i18n>User}',
//             Target : '@UI.FieldGroup#ReviewerAndDate'
//         },
//         {
//             Value : name,
//             Label : 'Name'
//         },
//         {
//             Value : phone,
//             Label : 'Phone'
//         },
//     ],
//     // DataPoint #rating : {
//     //     Value : rating,
//     //     Visualization : #Rating,
//     //     MinimumValue : 0,
//     //     MaximumValue : 5
//     // },
//     FieldGroup #ReviewerAndDate : {Data : [
//         {Value : createdBy},
//         {Value : modifiedAt}
//     ]}
// });