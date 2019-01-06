module dsvdb.App;

import vibe.vibe;
import dsvdb.Load;
import dsvdb.Core.Connection;

string DSVDB_VERSION = "0.0.1";

/**
 * DSVDB main entry point.
 */
void main()
{
	listenHTTP(":8080", &handleRequest);
	runApplication();
}

/** 
 * Params: 
 * Returns: void
 */
void handleRequest(HTTPServerRequest req, HTTPServerResponse res)
{
	if ( req.path == "/" )
		res.writeBody(handle(req));
	if ( req.path == "/vers" ) 
		res.writeBody(DSVDB_VERSION);
}

/**
 * @function handle
 * Entry-point for backend access.
 */
string handle(HTTPServerRequest req) {
	/* Convert DictionaryList to ordinary parameter array */
	string buffer = null;
	string[string] postArray;
	HttpPostReq params;
	StdHttpResponse res;
	
	foreach ( param; req.form.byKeyValue() ) {
		postArray[param.key] = param.value;
	}
	
	if ( "n" !in postArray ) 
		postArray["n"] = "1";
		
	/* Next, create a new connection handler. */	
	if ( "operatorID" in postArray && "operatorPW" in postArray && "database" in postArray ) {
		auto Connect = new Connection(postArray, res);
		buffer = Connect.setup();
	} else {
		buffer = "A001";
	}
	
	return buffer;
}