module dsvdb.App;

import vibe.vibe;
import dsvdb.Load;
import dsvdb.Core.Database;

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
	string[string] postArray;
	string buffer = null;
	
	foreach ( param; req.form.byKeyValue() ) {
		postArray[param.key] = param.value;
	}
	
	/* Next, create a new database handler 
	 * Ensure that required parameters all exist.
	 */	
	if ( "operatorID" in postArray && "operatorPW" in postArray && "database" in postArray && "action" in postArray && "query" in postArray ) {}
	//auto DB = new Database();
	return buffer;
}