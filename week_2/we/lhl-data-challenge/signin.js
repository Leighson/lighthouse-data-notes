/* global $ */
function getURLParameter(sParam) {
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam) {
            return sParameterName[1];
        }
    }
}

$(function () {
    function signInHrefMaker(res) {
        if (res.temp) {
            return '/reset';
        }
        if (window.location.pathname == '/sso-login') {
            var sso = getURLParameter('sso');
            var sig = getURLParameter('sig');
            return `/sso-login?sso=${sso}&sig=${sig}`;
        }
        if (res.success) {
            return '/';
        }
    }
    $('.loginForm').loginForm('#sign-in-error', signInHrefMaker);
});

/* https://data-challenge.lighthouselabs.ca/sso-login?sso=$eyJ1c2VySUQiOjI2NzksImZ1bGxUZWFtSUQiOjEsImZpcnN0TG9naW4iOmZhbHNlLCJ0ZWFtSUQiOjF9&sig=$srvIYUngTiSNlxWh1VpzVcycVyk*/