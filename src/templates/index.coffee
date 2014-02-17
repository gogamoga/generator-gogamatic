_define = do ->
  if typeof define is 'function' and define.amd
    define
  else
    (factory) -> module.exports = factory require

do (define = _define) ->
  # You code here