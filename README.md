# Mentl

> Program testing can be used to show the presence of bugs, but never to show their absence.
> — Edsger W. Dijkstra

Mentl is humanity's verification substrate for the age of machine-written code. Any intelligence may propose; nothing runs unproven; intent is never lost; capability is always bounded.

```
type Sample = Float where -1.0 <= self <= 1.0

fn voice(x) -> Sample with Clock(48_000) + !Alloc =
  x |> gain(-3.0) |> lowpass(0.2) |> echo(0.35) |> louder |> soft_clip
```

Two lines to hold in your hand before anything else. The first declares a number that cannot leave the range a speaker can survive; not checked at runtime, proven at compile, erased before it runs. The second declares a function that cannot allocate memory, anywhere, transitively, down through everything it calls; if one line five layers deep breaks that promise, this does not build. Proven before it runs. Not observed while you pray.

This document is the whole front door: a story, then a school. The story asks nothing of you. The school starts from nothing, and by its last page you will read and write programs that prove themselves, which is something the best engineers alive cannot do without this medium, because no one can.

*Written from first-light: this book describes the finished medium. Where today's artifact falls short of what is written here, the artifact is the unfinished thing, never the medium. The same law already binds the compiler to [`docs/SYNTAX.md`](docs/SYNTAX.md); where they disagree, the compiler is wrong. This book stands under that law.*

---

## The Door

Every people on earth tells the same story. Something comes to the door wearing a face you love. It knows what that face knows. It laughs the way that body laughs. By every test you have, it is your brother, your wife, your child; and it is not.

We told that story for ten thousand years because we already knew the thing it protects: a copy can be perfect at every surface you know how to check and still be false all the way down.

Now the story has come true. The thing at the door is the machine, and the machine writes. It writes the code, the contract, the proof, the paper, the picture of your daughter. What it writes looks right. It passes the tests. It reads clean. And no one you trust made it, so looks-right is all you have.

It wears your face.

Dijkstra said the quiet part half a century early: a test can show that a flaw is there; no test can show that a flaw is not. You can run a program a million times and watch it never touch the network. You have not proven it cannot. You have watched it not want to, so far, while you were looking. Absence is not something you observe. Absence is something you prove.

Any welder knows this in the hands. A weld can pass the eye and fail under the crane; the stamp on the bar is not the steel, and the steel does not care what the stamp says. So you pull the coupon until it holds or it breaks, and you write down the number, and the number is the fact. The orchid that wears the wasp's body to fool the wasp is not caught by looking; it is caught by the key, the one trait no mimic carries. The lab result that fits every point and will not replicate. Every craft that ever mattered has met the perfect fake, and every craft learned the same law: when the surface can lie, you test the thing beneath it, or you believe.

Software chose believe. We read the diff, we run the tests, we merge. That held, barely, while a person wrote it and you could look the person in the eye. The machine writes a thousand times faster than anyone can look anyone in the eye.

It wears your face. Now it wears your voice.

· · ·

Here is what the old story understood better than we do.

The dread was never the monster. The dread is not being able to tell. It is standing in your own kitchen between two of someone you love, both pleading, both word-perfect, the gun so heavy in your hand, and no question left that the false one cannot answer. And under that, quieter, the worst one: if it can be you this well, what exactly were you?

The oldest versions of the story all end the same way. The one who could not prove what he was became the thing that could not be proven.

It wore your face, and you reached for its hand.

But the story kept the way out, all those centuries, carried like a coal in a horn. The way out is not a sharper eye. You cannot out-stare a perfect surface; perfect is what the surface is for. The way out is the true name: a fact about what the thing is, not how it appears. A word the false one cannot say, because saying it is being it. In the stories, you speak the name and the borrowed face comes off.

So this is the medium where everything must say its name.

In this medium, nothing runs unproven. Code does not get the benefit of looking right; it carries its proof or it does not execute. And the proof that matters most is the one no other system on earth will give you: the proof of the negative. Not "we watched it and it never phoned home." Cannot. Write `with !Network` on a function and the medium proves that nothing it calls, and nothing they call, all the way down, can reach the network; or it refuses to build. That is a program's true name: not what it did while you watched, but what it is unable to do when you don't.

