%define LAST_COLON_ITEM 0 

%macro colon 2 
    %ifnstr %1
        %error "Arg 1 must be a string"
    %endif

    %2: 
        dq LAST_COLON_ITEM 
        db %1, 0 
        %define LAST_COLON_ITEM %2 
%endmacro

%define LAST_NATIVE_ITEM 0

%macro native 3
    section .data
        w_ %+ %2:
            dq LAST_NATIVE_ITEM
            db %1, 0
            db %3
            %define LAST_NATIVE_ITEM w_ %+ %2
        xt_ %+ %2:
            dq i_ %+ %2
    section .text
        i_ %+ %2:
%endmacro
