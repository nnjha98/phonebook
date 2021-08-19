/*
  Annotations for the Browse Books App
*/

using ReviewService from '../../srv/review-service';

annotate ReviewService.Reviews with @(UI : {
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
        book_ID
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
            Value : book_ID,
            Label : 'Place'
        },
    ]},
    FieldGroup #Review : {Data : [
        {
            Value : rating,
            Label : 'ImportanceRating'
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
    // FieldGroup #BookAndAuthor : {Data : [
    //     {Value : book.title},
    //     {Value : book.author.name}
    // ]},
    // DataPoint #rating : {
    //     Title : '{i18n>Rating}',
    //     Value : rating,
    //     Visualization : #Rating,
    //     MinimumValue : 0,
    //     MaximumValue : 5
    // }
}) {
    // rating @title : '{i18n>Rating}';
    phone @title : 'Phone';
    name @title : 'Name'  @UI.MultiLineText;
};
