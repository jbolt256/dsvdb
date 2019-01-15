module dsvdb.App;

import vibe.vibe;
import std.conv;
import dsvdb.Load;
import dsvdb.Core.Connection;
import dsvdb.Core.Table;
import dsvdb.Ext.Debug;

string DSVDB_VERSION = "0.0.1";

/**
 * DSVDB main entry point.
 * Authors: Jacob A. Bolton
 * Date 01/14/19
 */
void main()
{
	listenHTTP(":8080", &handleRequest);
	runApplication();
}

/** 
 * Params: 
 *		req = standard vibe HTTP request
 *		res = standard vibe HTTP response
 */
void handleRequest(HTTPServerRequest req, HTTPServerResponse res)
{
	auto TAB = new Table();
	StdTable TestTable = TAB.init("testdb", "test");
	
	if ( req.path == "/" )
		res.writeBody(preprocess(req));
		dsvdb.Ext.Debug.log("dev", "TEST");
	if ( req.path == "/vers" ) 
		res.writeBody(DSVDB_VERSION);
	if ( req.path == "/test" ) 
		res.writeBody(to!string(TAB.rowExistsByColValue(TestTable, "t", "COL1")));
}

/**
 * Entry-point for backend access.
 * Params:
 *		req = vibe HTTPServerRequest from main
 */
string preprocess(HTTPServerRequest req) {
	/* Convert DictionaryList to ordinary parameter array */
	string[string] postArray;
	StdHttpResponse res;
	
	/* Loop over POST values provided */
	foreach ( param; req.form.byKeyValue() ) {
		postArray[param.key] = param.value;
	}
	
	/* If 'n' (number of synchronous requests) is not provided, assume one */
	if ( "n" !in postArray ) 
		postArray["n"] = "1";
		
	/* Next, create a new connection handler. */	
	if ( "operatorID" in postArray && "operatorPW" in postArray && "database" in postArray ) {
		auto Connect = new Connection(postArray, res);
		res = Connect.setup();
	} else
		res.buffer = "PARAM_ERR";
	
	return res.buffer;
}