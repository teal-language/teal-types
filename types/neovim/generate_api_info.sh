
# open neovim, put the serialized api info into a buffer
# save it as api_info.tl
# run autogen.tl to generate the type defs
# type check the generated files
# delete api_info.tl
nvim --headless --noplugin -n \
	"+luado return 'return ' .. vim.inspect(vim.fn.api_info(), {newline='', indent=''})" "+saveas! api_info.tl | q" && \
	echo "" && \
	tl run autogen.tl > nvim_api.d.tl && \
	tl -q check nvim_api.d.tl && \
	tl -q check vim.d.tl && \
	rm api_info.tl