And the name is not only a wall; it is a record of the why. Everything in this medium carries the reason it exists, walkable back to the root, so that what you meant does not rot into what it became. In the story, the man loses his name and his hands stop being his own. Here, intent is never lost.

Understand what that makes possible, because this is the part that is not a horror story. You do not hold the name to bar the door. You hold the name so you can open it. Let the machine write. Let anything write. The test never asks who made you; it asks for the name, and whatever can truly say it is the thing itself. Machine code that proves it cannot reach your files is safer than human code that promises. The medium does not fear a stronger writer. Every stronger writer that walks through the proof makes the house richer, and none of them can make it false.

It can wear your face. It cannot say your name.

· · ·

A fair question: why is this the end of the road, and not the next station on it?

Because of the shape of the thing. One graph. Two moves: draw an edge, read what is there. There is no third. The compiler, the type system, the prover, the debugger, the machinery that spreads your work across a hundred cores: not separate machines bolted together, but one graph read in different lights. The graph is the truth. Everything else you will ever see of it, the source, the errors, the docs, is a shadow it throws, and every shadow can be walked back to the body.

Pieces of this have been built before, one arm at a time, each a decade of someone's life. One language got the pipes right and never reached the effects. One got the effects right on a host that fought it. One got ownership right and still cannot say what a function must never do. Each stopped exactly where its one arm ended. This is the body.

A tool you can surpass keeps its own improvement outside itself; to beat it, you leave it. This medium has no outside. Its compiler is a move within its own graph. A better prover, a faster backend, a stronger proposer are all moves within its own graph. And the day it compiles itself and the output is itself, byte for byte, exact, there is nothing left standing outside it to surpass it with.

The day has a name. This medium was called Light when it was born, before it could do anything at all: a medium where nothing about a program is hidden, where the complexity is real and present and visible, clarity instead of the false ease that papers over what is hard. It has been renamed twice since. The day it proves itself by making itself is still called first-light, because that was always the point. A telescope's first light is the first sky it catches whole. A reactor's is the first fire that feeds itself.

A medium's first light is the day it says its own true name, and the name holds.

The name is Mentl.

Nothing runs that cannot say its name.

---

## The School

That was the story. Now I will teach you to say names.

You need no experience. If you have never written a program, you are not behind; half of what programmers must unlearn, you never learned, and this medium was shaped so that the unlearning is not required. The method is one sentence: read everything aloud. Code in this book is not notation, it is speech, and your ear will catch what your eye forgives.

We are going to build one program together, an instrument, a voice you could take on stage. It begins as a single line that makes a sound louder. By the last chapter it cannot clip, cannot stutter, cannot be spied on by a guest effect, survives a crash mid-note, and lets the machine propose improvements it must prove before you ever see them. Here is the promise of the whole school: **you will never rewrite it. You will only unlock it.** The line you write in chapter one is still there, unchanged, on the last page.

### 1 · Speak

Try this. Read it aloud before anything else:

```
fn double(x) = x * 2
```

A thing named double takes an x and gives back x times two. That is the whole meaning, and you just read a program in a language you were told you could not read. There was no ceremony, because there is nothing to be ceremonial about: you say what you mean, and everything else that other languages force you to say, the medium takes as its own burden. That is the deal. It never changes. Every page of this book is the same deal kept in a deeper place.

Notice what you did not write. You did not say what type x is. You did not say what comes back. The medium works all of that out from what the code does, the way you know "it" means the hammer because I just said hammer. Later, when you write something that matters, you will add a word or two of intent, and the medium will hold you to it. But you add words to make promises, never to fill out forms.

Now something with more world in it:

```
recording
  |> remove_hum
  |> steady
  |> brighten
```

The bar reads "and then." A recording goes in at the top; the hum comes off; the wobble steadies; the top end opens. Four stations, one line of travel, and the shape on the page is the shape of the work. You can already read this. A moment ago you couldn't.

One more form and you have enough grammar to start building. When a definition needs steps, it takes braces; the braces mean "a small scope with steps inside," and never anything else:

```
fn describe(x) = {
  let level = to_db(x)
  "signal is at {level} dB"
}
```

