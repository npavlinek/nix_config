if has('win32')
  let s:zettelkasten_directory = 'D:/shared/notes/zk'
else
  let s:zettelkasten_directory = '~/shared/notes/zk'
endif

function! zk#CreateZettel()
  let l:buffer_name = strftime('%Y%m%d%H%M%S')
  execute 'edit ' . s:zettelkasten_directory . '/' . l:buffer_name . '.md'
  call appendbufline('', '.', '# ' . l:buffer_name)
endfunction
