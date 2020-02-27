# Vuejs3's super fast VDOM from scratch

When [Evan You](https://evanyou.me/) talked about the newest innovations in the upcoming third major version of [Vue](https://github.com/vuejs/vue-next), he also explained how he managed to make the Virtual DOM implementation a whole lot faster. Here is my approach to implement this exciting technology from scratch.

<!--more-->

## Wait.. Virtual DOM?

You might know already that one of the main innovations in new frameworks like React and Vue is the way they handle updates of the page. But what is actually happening there?

In short: Instead of traversing and updating the DOM directly all the time, a tree of Javascript objects is used that resemble the element structure. This is the Virtual DOM or vDOM. All changes happen directly in this tree structure, which is really fast and allows to keep track of changes independent of the actual DOM updates. After applying the changes the vDOM tree is compared with the actual DOM tree and only differing nodes are updated or replaced. These updates usually happen in sync with the Browser rendering, using [requestAnimationFrame](https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame) or similar techniques.

In 2017 I wrote about [Vue Reactivity](https://koehr.tech/vuejs-reactivity-from-scratch) where I used a simple dice roller example. For comparison here is this example written in plain Javascript without any library help:

```js
const faces = ["⚀", "⚁", "⚂", "⚃", "⚄", "⚅"];
const appEl = document.getElementById("app");

const resultEl = document.createElement("div");
const loadEl = document.createElement("span");
const dieEl = document.createElement("span");
const btnEl = document.createElement("button");

loadEl.innerText = "rolling...";
dieEl.classList.add("big");
dieEl.innerText = randomDie();
btnEl.innerText = "roll";

function randomDie() {
  const result = Math.floor(Math.random() * faces.length);
    return faces[result];
  }

  function roll(event) {
    resultEl.innerHTML = "";
    resultEl.append(loadEl);

    setTimeout(() => {
      dieEl.innerText = randomDie();
      resultEl.innerHTML = "";
      resultEl.append(dieEl);
    }, 1000);
  }

  btnEl.addEventListener("click", roll);
  resultEl.append(dieEl);
  appEl.append(resultEl, btnEl);
```
[![Edit Example Code in CodeSandbox](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/simple-dice-roller-2ksyi)

That's a bit rough, isn't it? Sure I could do this a bit shorter by always using `innerHTML` instead of `createElement` but this wouldn't scale at all and only work with small examples like this. This example shows what a framework that doesn't use a Virtual DOM, for example [Angular](https://angular.io) would do for you.

Now lets figure out how to implement a Virtual DOM.

## A minimal Virtual DOM

As I said, a Virtual DOM is basically a structure of Javascript objects resembling the actual DOM or a part of it. Here is an oversimplified example:

```js
const currentTree = { tag: 'div', children: [
  { tag: 'span', classList: ['big'], children: ['⚂'] }
]}
```
which should produce our good old friend:
```html
<div><span class="big">⚂</span></div>
```

Because such object trees are so cheap in Javascript, we can easily have a second one and compare it with the current one:
```js
const newTree = { tag: 'div', children: [
  { tag: 'span', classList: [], children: ['rolling...'] }
]}

// This function should give back a list of references
// to elements and their changes. Lets call those patches.
const patches = compareTrees(newTree, currentTree)
```

So, resembling a DOM with Objects in a tree structure is pretty easy. Comparing two of those trees isn't so hard either but it needs a bit more of an explanation.

To compare two tree structures, we need to:

  1. traverse both trees and compare each node
  2. collect a list of changes in a way that allows us to apply them to the DOM

There are a couple different tree traversal algorithms, all of them have specific use cases. I'll not go into the details here but if you're interested, check out [this article about tree traversal algorithms](https://www.tutorialspoint.com/data_structures_algorithms/tree_traversal.htm). There's also this interesting article showing a clever way to [traverse tree structures without recursion](http://plasmasturm.org/log/453/). We're going to use a pre-order traversal. This allows us to store changes by index:

```js
// see implementation details in CodeSandbox
const patches = compareTrees(newTree, currentTree)
console.log(patches)
{
  "1": [{
    "type": "classList",
    "value": []
  }],
  "2": [{
    "type": "text",
    "node": "rolling..."
  }]
}
```

[![Edit Example Code in CodeSandbox](https://codesandbox.io/static/img/play-codesandbox.svg)](https://codesandbox.io/s/tree-diffing-6r1jb)