`let` names a value. The last line is what comes back. And that sentence in quotes is a live one: the `{level}` inside it is the real value, spoken into the text. Say what you mean, even inside a string.

Our instrument starts now, one honest line:

```
fn louder(x) = x * 2.0
```

Double the pressure of a sound and it gets louder. That is a volume knob. It is not a metaphor for an instrument; it is the first working part of one, and it never leaves the program.

### 2 · Shape — the arm called Graph

Everything you will ever handle in this medium has one of five shapes. A number: `440.0`, the A a band tunes to. A sequence: `[0.0, 0.2, 0.4]`, pressures in a row, which is all a recording is. A record, named fields holding values:

```
type Preset = {gain: Float, mix: Float}

let desk = Preset{gain: -3.0, mix: 0.35}
```

A choice, one thing from a fixed set of possibilities:

```
type Wave
  = Sine
  | Saw
  | Square
```

And a doing: `(x) => x * 2.0`, a function that is itself a value, handed around like any other. Five shapes. There is no sixth. Even text is just the sequence shape wearing letters, which is why gluing two words and gluing two lists is one operator: `"door" ++ "bell"`, `[1, 2] ++ [3, 4]`, same act, same `++`.

A choice is taken apart with `match`, and here is where the medium first shows its teeth. A botanist identifying a specimen walks a key: forked leaves go left, smooth go right, every plant lands in exactly one drawer. `match` is a key:

```
fn tone(w, t) =
  match w {
    Sine   => sin(t),
    Saw    => saw(t),
    Square => if sin(t) > 0.0 { 1.0 } else { -1.0 },
  }
```

Now change the world: add a fourth wave, `Triangle`, to the choice. Every `match` in the program that has no drawer for it refuses to compile, each one telling you by name what it is missing: `match on Wave does not cover variant: Triangle`. Feel what that is. You changed reality, and the medium handed you the complete list of everywhere your program disagrees with the new reality. Not the crashes you would find in production over a month; the list, now.

One more law, small on the surface, enormous underneath: `==` means equal, really equal, by value, all the way down. `desk == Preset{gain: -3.0, mix: 0.35}` is true. There is no "same box in memory" lie waiting to bite you, because equal means equal.

Underneath all of this sits the truth the whole medium stands on: your program is one graph, nodes and edges, and the text you type is not the program, it is a picture of the program, one shadow it throws. The medium reads the graph, and so will you.

That is the arm called Graph. Its question is yours now, the first of eight: **what is this, really?**

### 3 · Flow — the arm called Verbs

You have met `|>`, "and then." There are exactly five verbs of flow in this medium, and they are the complete vocabulary; every program you will ever read is these five shapes combined.

`<|` fans one value out to several readers:

```
signal
  <| (
    meter,
    to_waveform,
  )
```

One signal, two watchers; the meter and the display each get to look, and looking is all they get, which will matter in a later chapter.

`><` runs independent things side by side:

```
(left  |> louder)
    ><
(right |> louder)
```

Two channels, two pipelines, no shared anything. Read the page: they are literally side by side. The shape on the page is the shape of the work; that is not a coincidence, it is a law, and the medium's formatter keeps it true, because layout belongs to the machine and meaning belongs to you.

The fourth verb, `~>`, answers a question you have not asked yet. It waits in chapter 5.

The fifth is the one to slow down for. Sound has memory. An echo is now plus a little of before; there is no echo without a before. Most languages make you build memory out of scaffolding. Here, memory is a shape you draw, a loop in the graph:

```
fn echo(mix, x) with Clock(48_000) =
  ((prev) => x + mix * prev) <~ delay(24_000)
```

Read it slowly. `<~` means "feeds back." The right side, `delay(24_000)`, is a memory element: it hands you back what you gave it 24,000 ticks ago, and at 48,000 ticks a second that is half a second, the slap of a stone room. The left side is what to do each tick: `prev` is the echo's own past, arriving back; the new sample is now plus a share of before. That is the whole physics of an echo, in one line you can read aloud.

And a promise rides inside it that you cannot see yet but should hear named: that `prev` is not a box being secretly allocated each tick. The medium inlines the loop into a register, which is why, chapters from now, this same echo will sit inside a function that has sworn never to allocate, and the oath will hold.

