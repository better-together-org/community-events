/*
 * 
 */
var AjaxUtils = (function(){
    var pendingAjaxCalls = []; // collection of ajax calls

    return {
        addRequest : function (request) {
            pendingAjaxCalls.push(request);
        },
        
        removeRequest : function(request) {
            idx = _.indexOf(pendingAjaxCalls, request );
            if (typeof idx > -1) {
                pendingAjaxCalls.splice(idx,1);
            };
        },
        
        killRequests : function() { // when a page is unloaded kill any outstanding ajax calls
            _.invoke(pendingAjaxCalls, 'abort' );
            // empty the array
            pendingAjaxCalls = [];
        },
    };
})();

/*
 * Over-ride the jquery .ajax function
 */
jQuery(document).ready(function() {

    $.ajaxSetup({
        beforeSend: function( xhr ) {
            AjaxUtils.addRequest( xhr );
        },
        complete : function(arg, status) {
            AjaxUtils.removeRequest( arg );
            // if (status == 'error') {
                // window.location.replace("/");
            // };
        },
        error : function(response) {
            $("body").removeClass("loading");
            if (response.status > 0) {
                if (response.responseText) {
                    alertMessage(response.responseText);
                } else {
                    alertMessage("Error communicating with backend");
                };
            };
        }
    });

    window.addEventListener('beforeunload', function() { AjaxUtils.killRequests(); } , false);
});

$( window ).load(function() {
   Backbone.history.start();
});
