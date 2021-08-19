/*
  Common Annotations shared by all apps
*/
using {my.bookshop as my} from '../db/index';


////////////////////////////////////////////////////////////////////////////
//
//	Books Lists
//
annotate my.Books with
@(
    Common.SemanticKey : [title],
    UI : {
        Identification : [{Value : title}],
        SelectionFields : [
            ID
        ],
        LineItem : [
            {Value : ID},
            {Value : title},
        ]
    }
) {
    author
    @ValueList.entity : 'Authors';
};



////////////////////////////////////////////////////////////////////////////
//
//	Books Elements
//
annotate my.Books with {
    ID
    @title : '{i18n>ID}'
    @UI.HiddenFilter;
    title
    @title : 'Place';
}


////////////////////////////////////////////////////////////////////////////
//
//	Reviews List
//
annotate my.Reviews with
@(UI : {
    Identification : [
        {
            Value : ID,
            ![@UI.Hidden]
        },
        {Value : phone}
    ],
    SelectionFields : [
        phone,
        name
    ],
    LineItem : [
        {
            Value : modifiedAt,
            Label : 'Date'
        },
        // {
        //     Value : createdBy,
        //     Label : '{i18n>User}'
        // },
        // {
        //     $Type : 'UI.DataFieldForAnnotation',
        //     Label : '{i18n>Book}',
        //     Target : '@UI.FieldGroup#BookAndAuthor'
        // },
        // {
        //     $Type : 'UI.DataFieldForAnnotation',
        //     Label : '{i18n>Rating}',
        //     Target : '@UI.DataPoint#rating'
        // },
        {
            Value : name,
            Label : 'Name'
        },
        {
            Value : phone,
            Label : 'Phone'
        },
        {
            Value : book.title,
            Label : 'Place'
        }
    ],
    // FieldGroup #BookAndAuthor : {Data : [
    //     {Value : book.title},
    //     {Value : book.author.name}
    // ]},
    DataPoint #rating : {
        Value : rating,
        Visualization : #Rating,
        MinimumValue : 0,
        MaximumValue : 5
    }
});

annotate my.Reviews with {
    ID
    @title : '{i18n>ID}'
    @UI.HiddenFilter;
    phone
    @title : 'Phone';
    book
    @ValueList.entity : 'Books'
    @title : 'Place'
    @Common : {
        Text : book.title,
        TextArrangement : #TextOnly
    };
    date
    @title : '{i18n>Date}';
    rating
    @title : 'ImportanceRating';
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
