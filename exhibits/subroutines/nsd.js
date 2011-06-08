var POPUP_OFFSET = 10;
var DEFAULT_SUB = 'MAIN';
var OPEN_RECORDS = [];

$( document ).ready( function() {
    OPEN_RECORDS.push( DEFAULT_SUB );
    $( '#subroutines'+ DEFAULT_SUB ).addClass( 'top' ); // this is a hack

    init_keys();
    init_records( 'subroutines' );
    init_records( 'includes' );
    init_links( 'includes' );
    init_links( 'subroutines' );
    variable_trace();
});

function init_keys() {
    $( document ).keyup( function( e ) {
        if( e.keyCode == 27 ) { // esc
            $( '.cancel' ).click();
            var type = 'subroutines'; // setting the expected value
            if( $( '.top' ).hasClass( 'includes' )) type = 'includes';
            close_record( type, OPEN_RECORDS[ OPEN_RECORDS.length - 1 ]);
        }
    });
}

// after a refactor, I don't know if I need to generalize this anymore.
// leaving it in place anyway.
function init_records( type ) {
    $( 'div.'+ type ).each( function() {
        var sub = $( this ).attr( 'id' ).replace( type, '' );
        if( $.inArray( sub, OPEN_RECORDS )) { // since inArray() returns the index if found
            var close = $( '<a>' )
                .addClass( 'close' )
                .text( 'X (ESC)' )
                .click( function() { close_record( type, sub )} )
                ;
            $( this )
                .hide()
                .append( close )
                ;
        }
    });
}

function init_links( type ) {
    $( 'a.'+ type ).click( function( e ) {
        var sub = $( this ).text();
        OPEN_RECORDS.push( sub );
        popup_subroutine( type, sub, e );
        return false;
    });
}

function popup_subroutine( type, sub, e ) {
    $( '#'+ type + OPEN_RECORDS[ OPEN_RECORDS.length - 2 ]).removeClass( 'top' );
    $( '#'+ type + sub )
        .addClass( 'popup' )
        .addClass( 'top' )
        .css( 'top', e.pageY - 15 )
        .css( 'left', OPEN_RECORDS.length * POPUP_OFFSET )
        .css( 'z-index', OPEN_RECORDS.length )
        .show()
        ;
}

function close_record( type, sub ) {
    OPEN_RECORDS.pop();
    $( '#'+ type + sub )
        .hide()
        .removeClass( 'popup' )
        .removeClass( 'top' )
        ;
    $( '#'+ type + OPEN_RECORDS[ OPEN_RECORDS.length - 1 ]).addClass( 'top' );
    return false;
}

function variable_trace() {
    $(".global").mouseover(function(){
        $( "[global=" + $(this).attr('global') + "]" ).addClass("trace");
    }).mouseout(function(){
        $("[global=" + $(this).attr('global') + "]").removeClass("trace");
    });
}
