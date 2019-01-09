module dsvdb.Core.Requests;

import dsvdb.Load;
import dsvdb.Ext.Debug;

class Requests {
	public string delegate()[string] Methods;
	
	/**
	 * Set up an associative array that links to each available action method.
	 */
	this() {
		Methods["t"] = &this.t;
		Methods["x"] = &this.x;
	}
	
	private string t() {return "t";}
	private string x() {return "x";}
}