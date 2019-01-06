module dsvdb.Core.Connection;

import vibe.vibe;
import std.conv;
import dsvdb.Load;

class Connection {

	public StdHttpResponse Res;
	private HttpPostReq Req;
	private HttpPostReq[int] ReqAll;
	private string[string] ReqArray;
	
	this(string[string] postArray, StdHttpResponse res) {
		this.ReqArray = postArray;
		this.Req.database = postArray["database"];
		this.Req.operatorID = postArray["operatorID"];
		this.Req.operatorPW = postArray["operatorPW"];
		this.Req.n = to!ubyte(postArray["n"]);
		this.Res = res;
	}
	
	public string setup() {
		HttpPostReq TempRequest = this.Req;
		
		/* 
		 * Determine number of requests to be handled.
		 * Currently, to prevent server from being overwhelmed by size of single request, limit
		 * number of batch requests to 16.
		 */
		if ( this.Req.n <= DSVDB_MAX_REQUESTS ) {
			for ( int i = 1; i <= this.Req.n; i++ ) {
				/* If the request actually exists, add request information to ReqAll */
				if ( "r" ~ to!string(i) ~ "_action" in this.ReqArray && "r" ~ to!string(i) ~ "_query" in this.ReqArray ) {
					TempRequest.action = this.ReqArray["r" ~ to!string(i) ~ "_action"];
					TempRequest.query = this.ReqArray["r" ~ to!string(i) ~ "_query"];
				} else 
					this.Res.buffer = "A003";
					
				/* Merge ReqAll[i] and TempRequest */
				this.ReqAll[i] = TempRequest;
				vibe.core.log.logDebug(TempRequest.action);
				this.Res.buffer = "OK";
			}
		} else
			this.Res.buffer = "A002";
		return this.Res.buffer; /* TEMPORARY */
	}
	
	private void auth() {
		
	}
}