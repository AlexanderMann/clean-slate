# Data Structure
## Nodes
Nodes have the following structure:

```json
{"nodes": {
  "id":
  {"title":    "Important information about the node",
   "text":     "Details for the node",
   "type":     "question", # One of: question, option, info, terminal
   "children": ["id0", "id1"]},
  ...
  }}
```

## Types
Nodes in the data structure are one of `type`:
- `question`
  - children are ***only*** `option`s
- `option`
  - childern are `question`, `info`, `terminal`
- `info`
  - children are ***only*** `option`s
  - represent actionable information the user has come across
  - information needs to be displayed at end to user
- `terminal`
  - no children.
  - end of information available
  - potentially actionable

## State Machine 
```
question
  |  ^
  V  |
  option
  ^  | |
  |  V |
  info |
       V
terminal
```
