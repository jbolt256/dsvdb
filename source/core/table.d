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
	
	/**
	 * Initialize a new standard table handle.
	 */
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
	
	/**
	 * Get row numbers of all ocurrences of VALUE in a given column COLUMN.
	 * Returns a dynamic uint array.
	 */
	public uint[] getIndexByColValue(StdTable Table, string value, string column) {
		uint[] find;
		
		for ( uint i = 0; i < Table.numRows; i++ ) {
			if ( value == Table.rows[i][column] ) {
				find ~= i;
			}
		}
		
		return find;
	}
	/**
	 * Returns row handle from index.
	 */
	public RowData getRowByIndex(StdTable Table, uint index) {
		RowData ret;
		if ( index <= Table.numRows ) {
			ret = Table.rows[index-1];
			}
		return ret;
	}
	
	/**
	 * Value exists?
	 */
	public bool rowExistsByColValue(StdTable Table, string value, string column) {
		FreeTableRowData Dummy;
		if ( this.getRowsByColValue(Table, value, column) == Dummy ) {
			return false;
			} else {
			return true;
			}
	}
	
	
	/**
	 * get rows by col value
	 */
	public FreeTableRowData getRowsByColValue(StdTable Table, string value, string column) {
		uint[] indexes = this.getIndexByColValue(Table, value, column);
		FreeTableRowData Rows;
		foreach ( index; indexes ) {
			Rows ~= this.getRowByIndex(Table, index + 1);
			}
		return Rows;
	}
}