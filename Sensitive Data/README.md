## To run a fake process in bash

`bash -c 'exec -a fakedp echo "/usr/data --user crypto --password mi11i0ns!" > /dev/null | sleep 10000' &`

`bash -c 'exec -a fakedp echo "/usr/data/gotcha -u crypto -p mi11i0ns! --file.csv" > /dev/null | sleep 10000' &`

## Search Query

```
lookup '<node id>'
show
content,
extract(content, regex "(?i)password=(\S+)", raw "\1") as "Default Filter 1",
extract(content, regex "(?i)-password\s+(\S+)", raw "\1") as "Default Filter 2",
extract(content, regex "(?i)password\s+(\S+)", raw "\1") as "Custom Filter 3",
extract(content, regex "[\'\"]password[\"\']:\s*(\S+)", raw "\1") as "Custom Filter 4"
```

## Custom Filters

`(?i)password\s+(\S+)`

`\'\"]password[\"\']:\s*(\S+)`