# CSS Coding Rules

## Philosophy

CSS should be:

- layered
- predictable
- minimal
- component-oriented
- attribute-driven
- free of unnecessary classes
- free of specificity conflicts

Follow these rules whenever generating or modifying CSS.

---

# 1. Use CSS Layers

All styles must belong to a defined layer.

```css
@layer
  reset,
  variables,
  base,
  layout,
  components,
  utilities;
```

Do not introduce new layers without a strong reason.

Later layers override earlier layers.

---

# 2. CSS Files Must Be Organized By Concern

The directory structure must follow this pattern.

```
css/
├── base
│   ├── reset.css
│   ├── variables.css
│   ├── colors.css
│   ├── spacing.css
│   ├── typography.css
│   └── utils.css
│
├── layout
│   ├── header.css
│   ├── footer.css
│   └── container.css
│
├── components
│   ├── button.css
│   ├── card.css
│   └── menu.css
│
└── site.css
```

Each file represents **one concept only**.

---

# 3. `site.css` Must Define Layer Order

`site.css` orchestrates the entire cascade.

Example:

```css
@layer
  reset,
  variables,
  base,
  layout,
  components,
  utilities;

@import url('./base/reset.css') layer(reset);
@import url('./base/variables.css') layer(variables);
@import url('./base/colors.css') layer(base);
@import url('./base/spacing.css') layer(base);
@import url('./base/typography.css') layer(base);

@import url('./layout/header.css') layer(layout);
@import url('./layout/footer.css') layer(layout);

@import url('./components/button.css') layer(components);
@import url('./components/card.css') layer(components);

@import url('./base/utils.css') layer(utilities);
```

The order must remain stable.

---

# 4. Prefer Element Selectors

Use semantic HTML elements whenever possible.

Bad ❌

```css
.button {
  padding: 1rem;
}
```

Good ✅

```css
button {
  padding: 1rem;
}
```

---

# 5. Prefer Attributes Over Classes

Use attributes when representing state.

Bad ❌

```css
.button.active {
  background: red;
}
```

Good ✅

```css
[aria-expanded="true"] {
  display: block;
}
```

---

# 6. Components Must Match File Names

Component selectors must match their file names.

Example:

```
components/card.css
```

Selectors:

```css
card { }
card header { }
card footer { }
```

Avoid classes like:

```css
.card { }
```

Prefer custom elements.

---

# 7. Components Must Not Style Other Components

Bad ❌

```css
card button {
  margin-top: 1rem;
}
```

Good ✅

```css
button {
  margin-top: var(--space-3);
}
```

Components must remain independent.

---

# 8. Use CSS Variables For All Design Tokens

Reusable values must be stored in `variables.css`.

Bad ❌

```css
color: #2563eb;
```

Good ✅

```css
color: var(--color-primary);
```

---

# 9. Avoid Deep Selectors

Selectors should remain shallow.

Bad ❌

```css
header nav ul li a {
  color: blue;
}
```

Good ✅

```css
nav a {
  color: blue;
}
```

---

# 10. Avoid Specificity Conflicts

Do not use:

```
!important
#ids
```

Use **layer ordering** instead.

---

# 11. Prefer `:where()` For Structural Selectors

Use `:where()` to eliminate selector specificity.

Bad ❌

```css
card header {
  font-weight: bold;
}
```

Good ✅

```css
:where(card header) {
  font-weight: bold;
}
```

`:where()` always has zero specificity.

This prevents specificity conflicts and makes overrides predictable.

---

# 12. Utilities May Use Classes

Utility classes must live in the `utilities` layer.

Example:

```css
@layer utilities {

.hidden {
  display: none !important;
}

.center {
  text-align: center;
}

.stack > * + * {
  margin-top: var(--space-3);
}

}
```

Utilities are the only place where classes are preferred.

---

# 13. Keep Files Small

CSS files should generally remain under **100 lines**.

Split large components into multiple files if needed.

---

# 14. Avoid Magic Numbers

Do not hardcode spacing or sizes.

Bad ❌

```css
margin-top: 17px;
```

Good ✅

```css
margin-top: var(--space-3);
```

---

# 15. Components Should Be Self Contained

Component files must style only their own structure.

Example:

```css
@layer components {

:where(card) {
  display: block;
  padding: var(--space-4);
}

:where(card header) {
  font-weight: bold;
}

:where(card footer) {
  margin-top: var(--space-3);
}

}
```

---

# 16. Editing Rules

When modifying CSS:

- Only edit the file responsible for the element or component.
- Do not introduce styles into unrelated files.
- Do not duplicate styles across multiple files.
- If styling a component, edit the corresponding file in `components/`.
- If styling layout structure, edit the corresponding file in `layout/`.
- If introducing design tokens, edit `variables.css`.

If a suitable file does not exist, create one that follows the directory structure.

---

# Summary

CSS in this project follows these principles:

```
custom elements
+ CSS layers
+ design tokens
+ zero-specificity selectors
```

This ensures CSS remains:

- predictable
- maintainable
- easy to override
- easy for coding agents to generate safely
