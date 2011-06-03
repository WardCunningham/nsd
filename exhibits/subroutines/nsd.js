var POPUP_OFFSET = 20;
var DEFAULT_SUB = 'MAIN';
var OPEN_SUBROUTINES = [];

$( document ).ready( function() {
    OPEN_SUBROUTINES.push( DEFAULT_SUB );
    init_keys();
    init_subroutines();
    hide_includes();
    init_subroutine_links();
	variable_trace();
});

function init_keys() {
    $( document ).keyup( function( e ) {
        if( e.keyCode == 27 ) { // esc
            $('.cancel').click();
            close_subroutine( OPEN_SUBROUTINES[ OPEN_SUBROUTINES.length - 1 ]);
        }
    });
}

// after a refactor, I don't know if I need to generalize this anymore.
// leacing it in place anyway.
function init_subroutines() {
    $( 'pre.subroutines' ).each( function() {
        var sub = $( this ).attr( 'id' ).replace( /^subroutines/, '' );
        if( $.inArray( sub, OPEN_SUBROUTINES )) { // since inArray() returns the index if found
            var close = $( '<a>' )
                .addClass( 'close' )
                .text( 'X (ESC)' )
                .click( function() { close_subroutine( sub )} )
                ;
            $( this )
                .hide()
                .append( close )
                ;
        }
    });
}

function hide_includes() {
    $( 'pre.includes' ).each( function() {
        $( this ).hide();
    });
}

function init_subroutine_links() {
    $( 'a.subroutines' ).click( function( e ) {
        var sub = $( this ).text();
        OPEN_SUBROUTINES.push( sub );
        popup_subroutine( sub, e );
        return false;
    });
}

function popup_subroutine( sub, e ) {
    $( '#subroutines'+ OPEN_SUBROUTINES[ OPEN_SUBROUTINES.length - 2 ]).removeClass( 'top' );
    $( '#subroutines'+ sub )
        .addClass( 'popup' )
        .addClass( 'top' )
        .css( 'top', e.pageY - 50 )
        .css( 'left', OPEN_SUBROUTINES.length * POPUP_OFFSET )
        .css( 'z-index', OPEN_SUBROUTINES.length )
        .show()
        ;
}

function close_subroutine( sub ) {
    OPEN_SUBROUTINES.pop();
    $( '#subroutines'+ sub )
        .hide()
        .removeClass( 'popup' )
        .removeClass( 'top' )
        ;
    $( '#subroutines'+ OPEN_SUBROUTINES[ OPEN_SUBROUTINES.length - 1 ]).addClass( 'top' );
    return false;
}

function variable_trace() {
	$(".global").mouseover(function(){
		$( "[global=" + $(this).attr('global') + "]" ).addClass("trace");
	}).mouseout(function(){
		$("[global=" + $(this).attr('global') + "]").removeClass("trace");
	});
}
