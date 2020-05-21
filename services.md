---
layout: post
title: Services
---

<ul>
  {% for item in site.data.services %}
      <h3>{{ item.name }}</h3>
      <p>{{ item.bullets | markdownify }}</p>

      <details>
          <summary>How it works</summary>
          <p><small>{{ item.howItWorks }}</small></p>
      </details>
      <br>
  {% endfor %}
</ul>