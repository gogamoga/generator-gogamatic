define = do ->
  return define if typeof define is 'function' and define.amd
  (factory) -> module.exports = factory require
