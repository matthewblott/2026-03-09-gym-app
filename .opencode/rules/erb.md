# ERB Template Rules (Rails)

## Philosophy

Rails views should primarily be **standard HTML with minimal ERB**.

ERB should be used **only for inserting values or simple logic**, not for
generating HTML structure.

Prefer **plain HTML elements** over Rails tag helpers.

---

## 1. Prefer HTML over Rails tag helpers

Avoid helpers that generate HTML tags.

Bad ❌

```erb
<%= link_to "Edit", edit_post_path(@post), class: "button" %>
```

Good ✅

```erb
<a href="<%= edit_post_path(@post) %>" class="button">
  Edit
</a>
```

---

## 2. Avoid form helpers when possible

Prefer standard HTML forms.

Bad ❌

```erb
<%= form_with model: @post do |f| %>
  <%= f.text_field :title %>
  <%= f.submit %>
<% end %>
```

Good ✅

```erb
<form method="post" action="<%= posts_path %>">
  <input name="post[title]" value="<%= @post.title %>">
  <button>Save</button>
</form>
```

---

## 3. Use ERB only for data

ERB should usually appear **inside attributes or text nodes**.

Good ✅

```erb
<h1><%= @post.title %></h1>

<a href="<%= post_path(@post) %>">
  View post
</a>
```

Avoid wrapping entire elements in ERB.

Bad ❌

```erb
<%= content_tag :h1, @post.title %>
```

---

## 4. Avoid `content_tag` and similar helpers

These obscure the actual HTML structure.

Bad ❌

```erb
<%= content_tag :div, class: "card" do %>
  ...
<% end %>
```

Good ✅

```erb
<div class="card">
  ...
</div>
```

---

## 5. Keep ERB logic minimal

Complex logic should be handled in:

- helpers
- presenters
- view models
- controllers

Bad ❌

```erb
<% if current_user && current_user.admin? && @post.published? %>
```

Better ✅

```erb
<% if can_edit_post?(@post) %>
```

---

## 6. Avoid HTML generated entirely by Ruby

The HTML structure of the page should be visible in the template.

Bad ❌

```erb
<%= render_card(@post) %>
```

Prefer:

```erb
<article class="card">
  <h2><%= @post.title %></h2>
  <p><%= @post.summary %></p>
</article>
```

---

## 7. Use Rails helpers only when necessary

Acceptable uses include:

- `csrf_meta_tags`
- `turbo_frame_tag`
- `turbo_stream`
- path helpers (`post_path`, `edit_post_path`)
- partial rendering (`render`)

Everything else should prefer plain HTML.

---

## Summary

Rails views should look like **normal HTML documents with small ERB insertions**.

Target style:

```erb
<article>
  <h1><%= @post.title %></h1>

  <p><%= @post.body %></p>

  <a href="<%= edit_post_path(@post) %>">
    Edit
  </a>
</article>
```


## Hard Rules

Never generate HTML using Ruby helpers if the same result can be written
as standard HTML.
