module dsvdb.Core.Table;

import dsvdb.Load;
import dsvdb.Core.Parser;

class Table {
	/**
	 * Generate new table handle.
	 */
	private Parser PAR;
	this() {
		this.PAR = new Parser();
	}

	public StdTable init(string database, string tablePath) {
		StdTable Table;
		string absolutePath = DSVDB_DATABASE_DIR ~ "/" ~ database ~ "/" ~ tablePath ~ ".dsv";
		
		Table.rows = this.PAR.parse(absolutePath);
		Table.numRows = Table.rows.length;
		Table.size = Table.rows.sizeof;
		Table.table = tablePath;
		Table.pathname = absolutePath;
		Table.database = database;
		
		return Table;
	}
	
}