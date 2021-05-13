:title: Hovercraft! demo
:data-transition-duration: 500
:css: assets/presentation.css

A presentation about the new Composition API upcoming in Vue3.

You can render this presentation to HTML with the command::

    hovercraft hovercraft.rst outdir

And then view the outdir/index.html file to see how it turned out.
Official documentation: https://hovercraft.readthedocs.io/

----

Vue3 Composition API
====================

What's all the fuzz?
--------------------

.. note::

    Welcome to the presenter console!

----

:id: Slide__AboutMe

About me
========

.. figure:: assets/norman.jpg

* Norman

* Full-Stack developer and consultant at Wunderdog (Ask me about jobs 😉)

* Uses Vue.js as the weapon of choice since before it was cool

* Organises the Vuejs//Berlin Meetup

.. note::

    Wunderdog: Consultancy, cool place
    Vuejs before it was cool: that is before v2

----

So what's the fuzz about?
=========================

* What makes the Composition API cool

* What are those Reactive References

* How do methods and computed props work?

* What's this *reactive* function about?

.. note::

    Any notes?

----

What's cool about the Composition API?
======================================

For this, we need to talk about the limitations of Vue2:

* BigcComponents get less readable

* Current ways to reuse code have drawbacks

----

😢
==

----

Readability issues
==================

* Large components become hard to read because functionalities are spread all over different parts.

* Code cannot be organised by logical concerns

.. note::

    New functionalities usually impact mutliple places like data, methods, computed properties, etc.
    This spreads all the pieces all over the component.
    It would be nicer to be able to organise things by logical concerns

----

But what about Mixins?
======================

Oh no, he said the M-Word!

----

Current ways of code reuse
==========================

* Mixins

* Mixin Factories

* Scoped Slots

.. note::

    notes?

----

Mixins
======

✅ Organised by logical concerns

❌ Prone to cause conflicts

❌ Relationships are shady

❌ Reusability is very limited

❌ Implicit Property additions

❌ No access to *this*


.. note::

    The M-Word again?!

----

Mixin Factories
===============

✅ (still) Organised by logical concerns

✅ Easily reusable

✅ Clearer relationships

❌ Namespacing works but is hard

❌ Implicit Property additions

❌ Still no access to *this*

.. note::

    Explain the difference to Mixins:
    Functions (factories) that create namespaced mixins to avoid conflicts
    and to make relationships more clear
    Namespacing is hard because it requires stricter conventions

----

Scoped Slots
============

✅ Organised by logical concerns

✅ Solves most of the issues with Mixins

❌ Moves configuration into template

❌ Hard to reach from the code

❌ Performance might become an issue (because more components)

.. note::

    Any notes?

----

😭
==

----

Composition API benefits
========================

✅ the config is now in our component code

✅ Solves all of the issues with Mixins

.. code:: javascript

    import useCoolStuff from '@my/cool-stuff'
    import useFunctionality from '@my/functionality'

    export default {
      setup () {
        const coolStuff = useCoolStuff({/* config */})
        const actualStuff = useFunctionality({/* config */})

        return { coolStuff, actualStuff }
      }
    }

----

Composition API benefits
========================

✅ It's just a function that provides the scope for the template

.. code:: html

    <template>
      <h1>Hello {{ toWhom }}!</h1>
    </template>

    <script>
      export default {
        setup () {
          return { toWhom: "World" }
        }
      }
    </script>

----

Composition API
===============

Okay, better make this reactive

.. code:: html

    <template>
      <h1>Hello {{ toWhom }}!</h1>
    </template>

    <script>
      import { ref } from 'vue'

      export default {
        setup () {
          const toWhom = ref("World") // reactive string
          return { toWhom }
        }
      }
    </script>

----

Composition API
===============

Lets add an input field:

.. code:: html

    <template>
      <h1>Hello {{ toWhom }}!</h1>
      <input v-model="toWhom" />
    </template>

    <script>
      import { ref } from 'vue'

      export default {
        setup () {
          const toWhom = ref("World")
          return { toWhom }
        }
      }
    </script>

|fklzp|

.. |fklzp| raw:: html

   <a href="https://codesandbox.io/s/relaxed-hypatia-fklzp" target="_blank">edit in codesandbox</a>

----

Composition API
===============

But this should be a computed value!

.. code:: html

    <template>
      <h1>{{ greeting }}</h1>
      <input v-model="toWhom" />
    </template>

    <script>
      import { ref, computed } from 'vue'

      export default {
        setup () {
          const toWhom = ref("World")
          const greetung = computed(() => `Hello ${toWhom.value}!`)
          return { toWhom }
        }
      }
    </script>

|ony3j|

.. |ony3j| raw:: html

   <a href="https://codesandbox.io/s/happy-rhodes-ony3j" target="_blank">edit in codesandbox</a>

----

:id: Slide__Police

Composition API
===============

Watching and Methods

.. code:: html

    <template>
      <div>
        <h2>{{ greeting }}</h2>
        <input v-model="toWhom">
        <button v-if="danger" @click="callPolice">Call Police</button>
      </div>
    </template>

    <script>
    import { ref, computed, watch } from "@vue/composition-api";

    export default {
      setup() {
        const toWhom = ref("World");
        const danger = ref(false);
        const greeting = computed(() => `Hello ${toWhom.value}!`);

        const callPolice = () => {
          console.log("Bad name detected. Police is informed!");
        };

        const nameWatcher = watch(toWhom, newName => {
          if (newName === "bad") {
            danger.value = true;
            toWhom.value = "good";
          }
        });

        return { toWhom, greeting, danger, callPolice };
      }
    };
    </script>


|jok2s|

.. |jok2s| raw:: html

   <a href="https://codesandbox.io/s/heuristic-wave-jok2s" target="_blank">edit in codesandbox</a>

----

So is that how things work now?
===============================

----

Jain!
=====

----

Optional, but advanced
======================

* Completely optional

* The options syntax is still possible

* ...and will still be the common way

* new syntax is especially interesting for library authors

In Vue3 the composition API is the underlying technology and the component syntax builds on top of it.

----

When to use the Composition API
===============================

* a component grows due to a mix of functionalities

* code can be reused

* there are a couple of very similar, but yet not quite the same™ components

* Typescript!

----

:id: Slide__ThankYou

Thank you!
==========

twitter: `@koehr_in <https://twitter.com/koehr_in>`_

blog: https://koehr.tech

slides: https://koehr.in/slides/2020/vue3-composition-api


