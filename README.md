# Mentl

> Program testing can be used to show the presence of bugs, but never to show their absence.
> — Edsger W. Dijkstra

Mentl is humanity's verification substrate for the age of machine-written code. Any intelligence may propose; no hidden or refuted claim crosses the executable boundary; intent is never lost; capability is always bounded.

```
type Sample = Float where -1.0 <= self <= 1.0

fn voice(x) -> Sample with Sample(48_000) + !Alloc =
  x |> gain(-3.0) |> lowpass(0.2) |> echo(0.35) |> louder |> soft_clip
```

Two lines to hold in your hand before anything else. The first declares a number that cannot leave the range a speaker can survive; not checked at runtime, proven at compile, erased before it runs. The second declares a function that cannot allocate memory, anywhere, transitively, down through everything it calls; if one line five layers deep breaks that promise, this does not build. Proven before it runs. Not observed while you pray.

This document is the whole front door: one program you can run now, a story, then a school. The story asks nothing of you. The school starts from nothing and ends with the whole medium in one program.

*This README is the product contract. It describes perfected Mentl in the present tense so a contributor can point at an example and say: make this true. [`docs/SYNTAX.md`](docs/SYNTAX.md) is the surface authority; where an example and the syntax law disagree, the example is wrong. [Artifact today](#artifact-today) records exactly how far the implementation has reached without weakening the target.*

## Try Mentl now

The smallest honest program already carries the whole method:

```mn
fn twice(x) = x + x
fn main() = 21 |> twice
```

With Wasmtime and WABT installed:

```sh
git clone https://github.com/ampactor-labs/mentl.git
cd mentl
bash tools/install.sh

cat > hello.mn <<'MN'
fn twice(x) = x + x
fn main() = 21 |> twice
MN

mentl check hello.mn
mentl run hello.mn
echo $?                         # 42
mentl query hello.mn "type twice"
mentl teach hello.mn
```

`mentl check` is silent. `mentl run` returns 42. The query projects the inferred pure function, its inferred `ref` parameter, and the Reason leading back to `twice`'s declaration. `teach` proposes `!Alloc` because the graph already proves zero allocation. These results are direct gates of the pinned compiler, not screenshots of the target.

The quoted query is today's batch transport. The perfected surface below puts one cursor at an address and projects every facet from that one read; it does not make users memorize string commands.

The eight interrogations are already present at this tiny cursor:

| Interrogation | What the program says |
|---|---|
| **Graph?** | `main`, `twice`, the literal, and the pipe are typed nodes and edges. |
| **Handler?** | None is needed; there is no effect to answer or continuation to resume. |
| **Verb?** | `\|>` completes `twice`'s one remaining product hole with `21`. |
| **Row?** | The body proves `Pure`. |
| **Ownership?** | `x` is read twice, so the parameter is inferred `ref`. |
| **Refinement?** | None is authored; the unbounded `Int` is visible honestly. |
| **Gradient?** | The cursor can propose `!Alloc` as a capability-unlocking input. |
| **Reason?** | Type and ownership projections walk back to the declaration and uses. |

If you want the language, continue into [The School](#the-school). If you want why the language has to exist, enter [The Door](#the-door) first. If you are implementing Mentl, read the walkthrough as executable product specification, then ground every claim in [Artifact today](#artifact-today) and `bash tools/state.sh`.

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

In this medium, nothing runs under a hidden or refuted claim. Code does not get the benefit of looking right: every obligation is proven, refused, or carried as visible debt, and unknown is never silently promoted to true. The proof that matters most is the one existing toolchains rarely make both transitive and executable: the proof of the negative. Not "we watched it and it never phoned home." Cannot. Write `with !Network` on a function and the medium proves that nothing it calls, and nothing they call, all the way down, can reach the network; or it refuses to build. That is a program's true name: not what it did while you watched, but what it is unable to do when you don't.

And the name is not only a wall; it is a record of the why. Everything in this medium carries the reason it exists, walkable back to the root, so that what you meant does not rot into what it became. In the story, the man loses his name and his hands stop being his own. Here, intent is never lost.

Understand what that makes possible, because this is the part that is not a horror story. You do not hold the name to bar the door. You hold the name so you can open it. Let the machine write. Let anything write. The test never asks who made you; it asks for the name, and whatever can truly say it is the thing itself. Machine code that proves it cannot reach your files is safer than human code that promises. The medium does not fear a stronger writer. Every stronger writer that walks through the proof makes the house richer, and none of them can make it false.

It can wear your face. It cannot say your name.

· · ·

A fair question: why is this the end of the road, and not the next station on it?

Because of the shape of the thing. One graph. Two moves: draw an edge, read what is there. There is no third. The compiler, the type system, the prover, the debugger, the machinery that spreads your work across a hundred cores: not separate machines bolted together, but one graph read in different lights. The graph is the truth. Everything else you will ever see of it, the source, the errors, the docs, is a shadow it throws, and every shadow can be walked back to the body.

Pieces of this have been built before, one arm at a time, each a decade of someone's life. One language got the pipes right and never reached the effects. One got the effects right on a host that fought it. One got ownership right and still cannot say what a function must never do. Each stopped exactly where its one arm ended. This is the body.

A tool you can surpass keeps its own improvement machinery outside itself; to beat it, you leave it. Mentl's compiler is a move within its own graph. A better prover, a faster backend, and a stronger proposer are moves within that graph too. The day it reproduces itself byte for byte while independent semantic and refusal gates still hold, the toolchain closes its own improvement loop. That is Mentl's `!Outside`: not independence from hardware or human intent, but no privileged compiler outside the medium that contributors must leave Mentl to improve.

The day has a name. This medium was called Light when it was born, before it could do anything at all: a medium where nothing about a program is hidden, where the complexity is real and present and visible, clarity instead of the false ease that papers over what is hard. It has been renamed twice since. The day it reproduces itself and survives the independent questions it asks of every other program is still called first-light, because that was always the point. A telescope's first light is the first sky it catches whole. A reactor's is the first fire that feeds itself.

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

`><` declares independent things side by side:

```
(left  |> louder)
    ><
(right |> louder)
```

Two channels, two pipelines, no shared anything. Read the page: they are literally side by side. Independence is the topology; execution strategy is an answer installed later with `~>`. With no schedule installed the branches run sequentially in source order. A Thread, SIMD, or device handler may cash the same proof out differently without changing either branch. The shape on the page is the shape of the work; that is not a coincidence, it is a law, and the medium's formatter keeps it true, because layout belongs to the machine and meaning belongs to you.

The fourth verb, `~>`, answers a question you have not asked yet. It waits in chapter 5.

The fifth is the one to slow down for. Sound has memory. An echo is now plus a little of before; there is no echo without a before. Most languages make you build memory out of scaffolding. Here, memory is a shape you draw, a loop in the graph:

```
fn echo(mix, x) with Sample(48_000) =
  ((prev) => x + mix * prev) <~ delay(24_000)
```

Read it slowly. `<~` means "feeds back." The right side, `delay(24_000)`, is a memory element: it hands you back what you gave it 24,000 ticks ago, and at 48,000 ticks a second that is half a second, the slap of a stone room. The left side is what to do each tick: `prev` is the echo's own past, arriving back; the new sample is now plus a share of before. That is the whole physics of an echo, in one line you can read aloud.

And a promise rides inside it that you cannot see yet but should hear named: that `prev` is not a box being secretly allocated each tick. The medium inlines the loop into a register, which is why, chapters from now, this same echo will sit inside a function that has sworn never to allocate, and the oath will hold.

The same verb, one tick deep instead of half a second, is a tone control:

```
fn lowpass(a, x) with Sample(48_000) =
  ((prev) => a * x + (1.0 - a) * prev) <~ delay(1)
```

A little of now, a share of before, every tick, and the harshness averages away. Two memory elements so far, one shape; every register, filter, and accumulator you will ever meet is this verb at some depth.

Our instrument grows. The knob from chapter 1, the echo from this one:

```
fn wet(x) with Sample(48_000) =
  x
    |> louder
    |> echo(0.35)
```

Wait. `echo` takes two things, mix and sample, and the pipe hands it only one. That is the quiet elegance of `|>`: a stage with one missing piece is not an error, it is a socket, and the pipe fills it with what flows. `echo(0.35)` is an echo already set to taste, waiting for its sound. Configuration first, the flowing thing last; every stage in the medium obeys that law, so chains never need glue.

That is the arm called Verbs. Its question: **which way does this flow?**

### 4 · Ask — the arm called Row, first hand

Look again at something that has been sitting in plain sight since the echo:

```
with Sample(48_000)
```

`with` is the most honest word in this medium. Everything after it constrains the row: what this function may need from the world, and later, what it swears never to do to the world. The body is still the contract. The medium infers the exact row from operation-call edges, verifies it against the authored constraint, and publishes the inferred truth to callers. The echo needs a sample clock ticking 48,000 times a second, because "half a second ago" means nothing without one. So it says so, in its own signature, where you can read it.

Sit with how strange and how right that is. In most languages a function's signature tells you what goes in and what comes out, and everything else, that it reads the disk, that it phones a server, that it needs a clock, is a rumor you learn by reading its guts, or by being burned. Here the signature is a checked intention and the graph carries the exact confession. Needs are named:

```
effect Audio {
  mic() -> Float
  play(s: Float) -> ()
}
```

That is an effect: a named set of operations the world must provide. A microphone that yields the next sample of air; a speaker that takes one. Declaring it costs nothing and promises nothing about how; it only gives the need a name.

And using a need is just calling it. No ritual, no special posture: `mic()` where you want the next sample, exactly as you would call any function. The medium knows it is a need and not a function because of what it is, not because you bowed first.

```
fn show() with Audio + Sample(48_000) =
  mic() |> wet |> play
```

Read the row aloud: show admits Audio and a 48k sample clock. That is not documentation that might be stale. The medium reads the body, sees every need the code actually touches, and verifies the constraint against the truth. Claim less than the body uses and it refuses. Claim more and it can tighten the input without infecting callers with an effect the body never performs. The row is checked speech, both directions.

One more mercy hidden in plain sight: `Sample(48_000)` and `Sample(44_100)` are different needs. A function tuned to one sample rate cannot be quietly wired to another; where two rates meet, the medium demands you say how, out loud, at the seam. Whole studios of subtle grief, refused at compile. The sample clock itself is declared once, in the DSP clock library, the same way `Audio` is declared here; the last page imports it like anything else.

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

Read an arm aloud: when someone asks for the mic, take the next sample off the hall's line-in and resume them with it, resume meaning "carry on where you left off, here is what you asked for." When someone plays a sample, put it on the wire, resume them with nothing. A handler is a typed set of answer arms, and `resume` is the act of answering.

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

`resume` is not secretly one-shot. Its cardinality is inferred from the handler body, because the body already proves it. Zero or one resume site outside loop or recursion ancestry is `OneShot`; several branch-disjoint sites are still one-shot because only one can run. A site beneath loop or recursion ancestry, or two sites reachable on one path, is `MultiShot`. If distinct installation sites require different disciplines, the unresolved operation projects `Either` instead of pretending the choice was settled.

```mn
effect Choose { choose() -> Int }

handler both {
  choose() => {
    let first = resume(1)
    let second = resume(2)
    first + second
  }
}

fn score() = choose() * 10
fn explore() = score() ~> both
```

`score` asks once. `both` resumes the rest of `score` with 1 and again with 2: one request, two resumptions, two futures, combined as 10 + 20. Nobody annotates a continuation kind; the arm's control shape already proves it, and the cursor projects the result.

This is Mentl's time axis. A multi-shot continuation is a typed fork of the rest of a computation. Different answers can search, teach, resume a filled hole, or let you revisit an earlier point without inventing a second control surface. Later, `><` will expose independent space and the memory image will provide the substrate. Time, space, and substrate meet without adding another surface verb.

And handlers stack. Each `~>` wraps the one above it, so the outermost handler is the outermost authority; put the untrusted thing on the inside and the sandbox on the outside, and the stack of answers is the chain of trust, readable top to bottom on the page.

That is the arm called Handlers. Its question: **who answers this?**

### 6 · Refuse — the arm called Row, second hand

Now the chapter the whole book has been walking toward. The row's first hand said what a function needs. The second hand says what it can never do, and this is the hand that holds the true name.

Picture the third night of a tour. Two thousand people. Fifty seconds into the set, the voice stutters, one dropped buffer, a click like a snapped string, because somewhere down the call tree one line allocated memory at the wrong moment and the collector chose its moment the way it always does.

The dread from the door, in a dressing room.

Every audio programmer alive holds that dread at bay the same way: discipline, code review, convention, a wiki page that says never allocate on the audio thread. A promise. And you know from the door what a promise is worth when the surface can lie.

Here is the same intention, said in this medium; `wet` has grown up, taken its stage name, and traded chapter one's knob for the desk's own units:

```
fn voice(x) with Sample(48_000) + !Alloc =
  x
    |> gain(-3.0)
    |> lowpass(0.2)
    |> echo(0.35)
```

`!Alloc`. Read it: cannot allocate. Not "does not," not "was tested and didn't," not "the team agreed not to." Cannot, proven, transitively: the gain, the filter, the echo and its half-second memory, everything they call, everything those call, to the bottom. If one line anywhere beneath this signature allocates, the program does not build, and the refusal arrives with the chain of reasons walked back to the guilty line. The dread does not get quieter. It gets impossible.

This is `!E`, effect negation, and it is Mentl's central bet: absence stays transitive through ordinary calls, higher-order values, handlers, and the executable boundary. Pieces of that story exist elsewhere. The claim here is the composition, because that is the guarantee the machine-writing age actually needs. Watch:

```
fn admit(pedal, x) with !Network + !FileSystem =
  play_through(pedal, x)
```

A guest effect, a pedal someone else built, plugged into your voice. You did not read its code. You cannot; there is too much of it, and tomorrow there will be more, and no one you trust wrote it. You do not need to. The row is the door policy: inside this signature the guest cannot reach the network and cannot touch a file, and if anything inside it tries, there is no built program to run. It can be brilliant. It can be a thousand times cleverer than you. It cannot phone home. Let the machine write. Let anything write.

The false one passes every test you invent. It cannot say your name.

There is also the total refusal, `Pure`, the empty row: no needs, no world, arithmetic and nothing else, the strongest thing you can say about a function and the medium proves it like everything else. And refusals compose with needs in one algebra: a row like `Audio + Sample(48_000) + !Alloc` reads exactly as it should, needs the hall and the sample clock, touches nothing else's memory.

That is the second hand of the arm called Row, and its question is the one from the door: **what can this never do?**

### 7 · Bound — the arm called Refinement

The welder from the door pulls the coupon until it holds or breaks, and writes down the number, and the number is the fact. This chapter is the number.

A type, so far, is a shape. A refinement is a shape with a law inside it:

```
type Sample = Float where -1.0 <= self <= 1.0
```

Read it: a `Sample` is a Float that has sworn to stay between minus one and one, the range a speaker survives, the line between music and a blown driver. The `where` clause is a predicate. Every construction reaches `Verify` as one of three honest facts: proven, refuted, or still undecidable. A refutation refuses the executable; an undecidable obligation remains visible as `V_Pending` and is never silently assumed. Once the law is proven, it costs nothing at runtime because there is nothing left to check.

```
let ok:  Sample = 0.5    // proven, silently
let bad: Sample = 1.5    // refused: 1.5 violates -1.0 <= self <= 1.0
```

Now change the world the way `Triangle` changed it in chapter 2, this time by law. The speaker deserves protection at the seam itself, so tighten the need's own contract:

```
effect Audio {
  mic() -> Float
  play(s: Sample) -> ()
}
```

One word changed: the speaker no longer accepts any float, it accepts a lawful one. And the medium hands you the list again. `show` refuses to build, because the chain flowing into `play` proves nothing yet about its range. Reality changed; the program must prove its way back in.

The proof is one stage, the last our voice needs:

```
fn soft_clip(x) -> Sample = (2.0 / pi()) * atan(x)
```

This claims to take any float, any wildness the echo and the gain conspire to produce, and return a `Sample`, lawful, in range. Where is the proof? In the mathematics: atan of anything lands in an open interval, scale it and the result cannot leave minus one to one. The prover checks the math, not the vibes. `soft_clip` does not clamp the signal after the fact; it is a function whose shape makes clipping unrepresentable. The instrument cannot clip, not because we tested a lot, but because no `Sample` clips, and the voice returns one.

With the proof in hand, complete the chain; the line from chapter one comes back:

```
fn voice(x) -> Sample with Sample(48_000) + !Alloc =
  x
    |> gain(-3.0)
    |> lowpass(0.2)
    |> echo(0.35)
    |> louder
    |> soft_clip
```

Look at the stage before the clip: `louder`, chapter one's line, unchanged. Doubling the pressure of a signal is the most dangerous thing a chain can do to a speaker; here it is the drive that leans the sound into the curve, and it cannot do harm, because no `Sample` clips and what follows it returns one. The school's first promise is kept the way this medium keeps every promise: the dangerous line was not removed, what follows it was bounded.

Point `show` at the finished voice, its row taking the same oath, and the refusal lifts; the proof travels the whole seam:

```
fn show() with Audio + Sample(48_000) + !Alloc =
  mic() |> voice |> play
```

For the metalworker, the same arm in heavier iron:

```mn
type Door = Open | Closed
type Kiln = {door: Door}
type Sealed = Kiln where self.door == Closed

effect Flame { light(k: Sealed) -> () }

fn ignite(k: Sealed) with Flame =
  light(k)
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

First, the doing. A paused computation is a value you can hold: the continuation, the "rest of what I was going to do," with an exact effect world. But the continuation record alone is not an image. Every owned record reachable through its handles must close with it into one relocatable, versioned region; otherwise a copied pointer merely remembers where lost state used to be. `Persist` catches the reified suspension, freezes that closed world, and commits it crash-safely. Once those proofs hold, the fast path can be a bulk copy because the layout earned it, not because serialization was wished away:

```
show()
  ~> on_stage
  ~> sample_clock(48_000)
  ~> persist("live.image")
```

One answer appended to the stack, and every suspension in its scope can become a closed image. Power fails at the bridge of the song; the machine returns; the journal restores a version it committed whole, and the image resumes under the same typed world. Elsewhere, whole industries hand-build this out of checkpoints and replay engines. Here it is the composition of continuation, ownership, region, row, and Reason rather than a second workflow language.

And a saved doing is honest about its world: a continuation resumed under answers different from the ones it was frozen with is a compile-time refusal, not a corruption at three in the morning. Even time must say its name.

Second, the why. Every conclusion the medium reaches, every type it infers, every proof it discharges, every value a default filled in, carries a reason, and reasons chain to the root. Put the cursor on the call, in an editor or through the smallest command-line transport:

```text
$ mentl voice.mn:9
  Query: echo(mix, x) -> Sample
  Effects: Sample(48_000)
  Why: mix = 0.35, set at show.mn:4, the desk preset
       flows into echo(mix, x) here
       output bounded by Sample via soft_clip
```

Walkable, to the root, always. And your own prose rides the same rails: a `//` comment is not whitespace the machine skips, it is attached to the graph beside the thing it explains, carried, surfaced when the thing is questioned, never dropped. The storyteller's arm: provenance. Ten years from now, someone who is not you, or a machine that is not anyone, changes this program. The why is still there, in the graph, walkable. What you meant does not rot into what it became. That sentence was a vow at the door. This is the machinery of the vow.

That is the arm called Reasons. Its question, the oldest question: **why is this here?**

### 10 · Unlock — the arm called Gradient, at the cursor

The last arm reverses the polarity of everything you know about annotations.

Elsewhere, annotation is tax: write types or it will not run. Here the medium infers everything, so every mark you add is not payment, it is a key. You never annotate to satisfy the medium. You annotate to unlock the next capability, and the medium narrates the exchange as you go. Write nothing: it runs. Add `!Alloc`: proven, and now it may stand in the real-time path. Add `where`: proven, and now the bounds-check disappears from the built code, because the proof made it dead weight. Pin a width when precision is a decision and not a detail:

```
type Coeff = Float repr f64
```

and the desk's filter math holds full double precision while everything you did not pin finds its natural width on its own; ask the medium and it shows its choices as read-only badges, `c : Float @ f64 (inferred)`, output, never homework.

There is a mark for absence itself. Where you do not yet know what to write, say so, honestly. The annotations here are not base-type homework: `Mix` and `Sample` are refinement boundaries that constrain what may fill the socket.

```
type Mix = Float where 0.0 <= self <= 1.0
fn brighten(amount: Mix, x: Sample) -> Sample with Pure = ??
```

`??` is the hole. It is the place where all eight questions are known and the answer is not yet. The refinements, result, and `Pure` row are the authored intent every proposal must fit; an ordinary inferred base type would add no intent and does not belong here. The medium proposes into that hole — its own graph-native search explores every valid completion of the constraint space. An external proposal, a model's suggestion or a stranger's patch, faces the same gate: every candidate is forked aside, checked against the same graph facts, and discarded without a trace if it cannot say the name. Survivors keep their Reasons. The machine can write. The machine cannot make it false.

The cursor is not an editor caret with compiler plugins attached. It is the graph's own read head. Put it on a value, edge, diagnostic, hole, or suspended computation and the medium projects eight facets of the same address:

| Facet | What it projects |
|---|---|
| **Query** | What is this node? |
| **Propose** | Which verified moves fit here? |
| **Topology** | Which of the five verbs connects it? |
| **Effects** | What does its Boolean row require or exclude? |
| **Ownership** | Who owns or borrows it? |
| **Verify** | Which predicates are proven, refuted, or still visible debt? |
| **Teach** | Which annotation input would unlock the next capability? |
| **Why** | Which Reason path returns to the author's words? |

The cursor reads one graph address. `Propose` enumerates moves; type, row, ownership, and refinement facts reject incoherent ones. The gradient ranks the survivors from local authored intent and their Reasons. Annotations are inputs to that ranking, never tax. When two survivors remain, `Teach` asks for the one missing constraint that separates them; `Why` walks the retained Reason edge back to the author's words. The eight facets are synchronized projections of one read, not eight competing validators. When a hole suspends a running computation, filling it resumes the typed continuation instead of restarting the world. Multi-shot makes an earlier point on that worldline forkable, so debugging becomes a walk through explicit alternate realities rather than a reconstruction from logs.

The door from the first pages, standing open on your own desk.

That is the arm called Gradient. Its question: **what would unlock this?**

### The instrument, whole

Every chapter promised you would never rewrite it. Here it is, one page. Stereo gives `<|` and `><` honest work instead of displaying them as ornaments: the channels are independent, then their shared result is borrowed by audio and metering projections. All five verbs now appear because the topology needs all five.

```mn
import dsp/audio {Audio, mic_stereo, play_stereo, on_stage}
import dsp/clock {Sample, sample_clock}
import dsp/feedback {delay}
import dsp/meter {Meter, show_levels, meter_overlay}
import runtime/math {atan, pi, pow}
import runtime/persist {persist}
import runtime/threading {Thread}

// The law of the speaker: a sample that cannot clip.
type Sample = Float where -1.0 <= self <= 1.0

fn louder(x) = x * 2.0

fn from_db(db) with Pure = pow(10.0, db / 20.0)

fn gain(db, x) with Pure = x * from_db(db)

fn lowpass(a, x) with Sample(48_000) =
  ((prev) => a * x + (1.0 - a) * prev) <~ delay(1)

fn echo(mix, x) with Sample(48_000) =
  ((prev) => x + mix * prev) <~ delay(24_000)

fn soft_clip(x) -> Sample = (2.0 / pi()) * atan(x)

// The voice: cannot clip, cannot stutter. Proven, not promised.
fn voice(x) -> Sample with Sample(48_000) + !Alloc =
  x
    |> gain(-3.0)
    |> lowpass(0.2)
    |> echo(0.35)
    |> louder
    |> soft_clip

fn peak_levels(ref stereo) with Pure = {
  let (left, right) = stereo
  (left * left, right * right)
}

fn render(stereo) with Audio + Meter + Sample(48_000) + !Alloc = {
  let (left, right) = stereo
  let processed =
    ((left |> voice) >< (right |> voice))
      ~> Thread
  processed
    <| (
      play_stereo,
      (s) => s |> peak_levels |> show_levels,
    )
}

fn show() with Audio + Meter + Sample(48_000) + !Alloc =
  mic_stereo()
    |> render

fn main() =
  show()
    ~> on_stage
    ~> meter_overlay
    ~> sample_clock(48_000)
    ~> persist("live.image")
```

Read it top to bottom, aloud, one last time. `|>` completes each stage's open product field. `<~` closes the two recurrences. `><` states that the channels share nothing, and `Thread` answers that exact fanout at its installation site. `<|` lets the audio sink and the level projection borrow the same processed stereo product without taking it from each other. `~>` supplies the schedule where the topology lives, then the hall, overlay, sample clock, and durable-time policy at the outer seam. Those are not five syntactic tricks. They are the topology that lets rows, ownership, refinements, continuations, Reasons, and backend choice read the same program without re-deriving it.

Swap `on_stage` for `in_test(known_air)` and it is a laboratory. Change the answer installed beside the channel fanout from `Thread` to `Seq`, `Simd`, or `Gpu`, and the topology and proof remain while the schedule changes. Remove `persist` and the live show is unchanged except for its time policy. Hand `brighten`'s socket to the strongest proposer alive and judge only the survivors. Under it, one graph; over it, eight questions; inside it, no place for a lie to stand.

---

## First Light

One thing remains to tell you, and it is the reveal the whole school has been keeping.

The eight questions you now carry, what is this really, which way does it flow, what does it need and what can it never do, who answers, what bounds it, who holds it, why is it here, what would unlock it: those are not a study aid. They are, literally, the compiler. That is what this medium's compiler is: one read of the graph that asks exactly these questions at every node, and refuses to look away from any answer. You have not been learning *about* Mentl, chapter by chapter. You have been becoming its reading. When you look at a stranger's code now, or a machine's, and the questions rise on their own, you are doing what the medium does. That is why you can trust code no one you trust wrote: not because you believe harder, but because you and the medium now ask the same questions, and neither of you accepts looks-right for an answer.

And the medium asks them of itself. Its compiler is written in it, an answer installed on its own graph; its prover examines its own passes; improvements to the prover, backend, and proposer are moves within the same medium. First-light is the byte-identical fixed point paired with independent semantic, refusal, and adversarial evidence: reproduction plus reasons to trust what was reproduced. That is the toolchain's `!Outside`, the telescope's first whole sky, the fire that feeds itself, the medium pronouncing its own true name and the name holding.

At the door, you read a sentence and felt it. Read it now, one page after writing an instrument that cannot lie about itself, and notice that you no longer have to take it on faith, which is fitting, because taking things on faith is the one habit this medium exists to end.

It can wear your face. It cannot say your name.

The name is Mentl.

Nothing runs that cannot say its name.

---

## Artifact today

Everything above is the product contract. This section is the implementation ledger. The distinction is load-bearing: the target is never weakened to fit the current compiler, and current scaffolding is never advertised as the target already working.

The generated board is `bash tools/state.sh`; [`PLAN.md` §7](PLAN.md) is the one prose snapshot. This table records stable capability boundaries, not volatile hashes or counts:

| Capability | State | Direct evidence and remaining boundary |
|---|---|---|
| Self-hosting compiler | **LIVE** | The wheel compiles itself to byte-identical `m2 == m3`, with a separate micro battery. A fixed point proves reproduction, not correctness by itself. |
| Small project CLI | **LIVE** | The quickstart above checks cleanly, runs to 42, and projects type, ownership, and Reason from any directory. The ordinary import DAG still lacks vocabulary the concatenated wheel receives. |
| Graph inference and Reasons | **PARTIAL** | Typed graph edges and structured Reasons drive the compiler. Append-only evidence, minimal-cause Why, and complete stable addressing are not finished. |
| Five topological operators | **PARTIAL** | All five are canonical syntax with live compiler paths. Sequential pipe/fanout and handler installation are directly gated; feedback and schedule selection are bounded; Thread/SIMD/GPU execution is scaffold or target. |
| Boolean rows and `!E` | **PARTIAL** | Direct, transitive, and higher-order negation crucibles are green. Declared rows must finish behaving as constraints rather than published contracts, and executable refusal is not yet universal across every diagnostic class. |
| Handlers and multi-shot | **PARTIAL** | One-shot and in-process multi-shot continuations execute through direct gates, including nested backtracking shapes. Exact continuation worlds, general delimited control, durable images, and cross-process resume remain unfinished. |
| Ownership | **PARTIAL** | The wheel now has zero `E_OwnershipViolation`; alternative branches, function scope, conditions, field reads, and borrowing call parameters are gated, while real double moves still refuse. Production qualification remains broader than the wheel. |
| Refinements and holes | **PARTIAL** | Literal rejection, narrowing, visible proof debt, constrained-hole filtering, Reasons, patching, and hole refusal are live in bounded workflows. Full solver coverage, teaching tie-break, fill-and-resume, and timeline scrubbing remain work. |
| Cursor medium | **PARTIAL** | `query`, `audit`, and `teach` reach real projections, and bounded hole-edit workflows apply verified patches. Ordinary `mentl edit <path>` still traps; the eight synchronized facets, incremental delta cone, formatter/LSP/browser parity, and complete Why surface are not finished. |
| Regions and persistence | **TARGET beyond a live floor** | Compile-time region tagging and return transfer are live. Runtime arenas, O(1) proven reclamation, relocatable typed images, crash-safe journals, and `persist = memcpy` are not yet shipping facts. |
| Representation and declarations | **PARSER LAG / TARGET** | Representation inference and parameterized effect use have live floors, but authored `repr` and parameterized effect declarations are canonical syntax the parser does not yet accept. Native, SIMD, and GPU handlers remain on the production road. |

The compiler's own diagnostic census remains nonzero while it still emits a working compiler. That debt is not hidden: its ratchet is the monotone correctness spine toward universal refusal. [`PLAN.md` §7](PLAN.md) owns the current count, audit, and landing ledger; [`boot/PROVENANCE.md`](boot/PROVENANCE.md) identifies the pinned compiler; `bash tools/state.sh` re-derives the whole board.

The final instrument above intentionally names several library and handler surfaces that are not complete today. That is the point of a product contract: every import, projection, proof, and installed answer is a concrete acceptance target. “Make the README true” means close those named paths without changing their semantics or inventing a second surface.

---

## The law and the road

[`docs/SYNTAX.md`](docs/SYNTAX.md) is the surface law this book teaches: every accepted form, with the reasoning that forced it. [`PLAN.md`](PLAN.md) carries the resolved design, current state, and production road. [`CLAUDE.md`](CLAUDE.md) carries the eight-interrogation working discipline. Read all three before changing the language or compiler; then run `bash tools/state.sh` before believing any prose, including this README.

The compiler lives in [`src/`](src/), written in Mentl. The runtime, standard vocabulary, DSP, and ML arms live in [`lib/`](lib/). The school has source counterparts under [`lib/tutorial/`](lib/tutorial/), but they are curriculum under repair, not the current proof surface. Direct gates live under [`tests/`](tests/). `boot/mentl.wasm` is the pinned self-hosting compiler; the disposable seed is gone.

Use `bash tools/verify.sh` for the compiler micro battery and census ratchet. Use `bash tools/state.sh` for the whole board: git state, verify, fixed point, frontier, proof exactness, crown, effect identity, phantom comments, and the red-instrument control.

Dual-licensed under MIT or Apache 2.0. See `LICENSE-MIT` and `LICENSE-APACHE`.
