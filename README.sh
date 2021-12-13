#!/bin/bash

#   _                _  _  ____  _          _ _       ____
#  | |    ___   __ _| || |/ ___|| |__   ___| | |     |  _ \ _____  __
#  | |   / _ \ / _` | || |\___ \| '_ \ / _ \ | |_____| |_) / _ \ \/ /
#  | |__| (_) | (_| |__   _|__) | | | |  __/ | |_____|  _ <  __/>  <
#  |_____\___/ \__, |  |_||____/|_| |_|\___|_|_|     |_| \_\___/_/\_\
#              |___/
#
#  2021-12-13 back2root https://github.com/back2root

eval "$(./RegEx_Generator.sh)"

echo "Documentation printed in Markdown format to stdout" >&2
echo "Use \`./README.sh > README.md\` to update README.md" >&2

# shellcheck disable=SC2154
cat << EOF
# Log4Shell-Rex

The following RegEx was written in an attempt to match indicators of a Log4Shell (CVE-2021-44228)
exploitation.

The Regex aims being PCRE compatible.

\`\`\`regex
${Log4ShellRex}
\`\`\`

![Example Screenshot](screenshots/example_1.png)

## Hunting on your Linux machine

### On the CLI with \`grep\`

\`\`\`bash
eval "\$(./RegEx_Generator.sh)"
grep -P \${Log4ShellRex} <logfile>
\`\`\`

\`\`\`bash
grep -P '${Log4ShellRex}' <logfile>
\`\`\`

### Combine it with \`find\` to recursively scan a (sub-)folder of log files

\`\`\`bash
eval "\$(./RegEx_Generator.sh)"
find /var/log -name "*.log" | xargs grep -P \${Log4ShellRex}
\`\`\`

\`\`\`bash
find /var/log -name "*.log" | xargs grep -P '${Log4ShellRex}'
\`\`\`

## Hunting in your logs using Splunk

You can use this RegEx to search your indexed logs using the \`| regex\`
[SPL](https://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Regex) command

\`\`\`spl
index=nix sourcetype=...
| regex "<Log4ShellRex>"
\`\`\`

\`\`\`spl
index=nix sourcetype=...
| regex "${Log4ShellRex}"
\`\`\`

## Other

**Please create a pull request / issue if you can provide syntax for more systems.**

## Credits

I got help and ideas from:

- [@cyberops](https://twitter.com/cyb3rops) building [log4shell-detector](https://github.com/Neo23x0/log4shell-detector/) that served as an inspiration
EOF