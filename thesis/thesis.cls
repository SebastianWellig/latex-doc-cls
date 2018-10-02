% class definition
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2018/08/21 Thesis]
	% option declaration
	\DeclareOption{10pt}
	{
		\PassOptionsToClass{\CurrentOption}{report}
	}
	\DeclareOption{11pt}
	{
		\PassOptionsToClass{\CurrentOption}{report}
	}
	\DeclareOption{12pt}
	{
		\PassOptionsToClass{\CurrentOption}{report}
	}
	\ExecuteOptions{11pt} % default options
	\ProcessOptions\relax % process options

% parent class
\LoadClass[a4paper]{report}

% external packages
\RequirePackage[english]{babel}
\RequirePackage[utf8]{inputenc} % input encoding
\RequirePackage{graphicx} % for importing figures
\RequirePackage{ifthen}

% hyperrefs
\RequirePackage[hidelinks,colorlinks=false]{hyperref}
\RequirePackage[all]{hypcap} % improves jump position for hyperref


% page formatting
\RequirePackage[width=150mm,top=25mm,bottom=25mm]{geometry} % set page margins
\RequirePackage{fancyhdr}
	\fancypagestyle{plain} % page style for a new chapter (used internally by report.cls)
	{
		\fancyhf{}
		\fancyfoot[CO]{\thepage}
	}
	\fancypagestyle{default} % page style for other pages
	{
		\fancyhf{}
		\renewcommand{\headrulewidth}{0pt} % remove the header line
		\fancyhead[LO]{\leftmark}
		\fancyhead[RO]{\rightmark}
		\fancyfoot[CO]{\thepage}
	}
	\pagestyle{default} % use the default page style

% title page
\def\setthesistype#1{\gdef\thesistype{#1}} % type of the thesis
	% e.g. \thesistype{Master's Thesis}
	\def\thesistype{\ClassError{thesis}{No \noexpand\thesistype was given}{}}
\def\settitle#1{\gdef\title{#1}} % title of the thesis
	% e.g. \title{The Title of an Awesome Thesis}
	\def\title{\ClassError{thesis}{No \noexpand\title was given}{}}
\def\setauthor#1{\gdef\author{#1}} % name of the authors
	% e.g. \author{John Doe} or \author{Jon Doe Jr. \\ John Doe Sr.}
	\def\author{\ClassError{thesis}{No \noexpand\author was given}{}}
\def\setsupervisor#1{\gdef\supervisor{#1}} % name of the supervisors
	% e.g. \supervisor{John Doe} or \supervisor{Jon Doe Jr. \\ John Doe Sr.}
	\def\supervisor{\ClassError{thesis}{No \noexpand\supervisor was given}{}}
\def\setinstitutionlogo#1{\gdef\institutionlogo{#1}} % logo of the institution
	% e.g. \institutionlogo{logo.pdf}
	\def\institutionlogo{\ClassError{thesis}{No \noexpand\institutionlogo was given}{}}
\def\setinstitution#1{\gdef\institution{#1}} % name of the institution
	% e.g. \institution{University of Zurich \\ Faculty of Science \\ Department of Chemistry}
	\def\institution{\ClassError{thesis}{No \noexpand\institution was given}{}}
\usepackage[en-US]{datetime2} % modifying \today
	\DTMlangsetup{showdayofmonth=false}

\renewcommand{\maketitle}
{
	\begin{titlepage}
		\centering
		\includegraphics{\institutionlogo}
		\vfill
		{\sf\Huge \thesistype \par}
		\vfill
		{\bf\LARGE \title \par}
		\vfill
		{\sf\Large \author \\ \today \par}
		\vfill
		{\sf\Large Supervised by \\ \supervisor \par}
		\vfill
		{\sf\Large \institution \par}
		\vfill
	\end{titlepage}
}
\newcommand{\makepdfmetadata}
{
	\hypersetup
	{
		pdftitle={\thesistype},
		pdfsubject={\title},
		pdfauthor={\author}
	}
}

% fromat levels for the default style
% modified \chapter and \section: adds optional argument for specifying a short name that is used in the header instead
% modified \paragraph: adds optional argument for specifying a delimiter (. by default)
\let\reportchapter\chapter
\renewcommand{\chapter}[2][]{ % optional short name for the fancy header 
	\@ifstar{\reportchapter*[#2]{#2 \chaptermark{#1}}}{\reportchapter[#2]{#2}}
	\ifthenelse{\NOT\equal{#1}{}}{\chaptermark{#1}}{}
}
\let\reportsection\section
\renewcommand{\section}[2][]{ % optional short name for the fancy header 
	\@ifstar{\reportsection*[#2]{#2}}{\reportsection[#2]{#2}}
	\ifthenelse{\NOT\equal{#1}{}}{\sectionmark{#1}}{}
}

\let\reportparagraph\paragraph
\renewcommand{\paragraph}[2][.]{\reportparagraph{#2#1}} % delimiter option for paragraph title

% define environments
\newenvironment{frontmatter}
{
	% format levels for the frontmatter style
	% modified \chapter and \section: adds optional argument for specifying a short name that is used in the header instead
	% modified \chapter: removes the "chapter i" line from the chapter title
	% modified \chapter: \chapter* is included in the bookmarks, but not in the toc
	\newcounter{frontmatter.chapter.counter}
	\renewcommand{\chaptermark}[1]{\markboth{##1}{}}
	\def\chapter{
		\if@openright
			\cleardoublepage
		\else
			\clearpage
		\fi
		\thispagestyle{plain}
		\global\@topnum\z@
		\@afterindentfalse
		\@ifstar{\@dblarg{\@fschapter}}{\@dblarg{\@fchapter}}
	}
	\def\@fchapter[##1]##2{
		\refstepcounter{frontmatter.chapter.counter}
		\addcontentsline{toc}{chapter}{##2}
		\chaptermark{##1}
		\if@twocolumn
			\@topnewpage[\@makeschapterhead{##2}]%
		\else
			\@makeschapterhead{##2}%
			\@afterheading
		\fi
	}
	\def\@fschapter[##1]##2{
		\stepcounter{frontmatter.chapter.counter}
		\pdfbookmark[0]{##2}{frontmatter.chapter.\arabic{frontmatter.chapter.counter}}
		\chaptermark{##1}
		\if@twocolumn
			\@topnewpage[\@makeschapterhead{##2}]%
		\else
			\@makeschapterhead{##2}%
			\@afterheading
		\fi
	}

	\setcounter{page}{1} % set page counter to 1
	\def\thepage{\csname @Roman\endcsname \c@page} % use roman numerals
}
{
	\clearpage
	\setcounter{page}{1}  % set page counter to 1
}
\endinput
