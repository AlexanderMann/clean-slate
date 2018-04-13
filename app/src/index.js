import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import data from '../../data/flow.json'

console.log('data: ', data);
// next keys and turn nodes into an flat array
const nodes = Object.keys(data.nodes).map(key => {
  let node = data.nodes[key];
  node.nodeType = node.type; // type is protected key in elm so node.type == node.nodeType
  delete node.type;
  node.info = node.text;
  delete node.text;
  node.id = key;
  return node;
});
console.log('nodes: ', nodes);
Main.embed(document.getElementById('root'), {
  root: data.root,
  nodes: nodes
});

registerServiceWorker();
