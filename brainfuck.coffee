fs   = require "fs"
util = require "util"

class Parser
  constructor: (code) ->
    @code      = code.split ""
    @tape      = new Buffer Math.pow 2, 16
    @tapeIndex = 0
    @codeIndex = 0

  run: ->
    while @codeIndex < @code.length
      switch @code[@codeIndex]
        when ">" then @tapeIndex++
        when "<" then @tapeIndex--
        when "+" then @tape[@tapeIndex]++
        when "-" then @tape[@tapeIndex]--
        when "." then util.print @tape.toString "utf8", @tapeIndex, @tapeIndex + 1
        when "," then fs.readSync process.stdin.fd, @tape, @tapeIndex, 1
        when "[" then if @tape[@tapeIndex] is 0 then while @code[++@codeIndex] isnt "]" then ""
        when "]" then if @tape[@tapeIndex] isnt 0 then while @code[@codeIndex--] isnt "[" then ""
      @codeIndex++
    return

# Copied from http://en.wikipedia.org/wiki/Brainfuck
helloWorld = """
           +++++ +++++             initialize counter (cell #0) to 10
           [                       use loop to set the next four cells to 70/100/30/10
               > +++++ ++              add  7 to cell #1
               > +++++ +++++           add 10 to cell #2
               > +++                   add  3 to cell #3
               > +                     add  1 to cell #4
               <<<< -                  decrement counter (cell #0)
           ]
           > ++ .                  print 'H'
           > + .                   print 'e'
           +++++ ++ .              print 'l'
           .                       print 'l'
           +++ .                   print 'o'
           > ++ .                  print ' '
           << +++++ +++++ +++++ .  print 'W'
           > .                     print 'o'
           +++ .                   print 'r'
           ----- - .               print 'l'
           ----- --- .             print 'd'
           > + .                   print '!'
           > .                     print '\n'
           """
new Parser(helloWorld).run()