The same verb, one tick deep instead of half a second, is a tone control:

```
fn lowpass(a, x) with Clock(48_000) =
  ((prev) => a * x + (1.0 - a) * prev) <~ delay(1)
```

A little of now, a share of before, every tick, and the harshness averages away. Two memory elements so far, one shape; every register, filter, and accumulator you will ever meet is this verb at some depth.

Our instrument grows. The knob from chapter 1, the echo from this one:

```
fn wet(x) with Clock(48_000) =
  x
    |> louder
    |> echo(0.35)
```

Wait. `echo` takes two things, mix and sample, and the pipe hands it only one. That is the quiet elegance of `|>`: a stage with one missing piece is not an error, it is a socket, and the pipe fills it with what flows. `echo(0.35)` is an echo already set to taste, waiting for its sound. Configuration first, the flowing thing last; every stage in the medium obeys that law, so chains never need glue.

That is the arm called Verbs. Its question: **which way does this flow?**

### 4 · Ask — the arm called Row, first hand

Look again at something that has been sitting in plain sight since the echo:

```
with Clock(48_000)
```

`with` is the most honest word in this medium. Everything after it is the row: the list of what this function needs from the world, and later, what it swears never to do to the world. The echo needs a heartbeat, a clock ticking 48,000 times a second, because "half a second ago" means nothing without one. So it says so, in its own signature, where you can read it.

Sit with how strange and how right that is. In most languages a function's signature tells you what goes in and what comes out, and everything else, that it reads the disk, that it phones a server, that it needs a clock, is a rumor you learn by reading its guts, or by being burned. Here the signature is the confession. Needs are declared:

```
effect Audio {
  mic() -> Float
  play(s: Float)
}
```

That is an effect: a named set of operations the world must provide. A microphone that yields the next sample of air; a speaker that takes one. Declaring it costs nothing and promises nothing about how; it only gives the need a name.

And using a need is just calling it. No ritual, no special posture: `mic()` where you want the next sample, exactly as you would call any function. The medium knows it is a need and not a function because of what it is, not because you bowed first.

```
fn show() with Audio + Clock(48_000) =
  mic() |> wet |> play
```

Read the row aloud: show needs a microphone and a speaker, and a 48k heartbeat. That is not documentation that might be stale. The medium reads the body, sees every need the code actually touches, and verifies the confession against the truth. Claim less than you use and it refuses. Claim more and it nudges you, gently, in its own voice: you asked for more than you need; tighten it, and here is what tightening unlocks. The row is checked speech, both directions.

One more mercy hidden in plain sight: `Clock(48_000)` and `Clock(44_100)` are different needs. A function tuned to one heartbeat cannot be quietly wired to another; where two rates meet, the medium demands you say how, out loud, at the seam. Whole studios of subtle grief, refused at compile. The heartbeat itself is declared once, in the clock library, the same way `Audio` is declared here; the last page imports it like anything else.

That is the first hand of the arm called Row. Its question: **what does this need?**

### 5 · Answer — the arm called Handlers

Chapter 4 declared needs. Someone must answer them, and here is the fourth verb, and with it the sentence that reorganizes how you think about software:

**The code that needs, and the code that answers, are different code, and the caller decides who answers.**

An answer is a handler:

```
handler on_stage {
  mic() => resume(line_in()),
  play(s) => {
    line_out(s)
    resume()
  },
}
```

Read an arm aloud: when someone asks for the mic, take the next sample off the hall's line-in and resume them with it, resume meaning "carry on where you left off, here is what you asked for." When someone plays a sample, put it on the wire, resume them with nothing. A handler is a small dictionary of answers, and `resume` is the act of answering.

Install it with the fourth verb:

```
show() ~> on_stage
```

`~>` reads "answered by." It is deliberately the loosest binder in the language: the handler at the foot of a chain catches everything above it, the way the ground catches everything dropped. And now watch what the separation buys. The same show, unchanged, in three worlds:

```
show() ~> on_stage             // the hall: real mic, real speakers
show() ~> to_tape("night.raw") // the same show, recorded
show() ~> in_test(known_air)   // the same show, in the lab
```

That third line deserves a scientist's respect, because it is a controlled experiment, the real thing. The same instrument, note for note, run inside a world you control completely:

