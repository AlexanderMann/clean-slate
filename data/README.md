# Data Structure
Use the data in [`flow.json`](https://github.com/AlexanderMann/clean-slate/blob/master/data/flow.json) with the following schema in mind. Intent of each piece of information is also laid out here.

## Root
The root node identifier in our DAG. Start here.

## Nodes
Nodes have the following structure:

```json
{"root": "id",
 "nodes": {
  "id":
  {"title":    "Important information about the node",
   "text":     "Details for the node",
   "type":     "question",
   "children": ["id0", "id1"]}}}
```

### Fields
#### id
> Integer | Boolean | String
A unique identifier to a given `node`.

Referenced in `children` and in `root`.

#### title
> String
The most important, short information about the `node`.

#### text
> String
Details for the `node`.

#### type
> String Enum [question, option, info, terminal]
See `types` below.

#### children
> List [id ...]
A sequence of `id` references to other `node`s.

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
