var POPUP_OFFSET = 20;
var DEFAULT_SUB = 'MAIN';
var OPEN_SUBROUTINES = [];

$( document ).ready( function() {
    OPEN_SUBROUTINES.push( DEFAULT_SUB );
    hide_subroutines();
    hide_includes();
    init_subroutine_links();
	variable_trace();
});

// after a refactor, I don't know if I need to generalize this anymore.
// leacing it in place anyway.
function hide_subroutines() {
    $( 'pre.subroutines' ).each( function() {
        var sub = $( this ).attr( 'id' ).replace( /^subroutines/, '' );
        if( $.inArray( sub, OPEN_SUBROUTINES )) { // since inArray() returns the index if found
            $( this ).hide();
        }
    });
}

function hide_includes() {
    $( 'pre.includes' ).each( function() {
        $( this ).hide();
    });
}

function show_subroutine( sub ) {
    $( '#subroutines'+ sub ).show();
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
    $( '#subroutines'+ sub )
        .addClass( 'popup' )
        .css( 'top', e.pageY - 50 )
        .css( 'left', OPEN_SUBROUTINES.length * POPUP_OFFSET )
        .css( 'z-index', OPEN_SUBROUTINES.length )
        .show()
        ;
}

function variable_trace() {
	$(".global").mouseover(function(){
		$( "[global=" + $(this).attr('global') + "]" ).addClass("trace");
	}).mouseout(function(){
		$("[global=" + $(this).attr('global') + "]").removeClass("trace");
	});
}