```
handler in_test(input: [Float]) with i = 0, heard = [] {
  mic() => resume(input[i]) with i = i + 1,
  play(s) => resume() with heard = heard ++ [s],
}
```

The `with i = 0, heard = []` gives the handler its own memory, evolving as it answers: feed the known air in one sample at a time, keep everything the hall would have heard. No mock frameworks, no dependency injection, no test doubles; those are three industries built to fake what "the caller decides who answers" simply is. You do not mock. You answer.

And handlers stack. Each `~>` wraps the one above it, so the outermost handler is the outermost authority; put the untrusted thing on the inside and the sandbox on the outside, and the stack of answers is the chain of trust, readable top to bottom on the page.

That is the arm called Handlers. Its question: **who answers this?**

### 6 · Refuse — the arm called Row, second hand

Now the chapter the whole book has been walking toward. The row's first hand said what a function needs. The second hand says what it can never do, and this is the hand that holds the true name.

Picture the third night of a tour. Two thousand people. Fifty seconds into the set, the voice stutters, one dropped buffer, a click like a snapped string, because somewhere down the call tree one line allocated memory at the wrong moment and the collector chose its moment the way it always does.

The dread from the door, in a dressing room.

Every audio programmer alive holds that dread at bay the same way: discipline, code review, convention, a wiki page that says never allocate on the audio thread. A promise. And you know from the door what a promise is worth when the surface can lie.

Here is the same intention, said in this medium; `wet` has grown up, taken its stage name, and traded chapter one's knob for the desk's own units:

```
fn voice(x) with Clock(48_000) + !Alloc =
  x
    |> gain(-3.0)
    |> lowpass(0.2)
    |> echo(0.35)
```

`!Alloc`. Read it: cannot allocate. Not "does not," not "was tested and didn't," not "the team agreed not to." Cannot, proven, transitively: the gain, the filter, the echo and its half-second memory, everything they call, everything those call, to the bottom. If one line anywhere beneath this signature allocates, the program does not build, and the refusal arrives with the chain of reasons walked back to the guilty line. The dread does not get quieter. It gets impossible.

This is `!E`, effect negation, and you should know plainly: the medium you are learning is the one place in software where this word exists with teeth. Everything else in this book has cousins scattered across other languages. The proven negative, transitive, compile-time, does not. And it is the guarantee the machine-writing age actually needs, because it is the true name from the story. Watch:

```
fn admit(pedal, x) with !Network + !FileSystem =
  play_through(pedal, x)
```

A guest effect, a pedal someone else built, plugged into your voice. You did not read its code. You cannot; there is too much of it, and tomorrow there will be more, and no one you trust wrote it. You do not need to. The row is the door policy: inside this signature the guest cannot reach the network and cannot touch a file, and if anything inside it tries, there is no built program to run. It can be brilliant. It can be a thousand times cleverer than you. It cannot phone home. Let the machine write. Let anything write.

The false one passes every test you invent. It cannot say your name.

There is also the total refusal, `Pure`, the empty row: no needs, no world, arithmetic and nothing else, the strongest thing you can say about a function and the medium proves it like everything else. And refusals compose with needs in one algebra: a row like `Audio + Clock(48_000) + !Alloc` reads exactly as it should, needs the hall and the heartbeat, touches nothing else's memory.

That is the second hand of the arm called Row, and its question is the one from the door: **what can this never do?**

### 7 · Bound — the arm called Refinement

The welder from the door pulls the coupon until it holds or breaks, and writes down the number, and the number is the fact. This chapter is the number.

A type, so far, is a shape. A refinement is a shape with a law inside it:

```
type Sample = Float where -1.0 <= self <= 1.0
```

Read it: a Sample is a Float that has sworn to stay between minus one and one, the range a speaker survives, the line between music and a blown driver. The `where` clause is a predicate, and the medium's prover discharges it at compile time: anywhere a Sample is minted, the proof that it is in range must go through, or nothing builds. And at runtime the law costs nothing, because it was settled before running was allowed.

```
let ok:  Sample = 0.5    // proven, silently
let bad: Sample = 1.5    // refused: 1.5 violates -1.0 <= self <= 1.0
```

