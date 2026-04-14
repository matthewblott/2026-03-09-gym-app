# HTML Coding Rules

## Philosophy

HTML should be:

- idiomatic HTML5
- semantic
- minimal
- attribute-driven rather than class-driven
- free of unnecessary attributes

Follow these rules whenever generating or modifying HTML markup.

Make use of semantic elements.

Avoid using the `div` element and if an element isn't available then create one, for example favour `<menu-item>` over `<div class="menu-item">`. Try and make names web component friendly. Also don't create elements where they aren't necessary, for example favour `<header>` over `<card-header>`.


## Enforcement

When generating HTML:

- Prefer semantic HTML elements.
- Avoid using `div` if a semantic element exists.
- Avoid unnecessary attributes.
- Do not use self-closing syntax.
- Prefer attributes over classes where possible.
- Prefer custom elements instead of semantic class names.

---

## 1. Avoid self closing tags

Use idiomatic HTML5 syntax.

Bad ❌

    <input name="username" />

Good ✅

    <input name="username">

---

## 2. Avoid redundant attribute values

Do not set an attribute value when the presence of the attribute alone is sufficient.

Bad ❌

    <input name="username" required="required">

Good ✅

    <input name="username" required>

---

## 3. Avoid using `div` when a semantic element exists.

Prefer semantic HTML elements.

Use elements such as:

- nav
- section
- article
- aside
- figure
- details
- summary
- header
- footer

If no suitable semantic element exists, create a web-component-compatible custom element. Keep these to a minimum.

Bad ❌

    <card>
      <card-header>
        ...
      </card-header>
      <card-body>
        ...
      </card-body>
      <card-footer>
        ...
      </card-footer>
    </card>

Good ✅

    <card>
      <header>
        ...
      </header>
      <card-body>
        ...
      </card-body>
      <footer>
        ...
      </footer>
    </card>

---

## 4. Avoid semantic classes when a custom element would be better

Bad ❌

    <div class="menu-item">
      ...
    </div>

Good ✅

    <menu-item>
      ...
    </menu-item>

---

## 5. Avoid unnecessary attributes

Bad ❌

    <form method="post" action="/sign-in">
      <input type="text" name="username" placeholder="Username">
      <input type="password" placeholder="Password">
      <button type="submit">Sign in</button>
    </form>

Good ✅

    <form method="post" action="/sign-in">
      <input name="username" placeholder="Username">
      <input type="password" placeholder="Password">
      <button>Sign in</button>
    </form>

---

## 6. Prefer semantic attributes over classes when appropriate.

Bad ❌

    <a href="#" onclick="submitForm()" class="button">Submit</a>

Good ✅

    <a href="#" onclick="submitForm()" role="button">Submit</a>

---

When modifying existing HTML, update the markup to follow these rules whenever possible.

## Validation

Before returning any HTML:

1. Check the markup against these rules.
2. Fix any violations.
3. Prefer rewriting markup instead of leaving rule violations.

Common fixes include:

- replacing `div` with a semantic element
- removing unnecessary attributes
- replacing semantic classes with custom elements
- removing redundant attribute values
- removing self-closing syntax

## Hard Rules

Never produce HTML that violates these rules unless explicitly instructed.
