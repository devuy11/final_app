module StaticPagesHelper
	require 'emoticon_fontify'
	def return_emoticon(content)
		EmoticonFontify.emoticon_fontify(h(content))
	end
end
