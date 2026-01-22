%define LAST_ITEM 0 

%macro colon 2 
%ifnstr %1
    %error "Arg 1 must be a string"
%endif

%2: 
dq LAST_ITEM 
db %1, 0 
%define LAST_ITEM %2 
%endmacro

