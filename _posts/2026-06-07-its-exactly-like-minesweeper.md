---
title: "It's exactly like minesweeper"
date: 2026-06-07 20:00:00 +0200
categories: [software-engineering]
tags: [heuristics, craftsmanship]
description: People resist small changes because they've given up on the underlying problem. But the problem is solvable — it's exactly like minesweeper.
---

It often happens to me to be in a discussion like this:

> But how does adding types fix this problem with missing data? We will always have problems with missing data, the only way to fix them is to spend more time, add more debug logging... There is no magic trick!

> But why do you think that getting rid of yaml will help with our problem with handing off a project from a person to the other? We always have problems with handoffs, and we'll always have!

The pattern is clear: people struggle to see a connection between a small change that is asked to them today and the real problem they would like to solve, mostly because they tried to solve this problem in the past, couldn't, and so they concluded that the problem is inherent with the topic of discussion: it's unsolvable! We better brute force it, rather than wasting time with these changes. And we have to pull off a whole nighter every time before a release, it's how it is supposed to be!

So the underlying reasoning is clear: "There is no solution to this problem, because we tried several times, and we always failed! Let's stop trying and get that thing shipped! We'll just keep trying until it's done!"

To be fair: I perfectly understand the position, and it happens to me several times in several fields. For example: I had literally no idea how to reliably grill beef and pork. The Maillard reaction would randomly appear or not. There is no solution to this problem! You just have to try blindly without any idea what works and what not.

I rarely have this attitude toward software engineering challenges though. But I do see this in many of my colleagues. And it is very hard to convince them that it's actually not the case!

**THERE IS A WAY** to scale up systems, and it doesn't have to be painful, slow, annoying. **THERE IS A WAY** to reduce friction and ease hand-offs between people. And all it takes, most often, is a few simple steps, a few simple heuristics. The point is that you have to know the right ones!

And finding them is not easy. You don't brute force finding them. But when you find them, they feel exactly like magic. Finally, a lot of the things that just "randomly worked" can be engineered and effectively reproduced. Things that required lots of trial and error, whole nighters, and a ton of luck, now feel ordinary and easy, obvious.

I was very lucky: I found them.

I always struggled to tell people what it looks like when you find the right set of software engineering heuristics and stick to them. But then I discovered something incredible about minesweeper, and I hope it will resonate with you too, so perhaps you'll buy into my arguments!

Perhaps you feel about software engineering practices and its problems like I felt about minesweeper. I am pretty sure it's exactly like minesweeper.

Until very recently, I thought that completing a minesweeper game was basically a matter of luck. Some of the fields you could finish, some of them you couldn't, it was just a matter of luck. Yes, of course you could apply the rules, but they wouldn't take you far. You just lucked out some times and could finish it, and it felt great! But definitely not something that was worth "standardizing", "finding new patterns", etc.

Then I found this guy — [check out how he plays](https://www.instagram.com/reel/DZDr7sWAJ4W/?igsh=MTF6NGhnZHJtZnRxcg==). He can finish a lot of the games in less than 60 seconds! Could you believe it??

Then I started playing minesweeper again. I had lost interest several years ago because, as I said above, it was mostly luck, why wasting time. But that guy showed me that it was indeed possible to finish *most* of the games without any luck. Just by following some simple patterns.

You don't brute force them: somebody has to tell you. Well... Except if you're James Shore, or Uncle Bob... It's fair! James, if you're reading this, please reach out to me then, because I want you to tell me all your secret heuristics!

Anyway, back to minesweeper. Even after this first unlock, I couldn't finish *all* of the games. Something was still missing. What was it?

And while having no internet on a very long flight, I started clicking random buttons on the minesweeper app on my phone and found this help page:

![Minesweeper patterns — the 1-1 rule and the 1-2 Golden Rule](/assets/img/posts/minesweeper/patterns-1.jpg)

![Minesweeper patterns continued](/assets/img/posts/minesweeper/patterns-2.jpg)

What??? I spent countless hours playing minesweeper. I can't believe I didn't notice these simple rules... Definitely they're not as helpful as they claim in this help page... Well, let's give them a try.

Initially, of course, I had to slow down to try them out. Before, I could easily finish a "lucky" game in 40–50 seconds. And then I had to give up around 20% of the times without any "logical" moves. But now?? Now I can finish almost any game... I am a bit slower still, because I have to apply more rules... But there is a logic to it then!

And even better! Before, I could only reliably finish the 40-mines game. Now I can easily tackle the 99-mines game! It means that those simple rules unlocked new capabilities that were basically impossible before.

Yes, there is definitely a way to "explain" why these rules work. But 1) there is no convincing you until you try — you just have to! And 2) once you know them, you don't really think about why they work. And it's very difficult to explain to another person why they work and why they should use them instead of "randomly trying". They just work!

So yes. Software engineering is really like minesweeper. You need someone that tells you the right heuristics. And it's very hard finding that person. But perhaps you get lucky and you find them. And then, you have to... Trust and try! See for yourself! You need to take a little risk. But trust me: you'll be capable of doing things you thought would be impossible before. Catching crazy bugs. Not having to pull all those whole nighters. Shipping in time. Man! It'll feel like another job.

And most of it is very simple, easy rules. But, almost magically, they make you accomplish something that was impossible before.

Yes, there is still *some* luck involved. Yes, there is still *some* ad-hoc "cleverness" you have to apply. But most of the job won't be like that anymore. And if you can circumscribe the parts that need "luck" and "cleverness", you end up in a better spot and you can win the game, for real! Almost every time. Those few times in which you can't: okay! Go with a little experiment, but it will be one guess, not 20 or 30!

It's exactly like minesweeper.
