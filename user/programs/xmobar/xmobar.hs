Config
  { font = "xft:Iosevka Extended:size=8"
  , bgColor = "black"
  , fgColor = "#ebdbb2"
  , commands = [ Run Brightness [ "-t", "BR: <percent>%"
                                , "--"
                                , "-D", "intel_backlight"
                                ] 50
               , Run Battery [ "-t", "BA: <left>% (<acstatus>)"
                             , "--"
                             , "-O", "charging"
                             , "-i", "full"
                             , "-o", "discharging"
                             ] 50
               , Run Date "%a %F %T" "date" 10
               , Run StdinReader
               ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = "%StdinReader% }{ %bright% <fc=#504945>|</fc> %battery% <fc=#504945>|</fc> %date%"
  }
