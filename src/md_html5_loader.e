note
	description: "Summary description for {HTML5_LOADER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_HTML5_LOADER

create
	make_with_path,
	make_with_string

feature {NONE} -- Initialization

	make_with_path (a_filename: PATH)
		do
			initialize
			xml_parser.parse_from_path (a_filename)
		end

	make_with_string (a_string: READABLE_STRING_GENERAL)
		do
			initialize
			xml_parser.parse_from_string (a_string)
			if not xml_parser.error_occurred then
				build_microdata
			end
		end

	initialize
		local
			p: HTML_PARSER
			cb: XML_CALLBACKS_DOCUMENT
		do
			create p.make
			create cb.make_null
			p.set_callbacks (cb)

			xml_callback_document := cb
			xml_parser := p
		end

	build_microdata
		local
			md: like microdata
			sel: XML_ELEMENT_SELECTOR
			xvis: XML_NODE_PRINTER
			s: STRING_8
			ext: XML_MD_EXTRACTOR
		do
			create md.make

			if attached xml_callback_document.document as xdoc then
				create xvis.make
				create s.make_empty
				xvis.set_output (create {XML_STRING_8_OUTPUT_STREAM}.make (s))
				xdoc.process (xvis)
				print (s)

				create sel.make
				sel.select_elements_with_attribute ("itemscope", Void)
					--itemscope
					--itemtype
					--itemid
					--itemprop
					--itemref
				sel.process_document (xdoc)
				across
					sel.items as c
				loop
--					if attached c.item.associated_xml_element as xelt then
--						print (xelt.debug_output)
--					else
						print (c.item.debug_output)
--					end
					io.put_new_line
				end

				create ext.make_with_document (md)
				xdoc.process (ext)
				md := ext.document
			end

			microdata := md
		end

feature -- Access

	microdata: detachable MD_DOCUMENT

feature {NONE} -- Implementation

	xml_parser: XML_PARSER

	xml_callback_document: XML_CALLBACKS_DOCUMENT


end
