% -*- mode: LaTeX; compile-command: "./build.sh" -*-

%% For double-blind review submission, w/o CCS and ACM Reference (max submission space)
\documentclass[sigplan,10pt,review,anonymous]{acmart}\settopmatter{printfolios=true,printccs=false,printacmref=false}
%% For double-blind review submission, w/ CCS and ACM Reference
%\documentclass[sigplan,10pt,review,anonymous]{acmart}\settopmatter{printfolios=true}
%% For single-blind review submission, w/o CCS and ACM Reference (max submission space)
%\documentclass[sigplan,10pt,review]{acmart}\settopmatter{printfolios=true,printccs=false,printacmref=false}
%% For single-blind review submission, w/ CCS and ACM Reference
%\documentclass[sigplan,10pt,review]{acmart}\settopmatter{printfolios=true}
%% For final camera-ready submission, w/ required CCS and ACM Reference
%\documentclass[sigplan,10pt]{acmart}\settopmatter{}


%% Conference information
%% Supplied to authors by publisher for camera-ready submission;
%% use defaults for review submission.
\acmConference[FARM'18]{ACM SIGPLAN Workshop on Functional Art, Music,
Modelling, and Design}{September 29, 2018}{St.\ Louis, MO, USA}
\acmYear{2018}
\acmISBN{} % \acmISBN{978-x-xxxx-xxxx-x/YY/MM}
\acmDOI{} % \acmDOI{10.1145/nnnnnnn.nnnnnnn}
\startPage{1}

%% Copyright information
%% Supplied to authors (based on authors' rights management selection;
%% see authors.acm.org) by publisher for camera-ready submission;
%% use 'none' for review submission.
\setcopyright{none}
%\setcopyright{acmcopyright}
%\setcopyright{acmlicensed}
%\setcopyright{rightsretained}
%\copyrightyear{2017}           %% If different from \acmYear

%% Bibliography style
\bibliographystyle{ACM-Reference-Format}
%% Citation style
\citestyle{acmauthoryear}  %% For author/year citations

%% Some recommended packages.
\usepackage{booktabs}   %% For formal tables:
                        %% http://ctan.org/pkg/booktabs
\usepackage{subcaption} %% For complex figures with subfigures/subcaptions
                        %% http://ctan.org/pkg/subcaption

\usepackage{xspace}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% lhs2TeX formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%include polycode.fmt

%format <$> = "\langle \$ \rangle"
%format <#> = "\langle \# \rangle"
%format Rational = "\mathbb{Q}"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LaTeX formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Package imports

\usepackage{amsthm}
\usepackage{amsmath}
\usepackage{mathtools}
\usepackage{latexsym}
\usepackage{amssymb}
\usepackage{stmaryrd}
\usepackage{url}
\usepackage{xspace}
\usepackage{xcolor}
\usepackage[all]{xy}
\usepackage{breakurl}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Diagrams

