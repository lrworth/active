\documentclass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% lhs2TeX

%include polycode.fmt

% Use 'arrayhs' mode, so code blocks will not be split across page breaks.
\arrayhs

\renewcommand{\Conid}[1]{\mathsf{#1}}

\newcommand{\cons}[1]{\mathsf{#1}}

%format const = "\cons{const}"
%format inf   = "\infty"
%format max   = "\cons{max}"
%format min   = "\cons{min}"

%format ===    = "\equiv"
%format <>     = "\diamond"
%format mempty = "\varepsilon"

%format a1
%format a2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Package imports

\usepackage{amsthm}
\usepackage{amsmath}
\usepackage{mathtools}
\usepackage{latexsym}
\usepackage{amssymb}
\usepackage{stmaryrd}
\usepackage{proof}
\usepackage{url}
\usepackage{xspace}
\usepackage{xcolor}
\usepackage[all]{xy}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Diagrams

\usepackage{graphicx}
\usepackage[outputdir=diagrams/]{diagrams-latex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Math typesetting

% Use sans-serif for math operators
\DeclareSymbolFont{sfoperators}{OT1}{cmss}{m}{n}
\DeclareSymbolFontAlphabet{\mathsf}{sfoperators}

\makeatletter
\def\operator@@font{\mathgroup\symsfoperators}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prettyref

\usepackage{prettyref}

\newrefformat{fig}{Figure~\ref{#1}}
\newrefformat{sec}{\sect\ref{#1}}
\newrefformat{eq}{equation~\eqref{#1}}
\newrefformat{prob}{Problem~\ref{#1}}
\newrefformat{tab}{Table~\ref{#1}}
\newrefformat{thm}{Theorem~\ref{#1}}
\newrefformat{lem}{Lemma~\ref{#1}}
\newrefformat{prop}{Proposition~\ref{#1}}
\newrefformat{defn}{Definition~\ref{#1}}
\newrefformat{cor}{Corollary~\ref{#1}}
\newcommand{\pref}[1]{\prettyref{#1}}

% \Pref is just like \pref but it uppercases the first letter; for use
% at the beginning of a sentence.
\newcommand{\Pref}[1]{%
  \expandafter\ifx\csname r@@#1\endcsname\relax {\scriptsize[ref]}
    \else
    \edef\reftext{\prettyref{#1}}\expandafter\MakeUppercase\reftext
    \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Semantic markup

\newcommand{\eg}{\emph{e.g.}\xspace}
\newcommand{\ie}{\emph{i.e.}\xspace}

\newcommand{\term}[1]{\emph{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{document}

\section{Parallel composition and |XActive|}
\label{sec:par-comp}

As a starting point\footnote{a refined version is presented in section
  ???}, we define the semantics of |XActive| as follows:

\begin{spec}
XActive t a === (-inf + t, t -> a, t + inf)
\end{spec}

\begin{center}
\begin{diagram}[width=200]
import ActiveDiagrams
dia = a1 <> tl
\end{diagram}
\end{center}

The semantics of |XActive| is a triple of values $(t_s, f, t_e)$,
consisting of
\begin{itemize}
\item an absolute start time $t_s$ (possibly |-inf|),
\item a function $f$ from time to values, and
\item an absolute end time $t_e$ (possibly |+inf|).
\end{itemize}
The function $f$ is total on the interval $[t_s, t_e]$ but is
undefined outside it.  (Note that we take $[t_s, t_e]$ to denote the
empty interval when $t_s > t_e$.)

If |a| is an instance of |Monoid|, then |XActive| also has a |Monoid|
instance for \emph{parallel composition}: |(a1 <> a2)| is defined on
the \emph{intersection} of the intervals of |a1| and |a2|, with values
generated by combining the values of |a1| and |a2| pointwise (which is
well-defined since, by definition, both |a1| and |a2| are defined
everywhere on the intersection of their intervals).
\begin{center}
\begin{diagram}[width=200]
import ActiveDiagrams
as :: Diagram Cairo R2
as = cat' unitY with {sep = 0.5} [a12, a2, a1]
dia = (   vrule (height as) # translateX (-1)
       <> vrule (height as) # translateX 3
      )
      # alignB # translateY (-1.5)
      # lw 0.1 # dashing [0.3,0.2] 0
   <> as
   <> tl
\end{diagram}
\end{center}
Abstractly, we can construct this monoid as the product of monoid
structures on the three components of |XActive|: namely, the |(max, -inf)|
monoid for start times, the usual lifted monoid for functions, and the
|(min, +inf)| monoid for end times.  The identity element is thus given
by |(-inf, const mempty, inf)|, that is, the |XActive| which is
constantly the identity value at all times.

\section{Why not union?}
\label{sec:why-not-union}

One could also imagine taking the union of intervals instead of the
intersection.  In fact, this was our first intuition as well.  But we
have come to the conclusion that intersecting intervals gives a much
cleaner and more natural semantics.  Here are several reasons in justification
\begin{itemize}
\item When intervals overlap this is not too big of a problem.  But
  if intervals do not overlap we have a problem.  Either need more
  complex notion of interval (i.e. arbitrary set of intervals), or
  take smallest interval containing both, but then we need to be able
  to make up default value for a.
\item Can be derived from |Applicative|.  For |Applicative| we really
  need intersection not union, because of definedness.
\end{itemize}

\section{Sequential composition and |FActive|}
\label{sec:seq-comp}

It's instructive to begin by trying to work out a semantics for
sequential composition of |XActive|.  Of course it's clear enough that
the end time of the first |XActive| should be matched up with the
start time of the second.  But where should the resulting composite
|XActive| be placed in time?  The main concern is that we want
sequential composition to be associative.  One sensible choice is to
leave the first |XActive| where it is, and translate the second so
its start time coincides with the end time of the first:
\begin{center}
\begin{diagram}[width=200]
import ActiveDiagrams

dia = vcat' with {sep = 1}
      [ xactiveD (-3) 1 red  <> tl
      , text' "+" -- TODO pick better symbol for operator
      , xactiveD (-4) 3 blue <> tl
      , text' "="
      , result
      ]

result = (draw $ xactive' (-3) 8 (xactiveRect (-3) 1 red |||||| xactiveRect 1 8 blue))
   <> tl
   -- TODO draw a blue arrow showing the translation of the second value
\end{diagram}
\end{center}
%$
It is easy to verify that this operation is associative.  However, the
asymmetry is already a bit unsettling: another valid choice would be
to translate the first value and leave the second unchanged.  Or we
could always center the resulting |XActive| with respect to time $0$,
or place its start time at time $0$, or\dots

In and of itself this plethora of choice is not necessarily a problem;
we could just pick the most sensible-seeming option and leave it at
that.  However, it points at a deeper problem, which comes into
sharper focus when we consider what the identity element for
sequential composition might be.

% type FixedActive t a = (-inf + t, t -> a, t + inf)
%   -- closed, i.e. defined on x <= t <= y.
%   -- undefined outside the interval.

%   -- Semigroup and Monoid for this reqiure Semigroup and Monoid for a.

%   -- Have Applicative for this.

% type FreeActive t a = (d, t -> a)
%   -- d \in [0 .. inf)   t in [0, d)

%   -- Semigroup and Monoid for this do NOT require Semigroup and Monoid
%   -- for a.

%   -- No Applicative.


% data Bound1 = Inf | Closed

% type XActive (l :: Bound1) (r :: Bound1) t a = ...
% -- combination take minimum (stacking)
% (<>) :: XActive l1 r1 t a ->  XActive l2 r2 t a ->  XActive (MIN l1 l2) (MAX r1
% +r2) t a

% ((Additional: perhaps we just have two types here
%    XInfActive   -- Which *is* a Behavior
%    XActive --

% This would simply things
%   * less phantoms floating around.
%   * Only XActive would map to FActive.
% ))

% data Bound2 = Inf | Closed | Open       -- Bound is a kind

% -- type d = Diff t in this type
% type FActive (l :: Bound2) (r :: Bound2) d a =
% -- combination sequences them (beside)
% (<>) :: (Join r1 r2) => XActive l1 r1 t a ->  XActive l2 r2 t a ->  XActive l1
% +r2 t a

% I like the phantoms here.

% ((Additional:: perhaps FActive should only be finite???))



\end{document}
