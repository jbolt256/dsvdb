module dsvdb.Core.Requests;

import dsvdb.Load;
import dsvdb.Ext.Debug;

class Requests {
	public void delegate()[string] Methods;
	
	/**
	 * Set up an associative array that links to each available action method.
	 */
	this() {
		Methods["t"] = &this.t;
	}
	
	private void t() {}
}