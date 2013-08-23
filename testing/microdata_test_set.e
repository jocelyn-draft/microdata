note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	MICRODATA_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_microdata
			-- New test routine
		local
			loader: MD_HTML5_LOADER
			dbg: MD_DEBUG_ITERATOR
		do
			create loader.make_with_string (ex_01)
			if attached loader.microdata as md then
				create dbg
				md.accept (dbg)
			end

--			http://www.wdl.org/en/item/1/
		end

	ex_01: STRING
		do
			Result := "[
						<html>
						<body>
						 <div itemscope itemtype='http://schema.org/Product'>
						  <span itemprop="name">Panasonic White 60L Refrigerator</span>
						  <img src="panasonic-fridge-60l-white.jpg" alt="">
						   <div itemprop="aggregateRating"
						       itemscope itemtype="http://schema.org/AggregateRating">
						    <meter itemprop="ratingValue" min=0 value=3.5 max=5>Rated 3.5/5</meter>
						    (based on <span itemprop="reviewCount">11</span> customer reviews)
						   </div>
						 </div>
						 </body>
						</html>
			]"
		end

end


