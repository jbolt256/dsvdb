module dsvdb.Load;

const DSVDB_DATABASE_DIR = "./dev/db";
const DSVDB_DELIMETER = "^_";
const DSVDB_MAX_REQUESTS = 16;

alias TableRowData = string[string][uint];
alias RowData = string[string];

/*
 * Standard HTTP POST request, including operator information and n (number of requests to be handled).
 */
struct HttpPostReq {
	string operatorID;
	string operatorPW;
	string database;
	string action;
	string query;
	ubyte n;
	}
	
/*
 * Standard Table handler.
 */
struct StdTable {
	int size;
	int numRows;
	string table;
	string pathname;
	string database;
	string[string][uint] rows;
	}
	
/* 
 * Standard response handler.
 */
struct StdHttpResponse {
	string buffer;
	ubyte code;
}

/*
 * Standard operator handler.
 */
struct StdOperator {
	ushort operatorID;
	string operatorPW;
	string name;
	string[] stores;
}

/*
 *
 */
struct StdConnection {
	int code;
}