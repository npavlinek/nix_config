setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

setlocal cindent
setlocal cinoptions=
setlocal cinoptions+==0  " Don't indent braces in case label.
setlocal cinoptions+=N-s  " A namespace shouldn't cause indentation.
setlocal cinoptions+=g0  " Don't indent scope declarations.
