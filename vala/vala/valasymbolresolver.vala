/* valasymbolresolver.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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

namespace Vala {
	public class SymbolResolver : CodeVisitor {
		Symbol root_symbol;
		Symbol current_scope;
		List<NamespaceReference> current_using_directives;
		
		public void resolve (CodeContext context) {
			root_symbol = context.root;
			current_scope = root_symbol;
			context.accept (this);
		}
		
		public override void visit_begin_source_file (SourceFile file) {
			current_using_directives = file.get_using_directives ();
		}

		public override void visit_end_source_file (SourceFile file) {
			current_using_directives = null;
		}
		
		public override void visit_begin_namespace (Namespace ns) {
			current_scope = ns.symbol;
		}

		public override void visit_end_namespace (Namespace ns) {
			current_scope = current_scope.parent_symbol;
		}

		public override void visit_begin_class (Class cl) {
			current_scope = cl.symbol;
		}

		public override void visit_end_class (Class cl) {
			foreach (TypeReference type in cl.base_types) {
				if (type.type is Class) {
					if (cl.base_class != null) {
						Report.error (type.source_reference, "%s: Classes cannot have multiple base classes (`%s' and `%s')".printf (cl.symbol.get_full_name (), cl.base_class.symbol.get_full_name (), type.type.symbol.get_full_name ()));
						return;
					}
					cl.base_class = (Class) type.type;
				}
			}
			if (cl.base_class == null && (cl.name != "Object" || cl.@namespace.name != "GLib")) {
				cl.base_class = (Class) root_symbol.lookup ("GLib").lookup ("Object").node;
			}
		
			current_scope = current_scope.parent_symbol;
		}

		public override void visit_begin_struct (Struct st) {
			current_scope = st.symbol;
		}

		public override void visit_end_struct (Struct st) {
			current_scope = current_scope.parent_symbol;
		}

		public override void visit_namespace_reference (NamespaceReference ns) {
			ns.namespace_symbol = current_scope.lookup (ns.name);
			if (ns.namespace_symbol == null) {
				Report.error (ns.source_reference, "The namespace name `%s' could not be found".printf (ns.name));
				return;
			}
		}

		public override void visit_type_reference (TypeReference type) {
			if (type.type_name == "void") {
				return;
			}
			
			if (type.namespace_name == null) {
				Symbol sym = null;
				Symbol scope = current_scope;
				while (sym == null && scope != null) {
					sym = scope.lookup (type.type_name);
					scope = scope.parent_symbol;
				}
				if (sym == null) {
					foreach (NamespaceReference ns in current_using_directives) {
						var local_sym = ns.namespace_symbol.lookup (type.type_name);
						if (sym != null && local_sym != null) {
							Report.error (type.source_reference, "`%s' is an ambiguous reference between `%s' and `%s'".printf (type.type_name, sym.get_full_name (), local_sym.get_full_name ()));
							return;
						}
						sym = local_sym;
					}
				}
				if (sym == null) {
					Report.error (type.source_reference, "The type name `%s' could not be found".printf (type.type_name));
					return;
				}
				if (sym.node is TypeParameter) {
					type.type_parameter = (TypeParameter) sym.node;
				} else {
					type.type = (Type_) sym.node;
				}
			} else {
				var ns_symbol = root_symbol.lookup (type.namespace_name);
				if (ns_symbol == null) {
					Report.error (type.source_reference, "The namespace name `%s' could not be found".printf (type.namespace_name));
					return;
				}
				
				var sym = ns_symbol.lookup (type.type_name);
				if (sym == null) {
					Report.error (type.source_reference, "The type name `%s' does not exist in the namespace `%s'".printf (type.type_name, type.namespace_name));
					return;
				}
				type.type = (Type_) sym.node;
			}
		}
	}
}