Now change the world the way `Triangle` changed it in chapter 2, this time by law. The speaker deserves protection at the seam itself, so tighten the need's own contract:

```
effect Audio {
  mic() -> Float
  play(s: Sample)
}
```

One word changed: the speaker no longer accepts any float, it accepts a lawful one. And the medium hands you the list again. `show` refuses to build, because the chain flowing into `play` proves nothing yet about its range. Reality changed; the program must prove its way back in.

The proof is one stage, the last our voice needs:

```
fn soft_clip(x) -> Sample = (2.0 / pi) * atan(x)
```

This claims to take any float, any wildness the echo and the gain conspire to produce, and return a Sample, lawful, in range. Where is the proof? In the mathematics: atan of anything lands in an open interval, scale it and the result cannot leave minus one to one. The prover checks the math, not the vibes. `soft_clip` does not clamp the signal after the fact; it is a function whose shape makes clipping unrepresentable. The instrument cannot clip, not because we tested a lot, but because there is no value of type Sample that clips, and the voice returns Sample.

With the proof in hand, complete the chain; the line from chapter one comes back:

```
fn voice(x) -> Sample with Clock(48_000) + !Alloc =
  x
    |> gain(-3.0)
    |> lowpass(0.2)
    |> echo(0.35)
    |> louder
    |> soft_clip
```

Look at the stage before the clip: `louder`, chapter one's line, unchanged. Doubling the pressure of a signal is the most dangerous thing a chain can do to a speaker; here it is the drive that leans the sound into the curve, and it cannot do harm, because there is no value of type Sample that clips, and what follows it returns Sample. The school's first promise is kept the way this medium keeps every promise: the dangerous line was not removed, what follows it was bounded.

Point `show` at the finished voice, its row taking the same oath, and the refusal lifts; the proof travels the whole seam:

```
fn show() with Audio + Clock(48_000) + !Alloc =
  mic() |> voice |> play
```

For the metalworker, the same arm in heavier iron:

```
type Sealed = Kiln where self.door == Closed

fn ignite(k: Sealed) with Flame =
  ...
```

`ignite` does not take a kiln. It takes a *sealed* kiln; the door state is in the type. There is no code path in which the flame lights while the door stands open, not because a warning sticker asks nicely, but because the open-door call does not compile. Safety not as procedure. Safety as grammar.

And where the prover cannot settle a law statically, it does the one thing this medium always does: it says so, out loud, names the obligation, and holds it in the open ledger until it is discharged. Never a silent assumption. The medium does not believe. That is the point of it.

That is the arm called Refinement. Its question, the welder's question: **what bounds this?**

### 8 · Hold — the arm called Ownership

A short chapter, because its triumph is how little of it you will ever see.

Every value has a holder. Give a value away and it is gone from your hands; show a value to readers and they may look, not touch. Other languages either ignore this truth and pay in crashes and corruption, or enforce it and pay in ceremony, a tax of annotations on every line. This medium takes a third road: it infers the holding from what your code already does. Use a value once and it moves. Show it to many and they borrow. You write nothing, and the safety is total anyway; the medium's own law for this arm is blunt: if you have to think about it, the inference has failed.

You have already used it without knowing. Chapter 3's fanout:

```
signal
  <| (
    meter,
    to_waveform,
  )
```

`<|` shows one value to many branches, so the branches borrow, look-only, enforced. And `><` runs pipelines that share nothing, each holding its own. Which is why this, from our instrument's stereo stage, is parallel with a proof attached:

```
(left  |> voice)
    ><
(right |> voice)
|> interleave
~> Thread
```

The `~> Thread` at the foot answers the fanout's how: run the sides on real cores. And here two arms shake hands. The verb proved the branches share nothing; ownership proved nobody mutates what anybody borrows; therefore the threads cannot race, not because a lock arbitrates the fight, but because the fight has no object. Absence of conflict, proven, the same way `!Alloc` was proven. Take `~> Thread` away and the same shape runs sequentially, deterministic, debuggable. The shape is yours; the how is an answer, installed at the foot like every answer in this medium.

That is the arm called Ownership. Its question: **who holds this?**

### 9 · Remember — the arm called Reasons, and time

