namespace my.bookshop;

using {
    my.bookshop as my,
    sap,
    managed,
    cuid
} from '@sap/cds/common';

@fiori.draft.enabled
entity Books : cuid, managed {
    title        : localized String(111);
    rating       : Decimal(2, 1);
    reviews      : Association to many my.Reviews
                       on reviews.book = $self;
    isReviewable : my.TechnicalBooleanFlag not null default true;
}


