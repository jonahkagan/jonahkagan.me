title: Computer science isn't a science and it isn't about computers
date: 2012-8-9
template: essay.jade

As a computer scientist, there's nothing that annoys me more than when
my friends ask me for help setting up their wireless internet, or when
my mom calls and asks why her laptop keeps freezing. I try to tell
them that I'm not studying computer repairs or computer usage, I'm
studying computer *science*.

But that doesn't help, because nobody seems to know exactly what the
term "computer science" means. When I urge my friends to take a
computer science course, they shrug me off with comments like "I'm no
good with computers" or "I don't do science." Assuming my friends
aren't just unadventurous, there must be some big misconceptions
outside of the computer science community about what computer science
is all about.

Computer scientists are concerned with questions like: How do you find
the shortest route between two points on a map? How do you translate
Spanish into English without a dictionary? How do you identify the
genes that make up the human genome using fragments of a DNA sequence?

There's a difference between the question, "How do you identify the
genes that make up the human genome?" and the question, "What are the
genes that make up the human genome?" The latter, a question posed by
biologists, asks for a specific fact, while the former asks for a
*procedure* which can produce that fact.

Consider any science: chemistry, biology, physics, or even one of the
"soft" sciences like psychology. All are concerned with answering
factual questions about the world around us. In computer science, the
goal is not to figure out the answers to factual questions, but rather
to figure out how to get answers. The procedure *is* the solution.
While scientists want to figure out *what is*, computer scientists
want to know *how to*.

This is not to say that scientists don't ever need to know how to
figure out the answers to their questions. The key distinction is that
computer scientists care *only* about how to figure out the answer,
and not what the answer is. Scientists, in some sense, either rely on
computer science to help with their process (for instance, if they
make use of data-analysis software) or are in part computer scientists
themselves.

The distinction between questions of fact and questions of procedure
leads naturally to a difference in methodology between scientists and
computer scientists. When scientists come up with a possible answer to
a question–––a hypothesis---they try to prove or disprove it using
experiments. Experiments are in essence tests to see whether a
hypothesis matches the behavior of the natural world. If a hypothesis
accounts for how the world behaves (or at least the behavior that the
scientists can see), then it's a useful theory.

We're all familiar with this process from elementary school. It's
called the scientific method: you observe some occurence, come up with
a hypothesis about it, test your hypothesis with experiments, and then
analyze the results. This is how scientists justify the answers to
their factual questions, and it's how our society generates
knowledge.[^2] 

[^2]: Of course, this sort of justification relies on the assumption
that the natural world will continue to behave the same way as it has
before, but that is a topic for another essay.

Knowledge in computer science, however, doesn't work the same way.
Procedures don't exist in the natural world---they're devised by
humans. When we come up with a procedure, we can't just run
experiments to see if it works. Although the procedure might be
applied to data gathered from the real world, the procedure itself is
not a part of nature. Think back to all the sciences I mentioned
before. All of them seek knowledge about that which already exists.
Procedures, however, are completely constructed---they only exist in
the abstract.

For instance, consider the procedure used in a spell checker that
recommends possible correct spellings when you make a typo. This
procedure takes a sequence of letters and tries to find the closest
match in a giant list of valid sequences, or as we normally call them,
words. What separates this procedure from the real world problem of
correcting spelling is that the sequences don't *have* to represent
words---that's just one possible application for the procedure. The
procedure itself can be reused with other kinds of sequences. In fact,
this very same procedure is used for the DNA sequencing problem I
mentioned before.[^3]

[^3]: It's called the Damerau-Levenshtein distance algorithm.

Since the problems solved by computer scientists are defined separate
from the real world, we can't use the scientific method to analyze
their validity. We can only analyze procedures within the realm of
abstraction in which we have created them. Luckily, this type of
reasoning is exactly why we have mathematical logic. Mathematicians,
too, are concerned with the idea of truth in the abstract. Instead of
running experiments, computer scientists define problems and
procedures mathematically, and then analyze them using logic. This is
the fundamental reason why computer science is not a science.

Given that the correctness of procedures is proved using mathematical
logic, it might seem like computer science is really just a branch of
mathematics, which it is, in some sense. In fact, much of the "math"
we learn in school is actually computation.

Consider, for example, the problem of dividing two numbers.  When
presented with this problem, a mathematician might derive the
properties of division, such as when there will be a remainder. A
computer scientist, in contrast, would focus on figuring out how to
perform the division.[^4]

[^4]: Schools, for some reason, don't seem to care about deriving
properties *or* developing procedures, but rather teaching students
how to memorize and execute procedures (something computers happen to
do quite well).

The computer scientist might eventually come up with the long division
algorithm. Just like any 4th grader, however, he wouldn't want to
perform the division by hand. Instead, he would write a series of
instructions, or program, describing how to perform the calculation,
and tell a computer to execute it.

Notice that this is the first time I've mentioned computers at all.
That's because there's nothing fundamental about procedures that
requires the use of computers. Computers aren't the only tools that
can be used to execute programs. For instance, elementary school
students are perfectly capable of executing the long division
algorithm. We use computers instead of small children because
computers are fast and reliable (after all, that's why we built them),
while small children are adorably uncoordinated and prone to
unexpected naps.

The great computer scientist Edsger Dijkstra summed it up best:
"Computer science is no more about computers than astronomy is about
telescopes." Even though a complex ecosystem of programs has
developed, allowing computers to serve a variety of purposes,
computers are still nothing more than a tool for executing procedures.
Computer science is about the procedures themselves, not so much the
tools used to execute them.

At this point, though, I should say that I haven't painted an entirely
accurate picture of the field---or rather, I left out some parts.
There are probably some computer scientists reading this who are
thinking, "This doesn't describe my work at all."

While at its core, computer science really is the pure study of
procedures in the abstract as I described, in reality, the field has
grown to encompass a wide variety of pursuits. Some computer
scientists are concerned mostly with designing intricate systems that
rely heavily on the specifics of computer architecture. Others study
human-computer interaction, which actually does use the scientific
method to determine what types of interfaces work the best for
computer users.

It would be easy to dismiss the outliers and say they are not true
computer scientists, that their work falls under the umbrella of some
related but fundamentally different field. But I think the breadth of
study within computer science is not necessarily a bad thing. It
doesn't need to be strictly defined.

Within the computer science department at my university, there's a
huge variety of interests among the students and professors. The
multitude of perspectives complement each other, and help the field
grow.

In the end, its the rate of growth of the field that makes all this
definition business so tricky. Computer science is still young, and
always undergoing new growth spurts. It's that awkward teenage boy at
the school dance whose limbs are growing so fast that he can't make
them all move together harmoniously just yet.

For now, I'm content to just think back to when I was an awkward
teenager trying to figure out exactly who I was and how to express
that identity to the rest of the world. I grew up and figured it out,
and we computer scientists will eventually figure out our communal
identity too.