Two kinds of memory are usually lost. What the program was doing. And why the program is the way it is. This medium loses neither.

First, the doing. Because a program here is one graph in one flat block of memory, a running computation, paused mid-note, is a contiguous record: the continuation, the "rest of what I was going to do," as a thing you can hold. And a thing that is one record in one block can be saved with a single copy. Not serialized by a framework, not reconstructed from logs by an engine someone maintains; copied, byte for byte, the way you copy anything. Which turns crash-survival into one more installed answer:

```
show()
  ~> on_stage
  ~> clock(48_000)
  ~> persist("live.image")
```

One line appended to the stack of answers, and the show mid-note is a file. Power fails at the bridge of the song; the machine returns; the image resumes where the air stopped. Elsewhere, whole industries hand-build this out of checkpoints and replay engines. Here it falls out of the memory model, because a continuation was never anything but a value with a shape, and you know the five shapes.

And a saved doing is honest about its world: a continuation resumed under answers different from the ones it was frozen with is a compile-time refusal, not a corruption at three in the morning. Even time must say its name.

Second, the why. Every conclusion the medium reaches, every type it infers, every proof it discharges, every value a default filled in, carries a reason, and reasons chain to the root. Ask, at any point, in your editor or at the command line:

```
$ mentl why voice.mn:9 mix
  mix = 0.35, set at show.mn:4, the desk preset
  flows into echo(mix, x) at voice.mn:9
  output bounded by Sample: proven -1.0 <= self <= 1.0 via soft_clip
```

Walkable, to the root, always. And your own prose rides the same rails: a `//` comment is not whitespace the machine skips, it is attached to the graph beside the thing it explains, carried, surfaced when the thing is questioned, never dropped. The storyteller's arm: provenance. Ten years from now, someone who is not you, or a machine that is not anyone, changes this program. The why is still there, in the graph, walkable. What you meant does not rot into what it became. That sentence was a vow at the door. This is the machinery of the vow.

That is the arm called Reasons. Its question, the oldest question: **why is this here?**

### 10 · Unlock — the arm called Gradient

The last arm reverses the polarity of everything you know about annotations.

Elsewhere, annotation is tax: write types or it will not run. Here the medium infers everything, so every mark you add is not payment, it is a key. You never annotate to satisfy the medium. You annotate to unlock the next capability, and the medium narrates the exchange as you go. Write nothing: it runs. Add `!Alloc`: proven, and now it may stand in the real-time path. Add `where`: proven, and now the bounds-check disappears from the built code, because the proof made it dead weight. Pin a width when precision is a decision and not a detail:

```
type Coeff = Float repr f64
```

and the desk's filter math holds full double precision while everything you did not pin finds its natural width on its own; ask the medium and it shows its choices as read-only badges, `c : Float @ f64 (inferred)`, output, never homework.

There is a mark for absence itself. Where you do not yet know what to write, say so, honestly:

```
fn brighten(amount: Float, x: Float) -> Float with Pure = ??
```

`??` is the hole, and in the medium's own font it renders as a small octagonal socket, eight-sided, one side per arm, which is exactly what a hole is: a place where all eight questions are known and the answer is not yet. That is why this signature, alone in the school, spells everything out; the socket's shape, two `Float`s in, one out, `Pure`, is the constraint set every proposal must fit, and the more the signature says, the less an imposter can slip through. And into the socket, the medium proposes. Its search, or a model's suggestion, or a stranger's patch, it does not matter, and that indifference is the whole point of the door: any intelligence may propose. Every candidate must run the same gauntlet, forked off to the side, typed, proven against the row and the bounds, rolled back without a trace if it cannot say the name. What survives is shown to you with its reasons attached, and nothing that failed ever touches your program. The machine can write. The machine cannot make it false.

The door from the first pages, standing open on your own desk.

That is the arm called Gradient. Its question: **what would unlock this?**

### The instrument, whole

Every chapter promised you would never rewrite it. Here it is, one page. The imports at the top, two lines of decibel arithmetic, and `main` at the bottom are the only lines you have never met; read them cold and notice that they simply open. That is the school's real measure. Everything else you have already read:

