---
layout: default
title: Projects
---
<h1>Projects</h1>

<ul>
  {% for item in site.data.projects %}
  <li>
      <h3><a href="{{ item.link }}">{{ item.name }}</a></h3>
      <p>{{ item.description }} x</p>
    </li>
  {% endfor %}
</ul>