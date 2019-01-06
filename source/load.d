module dsvdb.Load;

import vibe.vibe;

const DSVDB_MAX_REQUESTS = 16;

/* Create aliases from vibe for use in other programs */
alias HttpPostParams = vibe.utils.dictionarylist.DictionaryList!(string, true, 16u, false);

/*
 * Standard HTTP POST request, including operator information and n (number of requests to be handled).
 */
struct HttpPostReq {
	string operatorID;
	string operatorPW;
	string database;
	string action;
	string query;
	byte n;
	}
	
/*
 * Standard Table handler.
 */
struct StdTable {
	string table;
	string pathname;
	string database;
	string[int] rows;
	}
	
/* 
 * Standard response handler.
 */
struct StdHttpResponse {
	string[int] errors;
	string buffer;
}