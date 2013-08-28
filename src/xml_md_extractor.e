note
	description: "Summary description for {XML_MD_EXTRACTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_MD_EXTRACTOR

inherit
	XML_NODE_ITERATOR
		redefine
			process_element
		end

create
	make,
	make_with_document

feature {NONE} -- Initialization

	make
		do
			make_with_document (create {MD_DOCUMENT}.make)
		end

	make_with_document (a_doc: MD_DOCUMENT)
		do
			document := a_doc
			create items_stack.make (1)
		end

feature -- Access

	document: MD_DOCUMENT

feature -- Visit

	items_stack: ARRAYED_STACK [MD_NODE]

	last_item: detachable MD_ITEM
		do
			if not items_stack.is_empty then
				if attached {MD_ITEM} items_stack.item as res then
					Result := res
				end
			end
		end

	process_element (e: XML_ELEMENT)
		local
			l_item, l_new_item: detachable MD_ITEM
			l_prop, l_new_prop: detachable MD_PROPERTY
			l_last_item: like last_item
			l_node: detachable MD_NODE
			l_name,
			l_type: detachable READABLE_STRING_32
			l_value: detachable READABLE_STRING_32
			l_tagname: READABLE_STRING_32
		do
			l_last_item := last_item

			if attached e.attribute_by_name ("itemtype") as att_type then
				l_type := att_type.value
			end

			if attached e.attribute_by_name ("itemprop") as att_prop then
				l_name := att_prop.value
				l_tagname := e.name
				if e.has_attribute_by_name ("itemscope") then
					l_value := Void -- the item itself
				elseif l_tagname.is_case_insensitive_equal_general ("meta") then
					l_value := attribute_value (e, "content")
				elseif
					l_tagname.is_case_insensitive_equal_general ("a") or else
					l_tagname.is_case_insensitive_equal_general ("area") or else
					l_tagname.is_case_insensitive_equal_general ("link")
				then
					l_value := attribute_value (e, "href")
				elseif
					l_tagname.is_case_insensitive_equal_general ("img") or else
					l_tagname.is_case_insensitive_equal_general ("audio") or else
					l_tagname.is_case_insensitive_equal_general ("embed") or else
					l_tagname.is_case_insensitive_equal_general ("iframe") or else
					l_tagname.is_case_insensitive_equal_general ("source") or else
					l_tagname.is_case_insensitive_equal_general ("track") or else
					l_tagname.is_case_insensitive_equal_general ("video")
				then
					--FIXME: If the element is an audio, embed, iframe, img, source, track, or video element
					--		The value is the absolute URL that results from resolving the value of the
					--		element's src attribute relative to the element at the time the attribute is set,
					--		or the empty string if there is no such attribute or if resolving it results in an error.
					l_value := attribute_value (e, "src")
				elseif l_tagname.is_case_insensitive_equal_general ("object") then
					l_value := attribute_value (e, "data")
				elseif l_tagname.is_case_insensitive_equal_general ("data") then
					l_value := attribute_value (e, "value")
				elseif l_tagname.is_case_insensitive_equal_general ("time") then
					-- FIXME
					if e.has_attribute_by_name ("time") then
						l_value := attribute_value (e, "time")
					elseif e.has_attribute_by_name ("datetime") then
						l_value := attribute_value (e, "datetime")
					else
						l_value := element_text_content (e)
					end
				else
					l_value := element_text_content (e)
				end
				if e.has_attribute_by_name ("itemscope") then
					create l_item.make_with_name (l_name, l_type)
					if attached e.attribute_by_name ("itemid") as l_id then
						l_item.set_identifier (l_id.value)
					end
					l_node := l_item
				elseif l_value = Void then
					create l_prop.make (l_name, element_text_content (e), l_type)
					l_node := l_prop
				else
					create l_prop.make (l_name, l_value, l_type)
					l_node := l_prop
				end
				if l_item /= Void then
					items_stack.put (l_item)
				end
				Precursor (e)
				if l_last_item /= Void then
					if l_name.has (' ') then
						across
							l_name.split (' ') as c_names
						loop
							if l_item /= Void then
								l_new_item := l_item.twin
								l_new_item.set_name (c_names.item)
								l_last_item.put (l_new_item)
							elseif l_prop /= Void then
								l_new_prop := l_prop.twin
								l_new_prop.set_name (c_names.item)
								l_last_item.put (l_new_prop)
							else
								check is_item_or_prop: False end
							end
						end
					else
						l_last_item.put (l_node)
					end
				end
				if l_item /= Void then
					items_stack.remove
				end
			elseif e.has_attribute_by_name ("itemscope") then
				create l_item.make (l_type)
				if attached e.attribute_by_name ("itemid") as l_id then
					l_item.set_identifier (l_id.value)
				end
				document.put (l_item)
				items_stack.put (l_item)
				Precursor (e)
				items_stack.remove
			else
				Precursor (e)
			end
			if
				l_last_item /= Void and then
				l_last_item.associated_xml_element = e
			then
					-- Close current itemscope
				from
				until
					items_stack.is_empty or items_stack.item /= l_last_item
				loop
					items_stack.remove
				end
			end
		end

	attribute_value (e: XML_ELEMENT; a_attribute: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached e.attribute_by_name (a_attribute) as att then
				Result := att.value
			end
		end

	element_text_content (e: XML_ELEMENT): READABLE_STRING_32
		do
			Result := e.joined_content
		end

end
