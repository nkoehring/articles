title: chai.js has a serious problem
date: 2015-11-20 02:04:10
tags:
  - programming
  - javascript
  - testing
  - web
categories:
  - Programming
---

To test their JavaScript applications, people like to use tools like [Mocha](http://mochajs.org/) and [Chai](http://chaijs.com/). And there is also [Jasmine](https://jasmine.github.io/).

They all have similar ways to formulate expectations. In Jasmine you do this:

```js
expect(something).toBe(true)
expect(something).toBeTruthy()
```

This is a very expressive way of course and I also really like it. Chai goes one step further and makes following statements possible:

```js
expect(something).to.be.true
expect(something).to.eql(true)
expect(something).to.be.ok
```

Actually Chai gives you all the different ways. Besides using `expect`, you can also use `should`:

```js
something.should.be.true
something.should.equal(true)
something.should.be.ok
```

For the WePeAgEx (Weird People Against Expressivness), there is also the classical assertion style:

```js
assert.equal(something, true)
```

But back to expectations!
=========================

What I expect in my tests is, that they fail if something goes wrong. I guess anyone naturally agrees with that. But Chai is different. Following example:

```js
/** Jasmine: **/

// when
var something = null

// then
expect(something).toBeTruthy()  // fails, which is expected
```

```js
/** Chai: **/

// when
var something = null

// then
expect(something).to.be.truthy  // succeeds… wait, what?!
```

It took me a while to figure that out. The problem here is, that the correct way of writing the last statement would be:

```js
expect(something).to.be.ok
```

Chai doesn't know "truthy" as a expectation keyword. But instead of failing badly and throwing curses in your direction it just silently fails in the background and ignores the line finally. Without any expectation to fail, the test stays green.

You can write whatever you want after expect():

```js
expect(something).foo
expect(something).to.foo
expect(something).to.be.fooish
expect(something).not.to.be.bazy
```

The test will stay green. Chai also doesn't check, if any assertions where made in a test.

But luckily the problem is known. If you are interested, look at issues [#549](https://github.com/chaijs/chai/issues/549) and [#94](https://github.com/chaijs/chai/issues/94).

It is even known since years but barely communicated. There should be a thick, fat line in the docs, stating that nonsense after expect() will silently pass.
