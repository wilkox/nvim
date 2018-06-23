" From https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! move_image#move_image()

  " Get the name of the image and construct a move-to path
  let image_name = s:get_visual_selection()
  let move_to_path = expand("~/Documents/study_images/" . image_name . ".png")

  " Locate the most recent screenshot
  let image_path = system("ls -t ~/Desktop | grep png | head -1")
  let image_path = substitute(image_path, '\n\+$', '', '')
  let image_path = expand("~/Desktop/" . image_path)

  " Confirm and move
  echomsg "Found " . image_path . ", ready to move to " . move_to_path . "? (y/n)"
  let confirmation = nr2char(getchar())
  if confirmation == "y"
    let renameResult = rename(image_path, move_to_path)
    if renameResult != 0
      echom "Move failed"
    else
      echom "Done"
    endif
  endif

endfunction
