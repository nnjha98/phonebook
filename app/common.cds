/*
  Common Annotations shared by all apps
*/
using {my.bookshop as my} from '../db/index';


////////////////////////////////////////////////////////////////////////////
//
//	Books Lists
//
annotate my.Places with
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
annotate my.Places with {
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
annotate my.Contacts with
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
        }
    ],
    DataPoint #rating : {
        Value : rating,
        Visualization : #Rating,
        MinimumValue : 0,
        MaximumValue : 5
    }
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
