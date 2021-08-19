namespace my.bookshop;

using {
    my.bookshop as my,
    sap,
    managed,
    cuid
} from '@sap/cds/common';

@fiori.draft.enabled
entity Places : cuid, managed 
{
    title        : localized String(111);
    rating       : Decimal(2, 1);
    contacts      : Association to many my.Contacts
                       on contacts.place = $self;
    isReviewable : my.TechnicalBooleanFlag not null default true;
}


