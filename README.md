# Log4Shell-Rex

The following RegEx was written in an attempt to match indicators of a Log4Shell (CVE-2021-44228)
exploitation.

The Regex aims being PCRE compatible.

```regex
(?:\$|%(?:25)*24)(?:{|%(?:25)*7[Bb]).{0,30}?(?:J|j|%[46][Aa]).{0,30}?(?:N|n|%[46][Ee]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:I|i|%[46]9).{0,30}?(?::|%(?:25)*3[Aa]).{0,30}?((?:L|l|%[46][Cc]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:A|a|%[46]1).{0,30}?(?:P|p|%[57]0)(?:.{0,30}?(?:S|s|%[57]3))?|(?:R|r|%[57]2).{0,30}?(?:M|m|%[46][Dd]).{0,30}?(?:I|i|%[46]9)|(?:D|d|%[46]4).{0,30}?(?:N|n|%[46][Ee]).{0,30}?(?:S|s|%[57]3)|(?:N|n|%[46][Ee]).{0,30}?(?:I|i|%[46]9).{0,30}?(?:S|s|%[57]3)|(?:.{0,30}?(?:I|i|%[46]9)){2}.{0,30}?(?:O|o|%[46][Ff]).{0,30}?(?:P|p|%[57]0)|(?:C|c|%[46]3).{0,30}?(?:O|o|%[46][Ff]).{0,30}?(?:R|r|%[57]2).{0,30}?(?:B|b|%[46]2).{0,30}?(?:A|a|%[46]1)|(?:N|n|%[46][Ee]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:S|s|%[57]3)|(?:H|h|%[46]8)(?:.{0,30}?(?:T|t|%[57]4)){2}.{0,30}?(?:P|p|%[57]0)(?:.{0,30}?(?:S|s|%[57]3))?).{0,30}?(?::|%(?:25)*3[Aa]).{0,30}?(?:\/|%(?:25)*2[Ff])
```

![Example Screenshot](screenshots/example_1.png)

## Hunting on your Linux machine

### On the CLI with `grep`

```bash
eval "$(./RegEx_Generator.sh)"
grep -P ${Log4ShellRex} <logfile>
```

```bash
grep -P '(?:\$|%(?:25)*24)(?:{|%(?:25)*7[Bb]).{0,30}?(?:J|j|%[46][Aa]).{0,30}?(?:N|n|%[46][Ee]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:I|i|%[46]9).{0,30}?(?::|%(?:25)*3[Aa]).{0,30}?((?:L|l|%[46][Cc]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:A|a|%[46]1).{0,30}?(?:P|p|%[57]0)(?:.{0,30}?(?:S|s|%[57]3))?|(?:R|r|%[57]2).{0,30}?(?:M|m|%[46][Dd]).{0,30}?(?:I|i|%[46]9)|(?:D|d|%[46]4).{0,30}?(?:N|n|%[46][Ee]).{0,30}?(?:S|s|%[57]3)|(?:N|n|%[46][Ee]).{0,30}?(?:I|i|%[46]9).{0,30}?(?:S|s|%[57]3)|(?:.{0,30}?(?:I|i|%[46]9)){2}.{0,30}?(?:O|o|%[46][Ff]).{0,30}?(?:P|p|%[57]0)|(?:C|c|%[46]3).{0,30}?(?:O|o|%[46][Ff]).{0,30}?(?:R|r|%[57]2).{0,30}?(?:B|b|%[46]2).{0,30}?(?:A|a|%[46]1)|(?:N|n|%[46][Ee]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:S|s|%[57]3)|(?:H|h|%[46]8)(?:.{0,30}?(?:T|t|%[57]4)){2}.{0,30}?(?:P|p|%[57]0)(?:.{0,30}?(?:S|s|%[57]3))?).{0,30}?(?::|%(?:25)*3[Aa]).{0,30}?(?:\/|%(?:25)*2[Ff])' <logfile>
```

### Combine it with `find` to recursively scan a (sub-)folder of log files

```bash
eval "$(./RegEx_Generator.sh)"
find /var/log -name "*.log" | xargs grep -P ${Log4ShellRex}
```

