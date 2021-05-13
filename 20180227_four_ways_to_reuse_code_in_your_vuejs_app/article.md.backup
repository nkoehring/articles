Four Ways To Reuse Code In Your Vue App
=======================================

Thanks to libraries like Vue, the rising complexity in web development stays manageable. One very important factor to that is, that it makes writing abstract and reusable code not only possible but also comfortable.

This article will show the most common ways of reusing code and tries to answer the most common questions: What is a good size for components before they should be split into smaller pieces? When is code big or complex enough to be separated and what are the possibilities besides components?

## Stars of web development: Components

They are the new shining star in the firmament of web development: Web components. Developers always knew it is the right thing to write reusable abstract building blocks, especially if the result is a bigger piece of software. Unfortunately this is not easy to achieve for markup structures, especially if styling and logic are associated with them.

Web components solve this problem. They allow to encapsulate markup, styling and logic into one custom element which then can be reused many times. Libraries like [Vue](https://vuejs.org), [React](https://reactjs.org) and [Polymer](https://www.polymer-project.org) all introduce different variants of web components. While Polymer tries to stay as close as possible to the [original specification](https://www.webcomponents.org/specs), React uses a functional and JavaScript centric approach. Vue stays somewhere in the middle with its Single File Components.

Vue's single file components (SFC) help staying small and maintainable by combining markup, logic and styling into one file.

<iframe src="https://codesandbox.io/embed/vue?fontsize=16&hidenavigation=1&module=%2Fsrc%2Fcomponents%2FHelloWorld.vue&view=editor" style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" sandbox="allow-modals allow-forms allow-popups allow-scripts allow-same-origin"></iframe>

This is the scaffolded example application created by `vue init`. It conveniently introduces us to SFCs and also includes a first component *HelloWorld.vue*, which is shown here.

Very visible in this component is the big amount of links cluttering the template. In this and any similar scenario, components can make things much more readable:

<iframe src="https://codesandbox.io/embed/5k9158nk5n?fontsize=16&hidenavigation=1&module=%2Fsrc%2Fcomponents%2FHelloWorld.vue&view=editor" style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" sandbox="allow-modals allow-forms allow-popups allow-scripts allow-same-origin"></iframe>

Wait. We only spared the `target="_blank"` and the end tag but now need to write `Anchor`instead of `a`? That doesn't look quite helpful you might think. And you are right. Although this component might not be completely useless, its value is questionable. What else could be done? All those links are in list items and there are even two lists. That might be a good starting point for a new component. Lets rename the Anchor component to *LinkList.vue*…

<iframe src="https://codesandbox.io/embed/rjj4v8rp1q?fontsize=16&hidenavigation=1&module=%2Fsrc%2Fcomponents%2FLinkList.vue&view=editor" style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" sandbox="allow-modals allow-forms allow-popups allow-scripts allow-same-origin"></iframe>

Woa, lots of changes. Lets look through them one by one:

* The new components name is *LinkList* due to the changes in its nature. *Anchor* is not necessary anymore.
* A look in *HelloWorld.vue* reveals that only the main headline is left. The rest is replaced with two *LinkList*s.
* The component data now contains all the links and their URLs.
* *LinkList.vue* gets the title (`<h2>`) and uses `v-for` to render the list of links. It also contains all the necessary styling.

Now that's neat! Only two lines left but still very readable. I would call this a good usage for a component.

This example shows that not every little piece needs to be in its own component. As soon as some repetition occurs, a component can be very helpful though. But thanks to Vue's powerful templating system, components are not the only way to reuse code. While components are the primary form of code reuse in Vue, in some cases directives can make much more sense.

## Stars of Vue templates: Directives

As concept borrowed from it, directives are what make Vue *feel* similar to Angularjs for most people. Most known examples might be `v-show` and `v-model` just as their conceptual counterparts `ng-show` and `ng-model`.

Custom directives are useful as soon as direct access to and manipulation of the original DOM element is needed. Here is one example scenario without directives:

<iframe src="https://codesandbox.io/embed/x9862w5y6p?fontsize=16&hidenavigation=1&module=%2Fsrc%2Fcomponents%2FLinkList.vue" style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" sandbox="allow-modals allow-forms allow-popups allow-scripts allow-same-origin"></iframe>

In this example, all links get generated title attributes and their text is prefixed with 'Vue ' in case they lead to a vuejs.org page. All this is of course possible without direct manipulation of elements. You could do it directly in the template, again and again for every component where you need it. Or you create a specialized component. But a component would be dependent on the element type. Maybe buttons will be introduced that need a similar functionality. This would need another component. Router links would also be an option. One more compent for them? Sounds not feasable in the long term. But fear not, directives come to the rescue!

<iframe src="https://codesandbox.io/embed/69wxzj3yn?fontsize=16&hidenavigation=1" style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" sandbox="allow-modals allow-forms allow-popups allow-scripts allow-same-origin"></iframe>

Now the code moved mostly unaltered from the mounted hook into its own directive. This makes it usable outside the original component and because the directive can be added everywhere, it can also be extended to support other elements like buttons or router links.

A real world example is this very simple [*v-moji*](https://www.npmjs.com/package/v-moji) directive that exchanges emoji codes with actual graphics using a library called [emojione](https://www.emojione.com/). You can check out the source
[on github](https://github.com/nkoehring/v-moji/blob/master/src/index.js).

Components are essentially a group of DOM elements, extended by some logic. Directives extend single DOM elements. But what if we want to extend a component? Enter *Mixins*.

## Mixins

What directives are for DOM elements, mixins are for components.