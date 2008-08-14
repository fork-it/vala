/* valaarrayresizemethod.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents the Array.resize method.
 */
public class Vala.ArrayResizeMethod : Method {
	/**
	 * Creates a new array resize method.
	 *
	 * @return newly created method
	 */
	public ArrayResizeMethod (SourceReference source_reference) {
		base.init ();
		name = "resize";
		external = true;
		this.source_reference = source_reference;
		cinstance_parameter_position = 0.1;
	}
}