```
import dsp/feedback {delay}
import dsp/clock {clock, Clock}
import dsp/signal {line_in, line_out}
import std/persist {persist}

// The law of the speaker: a sample that cannot clip.
type Sample = Float where -1.0 <= self <= 1.0

effect Audio {
  mic() -> Float
  play(s: Sample)
}

fn louder(x) = x * 2.0

fn from_db(db) with Pure = pow(10.0, db / 20.0)

fn gain(db, x) with Pure = x * from_db(db)

fn lowpass(a, x) with Clock(48_000) =
  ((prev) => a * x + (1.0 - a) * prev) <~ delay(1)

fn echo(mix, x) with Clock(48_000) =
  ((prev) => x + mix * prev) <~ delay(24_000)

fn soft_clip(x) -> Sample = (2.0 / pi) * atan(x)

// The voice: cannot clip, cannot stutter. Proven, not promised.
fn voice(x) -> Sample with Clock(48_000) + !Alloc =
  x
    |> gain(-3.0)
    |> lowpass(0.2)
    |> echo(0.35)
    |> louder
    |> soft_clip

fn show() with Audio + Clock(48_000) + !Alloc =
  mic() |> voice |> play

handler on_stage {
  mic() => resume(line_in()),
  play(s) => {
    line_out(s)
    resume()
  },
}

fn main() =
  show()
    ~> on_stage
    ~> clock(48_000)
    ~> persist("live.image")
```

Read it top to bottom, aloud, one last time, and hear what you could not have heard ten chapters ago. A law, then a need, then six plain sentences of arithmetic and memory, the first of them the first line you ever wrote. A voice that swears two oaths in its own signature and is held to both, transitively, to the bottom of everything it calls. A show that asks for a hall. A hall that answers. A heartbeat. A copy of time itself, standing by against the dark. Under it, one graph; over it, eight questions; inside it, no place for a lie to stand.

Swap `on_stage` for `in_test(known_air)` and it is a laboratory. Fan `voice` across `><` and foot the chain with `~> Thread` and it is parallel, provably race-free. Hand `brighten`'s socket to the strongest proposer alive and sleep well. The best engineers on earth could not hand-verify what this one page simply *is*.

---

## First Light

One thing remains to tell you, and it is the reveal the whole school has been keeping.

The eight questions you now carry, what is this really, which way does it flow, what does it need and what can it never do, who answers, what bounds it, who holds it, why is it here, what would unlock it: those are not a study aid. They are, literally, the compiler. That is what this medium's compiler is: one read of the graph that asks exactly these questions at every node, and refuses to look away from any answer. You have not been learning *about* Mentl, chapter by chapter. You have been becoming its reading. When you look at a stranger's code now, or a machine's, and the questions rise on their own, you are doing what the medium does. That is why you can trust code no one you trust wrote: not because you believe harder, but because you and the medium now ask the same questions, and neither of you accepts looks-right for an answer.

And the medium asks them of itself. Its compiler is written in it, an answer installed on its own graph; its prover proves its own passes; every improvement anyone will ever make to it is a move within it. It has no outside. The day it compiles itself and the output is itself, byte for byte, is called first-light, the telescope's first whole sky, the fire that feeds itself, the medium pronouncing its own true name and the name holding.

At the door, you read a sentence and felt it. Read it now, one page after writing an instrument that cannot lie about itself, and notice that you no longer have to take it on faith, which is fitting, because taking things on faith is the one habit this medium exists to end.

It can wear your face. It cannot say your name.

The name is Mentl.

Nothing runs that cannot say its name.

---

## The law and the road

[`docs/SYNTAX.md`](docs/SYNTAX.md) is the law this book teaches: every form, with the reasoning that forced it. The school's chapters mirror the runnable tutorials in [`lib/tutorial/`](lib/tutorial/), `00-hello.mn` through `08-reasons.mn`, one file per arm. The compiler lives in [`src/`](src/), written in Mentl; the standard library and the DSP and ML arms live in [`lib/`](lib/); the disposable seed that sparks the first compilation lives in [`bootstrap/`](bootstrap/). Ground truth is one command: `bash tools/verify.sh`.

Dual-licensed under MIT or Apache 2.0. See `LICENSE-MIT` and `LICENSE-APACHE`.
