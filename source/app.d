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
	auto TAB = new Table();
	StdTable TestTable = TAB.init("testdb", "test");
	
	if ( req.path == "/" )
		res.writeBody(preprocess(req));
	if ( req.path == "/vers" ) 
		res.writeBody(DSVDB_VERSION);
	if ( req.path == "/test" ) 
		res.writeBody(to!string(TAB.getRowsByColValue(TestTable, "t", "COL1")[1]["COL2"]));
}

/**
 * @function handle
 * Entry-point for backend access.
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
	}
	
	return res.buffer;
}