```bash
find /var/log -name "*.log" | xargs grep -P '(?:\$|%(?:25)*24)(?:{|%(?:25)*7[Bb]).{0,30}?(?:J|j|%[46][Aa]).{0,30}?(?:N|n|%[46][Ee]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:I|i|%[46]9).{0,30}?(?::|%(?:25)*3[Aa]).{0,30}?((?:L|l|%[46][Cc]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:A|a|%[46]1).{0,30}?(?:P|p|%[57]0)(?:.{0,30}?(?:S|s|%[57]3))?|(?:R|r|%[57]2).{0,30}?(?:M|m|%[46][Dd]).{0,30}?(?:I|i|%[46]9)|(?:D|d|%[46]4).{0,30}?(?:N|n|%[46][Ee]).{0,30}?(?:S|s|%[57]3)|(?:N|n|%[46][Ee]).{0,30}?(?:I|i|%[46]9).{0,30}?(?:S|s|%[57]3)|(?:.{0,30}?(?:I|i|%[46]9)){2}.{0,30}?(?:O|o|%[46][Ff]).{0,30}?(?:P|p|%[57]0)|(?:C|c|%[46]3).{0,30}?(?:O|o|%[46][Ff]).{0,30}?(?:R|r|%[57]2).{0,30}?(?:B|b|%[46]2).{0,30}?(?:A|a|%[46]1)|(?:N|n|%[46][Ee]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:S|s|%[57]3)|(?:H|h|%[46]8)(?:.{0,30}?(?:T|t|%[57]4)){2}.{0,30}?(?:P|p|%[57]0)(?:.{0,30}?(?:S|s|%[57]3))?).{0,30}?(?::|%(?:25)*3[Aa]).{0,30}?(?:\/|%(?:25)*2[Ff])'
```

## Hunting in your logs using Splunk

You can use this RegEx to search your indexed logs using the `| regex`
[SPL](https://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Regex) command

```spl
index=nix sourcetype=...
| regex "<Log4ShellRex>"
```

```spl
index=nix sourcetype=...
| regex "(?:\$|%(?:25)*24)(?:{|%(?:25)*7[Bb]).{0,30}?(?:J|j|%[46][Aa]).{0,30}?(?:N|n|%[46][Ee]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:I|i|%[46]9).{0,30}?(?::|%(?:25)*3[Aa]).{0,30}?((?:L|l|%[46][Cc]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:A|a|%[46]1).{0,30}?(?:P|p|%[57]0)(?:.{0,30}?(?:S|s|%[57]3))?|(?:R|r|%[57]2).{0,30}?(?:M|m|%[46][Dd]).{0,30}?(?:I|i|%[46]9)|(?:D|d|%[46]4).{0,30}?(?:N|n|%[46][Ee]).{0,30}?(?:S|s|%[57]3)|(?:N|n|%[46][Ee]).{0,30}?(?:I|i|%[46]9).{0,30}?(?:S|s|%[57]3)|(?:.{0,30}?(?:I|i|%[46]9)){2}.{0,30}?(?:O|o|%[46][Ff]).{0,30}?(?:P|p|%[57]0)|(?:C|c|%[46]3).{0,30}?(?:O|o|%[46][Ff]).{0,30}?(?:R|r|%[57]2).{0,30}?(?:B|b|%[46]2).{0,30}?(?:A|a|%[46]1)|(?:N|n|%[46][Ee]).{0,30}?(?:D|d|%[46]4).{0,30}?(?:S|s|%[57]3)|(?:H|h|%[46]8)(?:.{0,30}?(?:T|t|%[57]4)){2}.{0,30}?(?:P|p|%[57]0)(?:.{0,30}?(?:S|s|%[57]3))?).{0,30}?(?::|%(?:25)*3[Aa]).{0,30}?(?:\/|%(?:25)*2[Ff])"
```

## Other

**Please create a pull request / issue if you can provide syntax for more systems.**

## Credits

I got help and ideas from:

- [@cyberops](https://twitter.com/cyb3rops) building [log4shell-detector](https://github.com/Neo23x0/log4shell-detector/) that served as an inspiration