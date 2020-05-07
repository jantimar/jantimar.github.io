---
layout: post
author: Jan Timar
title:  "Improve your fastlane"
date:   2020-05-07 8:10:00 +0100
---

[Fastlane][1] is one of the best ways how you can automate the build and release your apps. It's not mather if you use GitLab, Jenkins, or other CI, you still can use Fastlane. I think you are familiar with Fastlane so this short article will help you improve your lanes.

### Set unique build number

First, you build your project, then you upload it to iTunesConnect, and after this long process, you receive a message your iTunesConnect contains build with the same `CFBundleVersion`. Are you familiar with that? This lane will set your `CFBundleVersion` with the current timestamp. First-line of lane gets the current timestamp and the second line sets your build version for all your targets. Then you know the time, when you build your app and which build, is newer. If you want more about `increment_build_number` looke at this [page][2].

```ruby
lane :before_release do
  timestamp = sh("echo $(date +%s)")
  increment_build_number(build_number: timestamp)
end
```

### Notify yourself

You are probably not looking on your terminal and waiting while your fastlane script will finish every minute. You can spend your time better, probably reading my blog 😅. This line will send you local notification with sound.

```ruby
notification(subtitle: "Your awesome app", message: "Upload is done", sound: "Ping")
```

{:refdef: style="text-align: center;"}
![Notification](/assets/Fastlane/notification.png){:class="img-responsive"}
{: refdef}

### Tag your release

Maybe you know it, but I had no idea. Yes, Fastlane can automatically add a tag to your git when finishing your build. However, be careful to tag commit which will be your final release.

```ruby
lane :add_tag do
  version = get_version_number(xcodeproj: "News.xcodeproj")
  add_git_tag(tag: version)
end
```


[1]:https://fastlane.tools
[2]:https://docs.fastlane.tools/actions/increment_build_number/