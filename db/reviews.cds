namespace my.bookshop;

using {
    my.bookshop as my,
    User,
    managed,
    cuid
} from '@sap/cds/common';

entity Reviews : cuid, managed {
    @cds.odata.ValueList
    book     : Association to my.Books;
    rating   : Rating;
    phone    : String(111);
    name     : String(1111);
}


type Rating : Integer enum {
    Best  = 5;
    Good  = 4;
    Avg   = 3;
    Poor  = 2;
    Worst = 1;
}