\usepackage{pgf}
\usepackage{graphicx}
\usepackage[outputdir=diagrams,backend=pgf,extension=pgf,input]{diagrams-latex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prettyref

\usepackage{prettyref}

\newrefformat{fig}{Figure~\ref{#1}}
\newrefformat{sec}{\Sect\ref{#1}}
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
%% Comments

\newif\ifcomments\commentstrue
%\newif\ifcomments\commentsfalse

\ifcomments
\newcommand{\personalnote}[3]{\textcolor{#1}{[#3 ---#2]}}
\newcommand{\todo}[1]{\textcolor{red}{[TODO: #1]}}
\newcommand{\tocite}{\todo{add citation}}
\newcommand{\needsdia}{\todo{add illustration}}
\else
\newcommand{\personalnote}[3]{}
\newcommand{\todo}[1]{}
\fi

\newcommand{\bay}[1]{\personalnote{blue}{BAY}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Semantic markup

\newcommand{\eg}{\latin{e.g.}\xspace}
\newcommand{\ie}{\latin{i.e.}\xspace}
\newcommand{\etal}{\latin{et al.}\xspace}
\newcommand{\etc}{\latin{etc.}\xspace}

\newcommand{\term}[1]{\emph{#1}}
\newcommand{\latin}[1]{\textit{#1}}
\newcommand{\foreign}[1]{\emph{#1}}

\newcommand{\hackage}[1]{\textsf{#1}\xspace}

\newcommand{\activelib}{\hackage{active}}
\newcommand{\diagrams}{\hackage{diagrams}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{document}

%% Title information
\title{Active}                          %% [Short Title] is optional;
                                        %% when present, will be used in
                                        %% header instead of Full Title.
% \subtitle{Subtitle}                     %% \subtitle is optional
% \subtitlenote{with subtitle note}       %% \subtitlenote is optional;
%                                         %% can be repeated if necessary;
%                                         %% contents suppressed with 'anonymous'


%% Author information
%% Contents and number of authors suppressed with 'anonymous'.
%% Each author should be introduced by \author, followed by
%% \authornote (optional), \orcid (optional), \affiliation, and
%% \email.
%% An author may have multiple affiliations and/or emails; repeat the
%% appropriate command.
%% Many elements are not rendered, but should be provided for metadata
%% extraction tools.

%% Author with single affiliation.
\author{Brent A. Yorgey}
\affiliation{
  % \position{Position1}
  \department{Dept.\ of Mathematics and Computer Science} %% \department is recommended
  \institution{Hendrix College}            %% \institution is required
%  \streetaddress{Street1 Address1}
  \city{Conway}
  \state{AR}
  \country{USA}                    %% \country is recommended
}
\email{yorgey@@hendrix.edu}          %% \email is recommended

% %% Author with two affiliations and emails.
% \author{First2 Last2}
% \authornote{with author2 note}          %% \authornote is optional;
%                                         %% can be repeated if necessary
% \orcid{nnnn-nnnn-nnnn-nnnn}             %% \orcid is optional
% \affiliation{
%   \position{Position2a}
%   \department{Department2a}             %% \department is recommended
%   \institution{Institution2a}           %% \institution is required
%   \streetaddress{Street2a Address2a}
%   \city{City2a}
%   \state{State2a}
%   \postcode{Post-Code2a}
%   \country{Country2a}                   %% \country is recommended
% }
% \email{first2.last2@inst2a.com}         %% \email is recommended
% \affiliation{
%   \position{Position2b}
%   \department{Department2b}             %% \department is recommended
%   \institution{Institution2b}           %% \institution is required
%   \streetaddress{Street3b Address2b}
%   \city{City2b}
%   \state{State2b}
%   \postcode{Post-Code2b}
%   \country{Country2b}                   %% \country is recommended
% }
% \email{first2.last2@inst2b.org}         %% \email is recommended


%% Abstract
%% Note: \begin{abstract}...\end{abstract} environment must come
%% before \maketitle command
\begin{abstract}
  We describe \activelib, a new Haskell library and domain-specific
  language for describing \emph{time-varying values}.  Although it was
  originally designed with the goal of making animations with the
  \diagrams vector graphics framework \tocite, we intend for it to
  be more broadly applicable to any sort of \todo{what? ``temporal
    media''? time-varying domain?}, such as music or
  sound generation, \todo{other examples}

  We describe the library, give examples of its use, and explain and
  justify the design decisions that went into its development.
\end{abstract}


%% 2012 ACM Computing Classification System (CSS) concepts
%% Generate at 'http://dl.acm.org/ccs/ccs.cfm'.
\begin{CCSXML}
<ccs2012>
<concept>
<concept_id>10011007.10011006.10011008</concept_id>
<concept_desc>Software and its engineering~General programming languages</concept_desc>
<concept_significance>500</concept_significance>
</concept>
<concept>
<concept_id>10003456.10003457.10003521.10003525</concept_id>
<concept_desc>Social and professional topics~History of programming languages</concept_desc>
<concept_significance>300</concept_significance>
</concept>
</ccs2012>
\end{CCSXML}

\ccsdesc[500]{Software and its engineering~General programming languages}
\ccsdesc[300]{Social and professional topics~History of programming languages}
%% End of generated code


%% Keywords
%% comma separated list
\keywords{keyword1, keyword2, keyword3}  %% \keywords are mandatory in final camera-ready submission


%% \maketitle
%% Note: \maketitle command must come after title commands, author
%% commands, abstract environment, Computing Classification System
%% environment and commands, and keywords command.

\maketitle

\section{Introduction}

Introduce with some examples\dots

\todo{List contributions, with forward references to the rest of the
  paper.}

\todo{Upload new version of \activelib to Hackage.}
\todo{Mention \activelib is on Hackage, with link.}

\section{The |Active| type}

The core of the library is the |Active| type.  A value of type |Active
a| represents a \emph{time-varying value} of type |a|, with a given
\term{duration}.  Specifically, we can think of each |Active a| value
as having a nonnegative rational duration $d$, and a total function
$f : [0,d] \to a$ which assigns a value of type |a| to every duration
from $0$ to $d$, inclusive.  The duration can also be infinite, in
which case $f$ assigs a value to every $d \geq 0$.

\needsdia

This definition may seem simple, but there are nonobvious design
decisions lurking behind it which are worth pointing out. We believe
these are the choices which result in the most elegant, usable
library, but we certainly don't expect you to believe it at this
point!  We will justify each of these design decisions in more depth
throughout the paper. \todo{Include forward references to where each of
these design decisions is explained/justified.}

\begin{itemize}
\item Since the domain of $f$ is the \emph{closed} interval $[0,d]$,
  it is not possible to have an ``empty'' or ``everywhere undefined''
  |Active| value.  However, when $d = 0$ it is possible to have an
  ``instantaneous'' |Active| value defined only at a single point.
\item The domain of every |Active| value always starts at $0$. For
  example, it is not possible to make an |Active| with a domain of
  $[3,5]$.
\item Since the semantics of |Active| is a \emph{function}, an
  |Active| value is inherently continuous.  For example, we don't lose
  any ``resolution'' by zooming in.
\item The duration of an |Active| value is a \emph{rational} number.
  It is not possible to have an irrational duration or to use any type
  other than Haskell's standard |Rational| type.
\item \todo{Talk about choice to include infinity.}
\item It is not possible to tell whether an |Active| value is finite
  or infinite by looking at its type.  This means there are some
  combinators (such as |backwards|) which are necessarily partial,
  because they only make sense when applied to finite values.
\end{itemize}

What can we do with the bare |Active| type?  First, |Active| is a
|Functor|, which means we can use
\begin{spec}
fmap :: (a -> b) -> Active a -> Active b
\end{spec}
(also known as |<$>|) % $
%
to apply a function to an |Active| value at every point in time.  The
\activelib library also defines
\begin{spec}
(<#>) :: Active a -> (a -> b) -> Active b
\end{spec}
as a flipped variant of |<$>| % $
%
for convenience (we will see examples of its use later).  There is
also a collection of methods for manipulating the duration, shown in
\pref{fig:duration-functions}.

\begin{figure}
  \centering
  \begin{spec}
cut            :: Rational              ->  Active a -> Active a
cutTo          :: Active a              ->  Active a -> Active a

omit           :: Rational              ->  Active a -> Active a
slice          :: Rational -> Rational  ->  Active a -> Active a

stretch        :: Rational              ->  Active a -> Active a
stretchTo      :: Rational              ->  Active a -> Active a
matchDuration  :: Active b              ->  Active a -> Active a

backwards      ::                           Active a -> Active a
  \end{spec}
  \caption{Functions for manipulating duration}
  \label{fig:duration-functions}
\end{figure}

\todo{Talk about these functions.  Discuss possibility of
  |mapDuration| function (contravariant functor in duration).  Allows
  doing some cool stuff---note we don't have to worry about causality
  since this isn't necessarily intended for real-time synthesis---but
  it does make efficient implementation more difficult.}


%% Acknowledgments
\begin{acks}                            %% acks environment is optional
                                        %% contents suppressed with 'anonymous'
  %% Commands \grantsponsor{<sponsorID>}{<name>}{<url>} and
  %% \grantnum[<url>]{<sponsorID>}{<number>} should be used to
  %% acknowledge financial support and will be used by metadata
  %% extraction tools.
  This material is based upon work supported by the
  \grantsponsor{GS100000001}{National Science
    Foundation}{http://dx.doi.org/10.13039/100000001} under Grant
  No.~\grantnum{GS100000001}{nnnnnnn} and Grant
  No.~\grantnum{GS100000001}{mmmmmmm}.  Any opinions, findings, and
  conclusions or recommendations expressed in this material are those
  of the author and do not necessarily reflect the views of the
  National Science Foundation.
\end{acks}


%% Bibliography
%\bibliography{bibfile}


% %% Appendix
% \appendix
% \section{Appendix}

% Text of appendix \ldots

\end{document}