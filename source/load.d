module dsvdb.Load;

const DSVDB_MAX_REQUESTS = 16;

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
	string[string][int] rows;
	}
	
/* 
 * Standard response handler.
 */
struct StdHttpResponse {
	string buffer;
	int code;
}