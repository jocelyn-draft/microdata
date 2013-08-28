note
	description: "Item qualified by `itemscope' and indicates that descendants of this element contain information about it."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ITEM

inherit
	MD_COMPOSITE

	MD_TYPED_NODE

create
	make,
	make_with_name

feature {NONE} -- Initialization

	make (a_type_url: detachable READABLE_STRING_GENERAL)
		do
			initialize
			set_type_url (a_type_url)
		end

	make_with_name (a_name: READABLE_STRING_GENERAL; a_type_url: detachable READABLE_STRING_GENERAL)
		do
			make (a_type_url)
			set_name (a_name)
		end

feature -- Access

	name: detachable IMMUTABLE_STRING_32
			-- Itemprop name

	identifier: detachable IMMUTABLE_STRING_32
			-- unique identifier of the item

	item_references: detachable LIST [READABLE_STRING_GENERAL]
			-- References to md item by its unique identifier

feature -- Change

	set_name (a_name: detachable READABLE_STRING_GENERAL)
			-- Update name
		do
			if a_name = Void then
				name := Void
			else
				create name.make_from_string_general (a_name)
			end
		end

	set_identifier (a_identifier: detachable READABLE_STRING_GENERAL)
		do
			if a_identifier = Void then
				identifier := Void
			else
				create identifier.make_from_string_general (a_identifier)
			end
		end

feature {MD_HTML5_LOADER, XML_NODE_ITERATOR} -- Access

	associated_xml_element: detachable XML_ELEMENT

feature {MD_HTML5_LOADER} -- Change

	set_associated_xml_element (e: like associated_xml_element)
		do
			associated_xml_element := e
		end

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make_empty
			if attached name as n then
				Result.append_character ('%"')
				Result.append_string_general (n)
				Result.append_character ('%"')
			else
				Result.append_string_general ("Item")
			end
			if attached type as l_itemtype then
				Result.append_character (' ')
				Result.append_character ('<')
				Result.append (l_itemtype.url)
				Result.append_character ('>')
			end
			if attached identifier as l_id then
				Result.append_character (' ')
				Result.append_character ('#')
				Result.append (l_id)
			end
			if count > 0 then
				Result.append_string_general (" : ")
				Result.append_integer (count)
				Result.append_string_general (" props")
			end
		end

feature -- Visitor

	accept (vis: MD_VISITOR)
		do
			vis.visit_item (Current)
		end

end
