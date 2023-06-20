export const uuid = function () {
    var crypto = window.crypto || window.msCrypto || undefined;

    function _s4( number ) {
            var hexadecimalResult = number.toString( 16 );
            return "0".repeat( 4 - hexadecimalResult.length ) + hexadecimalResult;
    };

    if ( crypto !== undefined && 'getRandomValues' in crypto )
            return function () {
                    var buffer = new window.Uint16Array( 8 );
                    crypto.getRandomValues( buffer );
                    return _s4( buffer[ 0 ] ) + _s4( buffer[ 1 ] ) + '-' +
                            _s4( buffer[ 2 ] ) + '-' +
                            _s4( buffer[ 3 ] & 0x0777 | 0x4000 ) + '-' +
                            _s4( buffer[ 4 ] & 0x3fff | 0x8000 ) + '-' +
                            _s4( buffer[ 5 ] ) + _s4( buffer[ 6 ] ) + _s4( buffer[ 7 ] );
            };
    else
            return function () {
                    var currentDateMilliseconds = new Date().getTime();
                    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace( /[xy]/g, function ( currentChar ) {
                            var randomChar = ( currentDateMilliseconds + Math.random() * 16 ) % 16 | 0;
                            currentDateMilliseconds = Math.floor( currentDateMilliseconds / 16 );
                            return ( currentChar === 'x' ? randomChar : ( randomChar & 0x3 | 0x8 ) ).toString( 16 );
                    } );
            };
}();