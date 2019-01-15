module dsvdb.Core.Connection;

import std.conv;
import dsvdb.Load;
import dsvdb.Core.Requests;
import dsvdb.Ext.Debug;

class Connection {
	public StdHttpResponse Res;
	public StdHttpResponse ResOut;
	private Requests REQ;
	private StdConnection Con;
	private HttpPostReq Req;
	private HttpPostReq[int] ReqAll;
	private string[string] ReqArray;
	
	/**
	 * Set up and format single-use request variables.
	 */
	this(string[string] postArray, StdHttpResponse res) {
		this.ReqArray = postArray;
		this.REQ = new Requests();
		
		/* 
		 * Constants included with each request 
		 * action and query are VARIABLES, database, operatorID, operatorPW, and n are CONSTANTS.
		 * action and query change with each individual batch request
		 */
		this.Req.database = postArray["database"];
		this.Req.operatorID = postArray["operatorID"];
		this.Req.operatorPW = postArray["operatorPW"];
		this.Req.n = to!ubyte(postArray["n"]);
		
		this.Res = res;		
		this.ResOut = res;
	}
	
	/**
	 * Sort a batch of requests, then process each one individually.
	 */
	public StdHttpResponse setup() {
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
					dsvdb.Ext.Debug.elog("dev", "Not all request parameters provided.");
				
				/* Merge ReqAll[i] and TempRequest */
				this.ReqAll[i] = TempRequest;
				
				/* Next, process and execute request */
				this.Res = this.process(TempRequest);
				this.ResOut.buffer ~= this.Res.buffer ~ "|||";
			}
		}
			
		return this.ResOut;
	}
	
	/**
	 * Process individual request.
	 */
	public StdHttpResponse process(HttpPostReq request) {
		StdHttpResponse response;
		
		if ( request.action in REQ.Methods ) {
			response.buffer = REQ.Methods[request.action]();
		} else
			dsvdb.Ext.Debug.log("dev", "Action not found.");
		
		return response;
	}
}