\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NCEPUDoctor}[University Thesis Template for Doctor Degree]

% ---- 载入Class ----- 
\LoadClass[a4paper,openany,oneside]{book} % A4大小，book布局
\RequirePackage{tabularx}
\RequirePackage{xeCJK}
\RequirePackage{ifxetex}
\RequireXeTeX
\RequirePackage[zihao=-4, UTF8, heading=true]{ctex}[2016/12/27]
\ziju{0.07}
\RequirePackage{xeCJKfntef}
\RequirePackage{amssymb}
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}
\RequirePackage{amsmath, amssymb}
\RequirePackage[amsmath,thmmarks]{ntheorem}  % 定理
\RequirePackage{graphicx, subcaption}
\RequirePackage{listings}                    % 代码段
\RequirePackage{algorithm, algorithmic}    % 算法代码
\RequirePackage{tikz, pgfplots}              % 绘图

\RequirePackage{fontspec, color, url, array}
\setmainfont{Times New Roman}[
  Ligatures = TeX,
  BoldFont = Times New Roman Bold,
  ItalicFont = Times New Roman Italic,
  BoldItalicFont = Times New Roman Bold Italic
]

% \RequirePackage{txfonts}   
\RequirePackage{wasysym} % Times 风格（数学）字体
% ---- 定义页边距 ----- includehead=true, includefoot=true,
\RequirePackage{geometry}

\geometry{a4paper, left=3cm, right=3cm, top=3.2cm, bottom=2.75cm, xetex, headsep=12.3pt, footskip=0cm}

\setCJKmainfont[AutoFakeBold=true]{simsun.ttc}  % 主字体：宋体
\newCJKfontfamily{\Songti}{simsun.ttc}[AutoFakeBold=true] 
\newCJKfontfamily{\Heiti}{simhei.ttf}  

% 重定义目录中章节标题的显示格式为"第1章"
\makeatletter
\renewcommand{\@chapapp}{第} % 设置为"第" \bfseries
\renewcommand{\thechapter}{\arabic{chapter}} % 使用阿拉伯数字
\renewcommand*\l@chapter[2]{
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \@tempdima=1.5em
      {\Heiti 第\thechapter 章~~ #1}\nobreak\hfill \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}
  
\makeatletter
\def\@makeschapterhead#1{%
  \vspace*{-6pt} % 与带编号章节一致
  {\parindent \z@ \centering
    \normalfont\Heiti\zihao{-2} % 字体字号
    #1\par\nobreak
    \vskip 11.8pt % 标题与正文间距
  }
  \markboth{#1}{#1}% 设置页眉标记
}
\def\@makechapterhead#1{
  \vspace*{-6pt}% 页顶部到标题距离
  {\parindent \z@ \raggedright \normalfont
    \centering \zihao{-2} \Heiti 第\thechapter 章~~ #1\par\nobreak
    \vskip 11.8pt % 段后距离
  }}

% 定义新的无编号章节命令，支持目录标题
\newcommand{\chapterstar}[2][]{%
  \chapter*{#2}% 正文显示带间距的标题
  \ifx\relax#1\relax
    \addcontentsline{toc}{chapter}{#2}% 如果没有提供可选参数，使用完整标题
  \else
    \addcontentsline{toc}{chapter}{#1}% 使用提供的目录标题
  \fi
}
\makeatother

% ====== 附录功能定义 ====== %
\makeatletter
% 重新定义 \appendix 命令以支持中文附录格式
\renewcommand\appendix{
  % 切换计数器为字母编号
  \setcounter{chapter}{0}
  \setcounter{section}{0}
  \gdef\@chapapp{\appendixname}
  \gdef\thechapter{\@Alph\c@chapter}
  
  % 修改ctex的章节设置
  \ctexset{
    chapter = {
      name = {附录},
      number = \Alph{chapter},
      format = {\centering\Heiti\zihao{-2}},
      beforeskip = 1\baselineskip,
      afterskip = 0.5\baselineskip,
      aftername = {\hspace{0.5\ccwd}}
    }
  }
  
  % 重定义章节标题生成命令
  \def\@makechapterhead##1{
    \vspace*{-6pt}
    {\parindent \z@ \raggedright \normalfont
      \centering \zihao{-2} \Heiti 附录\thechapter~~##1\par\nobreak
      \vskip 11.8pt
    }}
  
  % 修改目录中的章节显示
  \renewcommand*\l@chapter[2]{
    \ifnum \c@tocdepth >\m@ne
      \addpenalty{-\@highpenalty}
      \vskip 1.0em \@plus\p@
      \setlength\@tempdima{1.5em}
      \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \leavevmode
        \advance\leftskip\@tempdima
        \hskip -\leftskip
        \@tempdima=1.5em
        {\Heiti 附录\thechapter~~####1}\nobreak\hfill \nobreak\hb@xt@\@pnumwidth{\hss ####2}\par
      \endgroup
    \fi}
  
  % 重新定义英文目录命令，显示"Appendix"而不是"Chapter"
  \renewcommand\echapter[1]{\addcontentsline{eoc}{chapter} {\protect\numberline{\bfseries Appendix ~\thechapter} \bfseries##1}}
}

% 定义一个便捷命令 \startappendix（与 \appendix 等效）
\newcommand{\startappendix}{\appendix}

% 如果需要从附录模式恢复到正常章节模式（一般不需要），可以使用此命令
\newcommand{\stopappendix}{
  \setcounter{chapter}{0}
  \setcounter{section}{0}
  \gdef\@chapapp{第}
  \gdef\thechapter{\@arabic\c@chapter}
  
  % 恢复ctex的章节设置
  \ctexset{
    chapter = {
      name = {第,章},
      number = \arabic{chapter},
      format = {\centering\Heiti\zihao{-2}},
      beforeskip = 1\baselineskip,
      afterskip = 0.5\baselineskip,
      aftername = {\hspace{0.5\ccwd}}
    }
  }
  
  % 恢复原始章节标题生成命令
  \def\@makechapterhead##1{
    \vspace*{-6pt}
    {\parindent \z@ \raggedright \normalfont
      \centering \zihao{-2} \Heiti 第\thechapter 章~~##1\par\nobreak
      \vskip 11.8pt
    }}
  
  % 恢复原始目录显示
  \renewcommand*\l@chapter[2]{
    \ifnum \c@tocdepth >\m@ne
      \addpenalty{-\@highpenalty}
      \vskip 1.0em \@plus\p@
      \setlength\@tempdima{1.5em}
      \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \leavevmode
        \advance\leftskip\@tempdima
        \hskip -\leftskip
        \@tempdima=1.5em
        {\Heiti 第\thechapter 章~~####1}\nobreak\hfill \nobreak\hb@xt@\@pnumwidth{\hss ####2}\par
      \endgroup
    \fi}
  
  % 恢复英文目录命令的原始定义
  \renewcommand\echapter[1]{\addcontentsline{eoc}{chapter} {\protect\numberline{\bfseries Chapter ~\thechapter} \bfseries##1}}
}
\makeatother


\RequirePackage{xcolor}
% \definecolor{headercolor}{HTML}{808080} \color{headercolor} 
\usepackage{fancyhdr}
\pagestyle{fancy}  % 设置正文使用 fancy 页眉
\fancyhf{}  % 清空默认设置
\fancyhead[CO]{\zihao{-5} \leftmark}
\fancyhead[CE]{\zihao{-5}  华北电力大学博士学位论文}
\fancyfoot[C]{\zihao{-5} \thepage}
\makeatletter
  \def\doubleheadrule{  \vskip 3.6pt
  \hrule height 3.1pt \vskip 0.6pt \hrule height 0.7pt}
  \renewcommand{\headrule}{\doubleheadrule}

% 改写 plain 样式，使 \chapter 页也用 fancy 风格
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyfoot[C]{\zihao{5}\thepage}
  \fancyhead[CO]{\zihao{-5} \leftmark}
  \fancyhead[CE]{\zihao{-5} 华北电力大学博士学位论文}
  \fancyfoot[C]{\zihao{-5}  \thepage}
  % 设置双横线页眉线
  \makeatletter
  \def\doubleheadrule{  \vskip 3.6pt
  \hrule height 3.1pt \vskip 0.6pt \hrule height 0.7pt}
  \renewcommand{\headrule}{\doubleheadrule}
}

% ---- 定义标题和段落样式 ----- 
% 定义1.25倍行距
\RequirePackage{setspace}
\linespread{1.35}
% \setstretch{1.5}  
\setcounter{secnumdepth}{3} % 启用到 \subsubsection 的编号

% 设置章节标题样式
\ctexset{
  chapter = {
    name = {第,章},
    number = \arabic{chapter},
    format = {\centering\Heiti\zihao{-2}},      
    beforeskip = 1\baselineskip,                
    afterskip = 0.5\baselineskip,    
    aftername = {\hspace{0.5\ccwd}}
  },
  section = {
    format = {\raggedright\Heiti\zihao{-3}}, 
    beforeskip = 0.5\baselineskip,
    afterskip  = 0.5\baselineskip,
    aftername = {\hspace{0.5\ccwd}}
  },
  subsection = {
    format = {\raggedright\Heiti\zihao{4}},     
    beforeskip = 0.5\baselineskip,
    afterskip  = 0.5\baselineskip,
    aftername = {\hspace{0.5\ccwd}}
  },
  subsubsection = {
    format = {\raggedright\Heiti\zihao{-4}},    % 黑体 小4号
    beforeskip = 0\baselineskip,
    afterskip  = 0\baselineskip,
    aftername = {\hspace{0.5\ccwd}}
  }
}
\ctexset{
  chapter/beforeskip = {-10pt},
  chapter/afterskip = {0pt},
}

\RequirePackage{hyperref} % 引用
\hypersetup{colorlinks=true,linkcolor=black,urlcolor=black,citecolor=black} 
\newcommand{\chinesecolon}{\char"FF1A}
\newcommand{\chinesespace}{\char"3000}
\newcommand{\chineseperiod}{\char"3002}
\newcommand{\chinesequestion}{\char"FF1F}
\newcommand{\chineseexclamation}{\char"FF01}
\newcommand{\chinesecomma}{\char"FF0C}
\newcommand{\chinesesemicolon}{\char"FF1B}
\newcommand{\chineseleftparenthesis}{\char"FF08}
\newcommand{\chineserightparenthesis}{\char"FF09}

% 定义中文目录标题
\renewcommand{\contentsname}{目\quad 录}
% 定义英文目录标题
\newcommand{\encontentsname}{Contents} 

\RequirePackage{titletoc}
\titlecontents{chapter}[1pt]{\Heiti \zihao{-4}}
    {\thecontentslabel\hspace{0.5\ccwd}}{}
    {\titlerule*{.}\contentspage}
\titlecontents{section}[1\ccwd]{ \zihao{-4}}
    {\thecontentslabel\hspace{0.5\ccwd}}{}
    {\titlerule*{.}\contentspage}
\titlecontents{subsection}[2\ccwd]{ \zihao{-4}}
    {\thecontentslabel\hspace{0.5\ccwd}}{}
    {\titlerule*{.}\contentspage}
    
%% 用于英文目录, list it in eoc
\newcommand\echapter[1]{\addcontentsline{eoc}{chapter} {\protect\numberline{\bfseries Chapter ~\thechapter} \bfseries#1}}
\newcommand\esection[1]{\addcontentsline{eoc}{section}{\protect\numberline{\thesection}#1}}
\newcommand\esubsection[1]{\addcontentsline{eoc}{subsection}{\protect\numberline{\thesubsection}#1}}
\newcommand\esubsubsection[1]{\addcontentsline{eoc}{subsubsection}{\protect\numberline{\thesubsubsection}#1}}
\newcommand\echapterstar[1]{\addcontentsline{eoc}{chapter}{\bfseries#1}}

\renewcommand\tableofcontents{
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  {
  % ===== 中文目录 =====
  \vspace*{-15pt} % 页顶部到标题的距离，与章节标题保持一致
  \begin{center}
      \Heiti\zihao{-2} \contentsname % 目录标题：黑体小二号
  \end{center}
  \vskip 3pt % 标题与目录内容的间距，与章节标题保持一致
  
  % 设置当前页页眉
  \fancyhead[CO]{\zihao{-5}  \contentsname}
  \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}
  
  % 添加PDF书签
  \pdfbookmark[0]{目录}{XMUtoc}
  
  % 生成中文目录内容
  \@starttoc{toc}
  
  \newpage % 英文目录另起一页
  
  % ===== 英文目录 =====
  \vspace*{-9pt} % 页顶部到标题的距离，与章节标题保持一致
  \begin{center}
      \bfseries\zihao{-2} \encontentsname % 英文目录标题：黑体小二号
  \end{center}
  \vskip 3pt % 标题与目录内容的间距，与章节标题保持一致
  
  % 设置当前页页眉
  \fancyhead[CO]{\zihao{-5}  \encontentsname}
  \@mkboth{\MakeUppercase\encontentsname}{\MakeUppercase\encontentsname} 
  % 生成英文目录内容
  \@starttoc{eoc}
  }
  \if@restonecol\twocolumn\fi
}
\newcommand{\contents}{
  \clearpage
  \tableofcontents
  \pagestyle{plain}
  % \setcounter{page}{1} % 如需重置页码，取消注释此行
  % \pagenumbering{arabic} % 如需设置页码格式，取消注释此行
}

% ———————————————————————————————————————————
% ——————————— 中英文摘要环境 ———————————————————
% ———————————————————————————————————————————
% 中文摘要环境
\newenvironment{abstract}[1]{
  \def\@abstractkeywords{#1}% 保存关键词
    \zihao{-4}
}{
  \par\vspace{1em}
  \noindent\textbf{关键词：} \@abstractkeywords% 使用保存的关键词
  \clearpage
}
% 英文摘要环境
\newenvironment{enabstract}[1]{
  \def\@enabstractkeywords{#1}% 保存关键词
  \zihao{-4}
}{
  \par\vspace{1em}
  \noindent\textbf{Keywords:} \@enabstractkeywords% 使用保存的关键词
  \clearpage
}

% ---- 定义字体 ----- 
\renewcommand\normalsize{%
  \zihao{-4}}
\normalsize  % 立即激活

% ———————————————————————————————————————————
% ——————————— 自定义命令 ———————————————————
% ———————————————————————————————————————————
% 定义加粗段落命令（段前段后各0.5行）
\newcommand{\boldparafirst}[1]{
  \noindent \textbf{#1}
  \vspace{0.5\baselineskip}% 段后0.5行
}
\newcommand{\boldpara}[1]{ 
  \vspace{0.5\baselineskip}% 段前0.5行
  \noindent\textbf{#1}
  \vspace{0.5\baselineskip}% 段后0.5行
}

% ============================
% 博士期间成果列表（悬挂缩进）
% ============================
\newenvironment{achievementlist}{%
  \begin{list}{}{%
    % \setlength{\leftmargin}{0pt}      % 整体左边距
    \setlength{\itemindent}{0pt}      % 条目首行不缩进
    \setlength{\labelsep}{0.5em}      % 编号与正文间距
    \setlength{\labelwidth}{2em}      % [1] 的宽度
    \setlength{\listparindent}{0pt}
    \setlength{\topsep}{0pt}
    \setlength{\partopsep}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\itemsep}{0pt}
  }%
}{%
  \end{list}
}

% ---- 数学定理样式 ----- 
\theoremstyle{plain}
\theoremheaderfont{\Heiti}
\theoremindent 0em
\theorempreskip{0pt}
\theorempostskip{0pt}
\theoremnumbering{arabic}
%\theoremsymbol{} %定理结束时自动添加的标志
\newtheorem{theorem}{\hspace{2em}定理}[section]
\newtheorem{definition}{\hspace{2em}定义}[section]
\newtheorem{lemma}{\hspace{2em}引理}[section]
\newtheorem{corollary}{\hspace{2em}推论}[section]
\newtheorem{proposition}{\hspace{2em}性质}[section]
\newtheorem{example}{\hspace{2em}例}[section]
\newtheorem{remark}{\hspace{2em}注}[section]

\theoremstyle{nonumberplain}
\theoremheaderfont{\Heiti}
\theorembodyfont{\normalfont \rm  }
\theoremindent0em \theoremseparator{\hspace{1em}}
\theoremsymbol{$\square$}
\newtheorem{proof}{\hspace{2em}证明}

\usepackage{etoolbox}
\BeforeBeginEnvironment{algorithm}{\vspace{5pt}}
\makeatletter
\renewcommand{\ALG@name}{算法}
\makeatother
\newcommand{\algref}[1]{算法\ref{#1}}


% ---- 参考文献设置 ----- %
\RequirePackage[sort&compress]{natbib}
\setcitestyle{numbers,square,comma}
% 设置参考文献条目之间的间距（紧凑格式，符合1.25行距要求）
\setlength{\bibsep}{0pt plus 0.3ex}
% 重定义参考文献标题格式，减小顶部间距
\makeatletter
\renewcommand\bibsection{%
  \chapter*{\bibname}%
  \@mkboth{\bibname}{\bibname}%
  \addcontentsline{toc}{chapter}{\bibname}%
  % 调整参考文献标题后的间距
  \vspace*{-1.5\baselineskip}%  % 减小标题距离页面顶部的距离
}
\makeatother

% 设置参考文献正文字体和行距（小4号字，1.25倍行距）
\renewcommand{\bibfont}{ \zihao{-4}\linespread{1.25}\selectfont}
\makeatletter
\renewenvironment{thebibliography}[1]
     {\bibsection%
      \@mkboth{\bibname}{\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%  % 计算序号宽度（如[99]）
            \leftmargin 0pt%                          % 左边距为0
            \itemindent 1pt%                 % 首行负缩进，序号完全悬挂出去
            \advance\itemindent 0pt%           % 减去间距，确保完全悬挂
            \labelsep 6pt%                          % 序号与文字的间距
            \itemsep=0pt plus 0.3ex%                  % 条目间距
            \parsep=0pt%                              % 段落间距
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\makeatother

\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}} % 自定义新命令\upcite, 使参考文献引用以上标出现

%———————————————————————————————————————————
%——————————— 公式样式 ———————————————————————
%———————————————————————————————————————————
% ---- 公式编号样式设置（如（1-1）） 
\numberwithin{equation}{chapter} % 公式编号按章分，例如 1-1
\renewcommand{\theequation}{\thechapter-\arabic{equation}} % 设置编号格式为 1-1
\makeatletter
\def\p@equation#1{(#1)}
\makeatother
\AtBeginDocument{
  \setlength\abovedisplayskip{3pt plus 1pt}
  \setlength\belowdisplayskip{3pt plus 1pt}
  \setlength\abovedisplayshortskip{0pt plus 1pt}
  \setlength\belowdisplayshortskip{0pt plus 1pt}
  \setlength\jot{3pt}
}
\newcommand{\breakwithtilde}{\\ \hspace*{2em}~~\ }

%———————————————————————————————————————————
%——————————— 图片样式 ———————————————————————
%———————————————————————————————————————————
% 图编号格式：图 4-1
\numberwithin{figure}{chapter}
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}
% 主图标题设置：无冒号、五号字、居中
\usepackage{caption, subcaption}
\DeclareCaptionLabelFormat{nocaptioncolon}{\zihao{5}图~#2}
\captionsetup[figure]{
  labelsep=space, 
  labelformat=nocaptioncolon, 
  justification=centering,
  font={normalsize}
}
% 主图中英文标题命令
\newcommand{\figcaptioncneng}[2]{
  \caption[#1]{
    \zihao{5}#1\\
    \zihao{5}Fig.~\thefigure~#2
  }\vspace{-5pt}
}
% 子图标签格式：只有右括号
\renewcommand{\thesubfigure}{\alph{subfigure}}
% 子图标题设置：悬挂缩进格式，不显示标签（我们手动添加）
\captionsetup[subfigure]{
  labelformat=empty,         % 不显示自动标签
  format=hang,               % 悬挂格式
  justification=raggedright, % 左对齐
  singlelinecheck=false,     % 强制使用悬挂格式
  font={normalsize}
}
% 子图中英文标题命令（手动添加序号和右括号）
\newcommand{\subfigcaptioncneng}[2]{%
  \caption{%
    \zihao{5}\thesubfigure) #1\\%
    \zihao{5}\thesubfigure) #2%
  }\vspace{-6pt}
}
% 设置引用时的前缀：包含父图编号和空格
\makeatletter
\renewcommand{\p@subfigure}{\thefigure\space}
\makeatother
% 子图引用格式
\renewcommand{\subref}[1]{\ref{#1})}

% ———————————————————————————————————————————
% ——————————— 表格样式 ———————————————————————
% ———————————————————————————————————————————
\RequirePackage{longtable}
\RequirePackage{tabularx}
% \RequirePackage{xltabular} % 新增：完美结合 longtable 和 tabularx 的宏包
\RequirePackage{etoolbox} 
\RequirePackage{threeparttable}
\setlength{\textfloatsep}{6pt plus 2pt minus 2pt} 
\setlength{\intextsep}{4pt plus 1pt minus 1pt}  

\renewcommand{\thetable}{\thechapter-\arabic{table}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}m{\dimexpr #1\textwidth - 2\tabcolsep\relax}}
\AtBeginEnvironment{longtable}{\zihao{5}}
\AtBeginEnvironment{table}{\zihao{5}}
\AtBeginEnvironment{tabular}{\zihao{5}}
\AtBeginEnvironment{tabularx}{\zihao{5}}
\AfterEndEnvironment{table}{\vspace{-0.3em}} 

\newcommand{\thenexttable}{{\zihao{5} 表\thechapter-\arabic{table}（续表）}}

\newcommand{\bilingualtablecaption}[2]{
  \captionsetup{justification=centering,labelformat=empty,skip=4pt}
  \caption[#1]{{\zihao{5}
    { 表 \thetable}~#1\\
    {Table \thetable}~#2}}
}
% \newcommand{\bilingualtablecaption}[2]{%
%   \captionsetup{justification=centering,labelformat=empty,skip=4pt}
%   \caption[#1]{{\zihao{5}
%     { 表 \thetable}~#1\\
%     {Table \thetable}~#2}}
% }

% 设置表格默认贴紧页面左右边缘
\setlength{\LTpre}{6pt plus 2pt minus 2pt}  
\setlength{\LTpost}{-0.1em}
\setlength{\LTleft}{0pt}
\setlength{\LTright}{0pt}


\makeatletter
% 图清单格式定义（使用titletoc包，与目录保持一致）
\titlecontents{figure}
  [0.1em]                                    % 左侧缩进
  {\zihao{-4}}                             % 字体大小
  {图~\thecontentslabel\hspace{0.5em}}    % 编号格式
  {}                                       % 无编号格式
  {\titlerule*{.}\contentspage}           % 引导线和页码（与目录一致）

% 表清单格式定义（使用titletoc包，与目录保持一致）
\titlecontents{table}
  [0.1em]                                    % 左侧缩进
  {\zihao{-4}}                             % 字体大小
  {表~\thecontentslabel\hspace{0.5em}}    % 编号格式
  {}                                       % 无编号格式
  {\titlerule*{.}\contentspage}           % 引导线和页码（与目录一致）

\newcommand{\listoffiguresandtables}{%
  \clearpage%
  \vspace*{-16pt}%
  \begin{center}
      \Heiti\zihao{-2} 图表清单
  \end{center}
  \vspace{-6pt}
  \markboth{图表清单}{图表清单}
  % \addcontentsline{toc}{chapter}{图表清单}
  % \addcontentsline{eoc}{chapter}{\textbf{List of figures and tables}}
  \@starttoc{lof}
  \vskip 1.5em
  \@starttoc{lot}
}
\makeatother

% ---- 封面 ----- %
\makeatletter

% ====== 学位类型参数定义 ====== %
% 在main.tex中使用 \degreetype{academic} 或 \degreetype{professional}
\def\degreetype#1{\def\@degreetype{#1}}\def\@degreetype{academic}  % 默认为学术博士

% 定义学位类型选项
\def\@academic{academic}
\def\@professional{professional}

% ====== 中文信息 ====== %
\def\ctitlezh#1{\def\@ctitlezh{#1}}\def\@ctitlezh{}      % 题目
\def\cauthorzh#1{\def\@cauthorzh{#1}}\def\@cauthorzh{}   % 作者
\def\cadvisorzh#1{\def\@cadvisorzh{#1}}\def\@cadvisorzh{} % 导师
\def\cdegreezh#1{\def\@cdegreezh{#1}}\def\@cdegreezh{}   % 申请学位
\def\cschoolzh#1{\def\@cschoolzh{#1}}\def\@cschoolzh{}   % 院系
\def\cdatezh#1{\def\@cdatezh{#1}}\def\@cdatezh{}         % 日期

% 学术博士专用字段
\def\csubjectzh#1{\def\@csubjectzh{#1}}\def\@csubjectzh{} % 学科（学术）/专业领域（专业）
\def\cmajorzh#1{\def\@cmajorzh{#1}}\def\@cmajorzh{}       % 专业（仅学术博士）

% 专业博士专用字段
\def\cmentorzh#1{\def\@cmentorzh{#1}}\def\@cmentorzh{}    % 企业导师（仅专业博士）
\def\cclutivationzh#1{\def\@cclutivationzh{#1}}\def\@cclutivationzh{} % 学习方式（仅专业博士）

% ====== 英文信息 ====== %
\def\ctitleen#1{\def\@ctitleen{#1}}\def\@ctitleen{}       % 题目
\def\cauthoren#1{\def\@cauthoren{#1}}\def\@cauthoren{}    % 作者
\def\cadvisoren#1{\def\@cadvisoren{#1}}\def\@cadvisoren{} % 导师
\def\cdegreeen#1{\def\@cdegreeen{#1}}\def\@cdegreeen{}    % 申请学位
\def\cschoolen#1{\def\@cschoolen{#1}}\def\@cschoolen{}    % 院系
\def\cdateen#1{\def\@cdateen{#1}}\def\@cdateen{}          % 日期
\def\Ltitle#1{\def\@Ltitle{#1}}\def\@Ltitle{}          % 标题是否过长
% 学术博士专用字段
\def\csubjecten#1{\def\@csubjecten{#1}}\def\@csubjecten{} % 学科（学术）/专业领域（专业）
\def\cmajoren#1{\def\@cmajoren{#1}}\def\@cmajoren{}       % 专业（仅学术博士）
\def\ccosupervisoren#1{\def\@ccosupervisoren{#1}}\def\@ccosupervisoren{} % 联合导师（仅学术博士）

% 专业博士专用字段
\def\cmentoren#1{\def\@cmentoren{#1}}\def\@cmentoren{}    % 企业导师（仅专业博士）
\def\cclutivationen#1{\def\@cclutivationen{#1}}\def\@cclutivationen{} % 学习方式（仅专业博士）

% 图书分类号
\def\cclc#1{\def\@cclc{#1}}\def\@cclc{}                   % 国内图书分类号
\def\cudc#1{\def\@cudc{#1}}\def\@cudc{}                   % 国际图书分类号

% ====== 论文标题页 ====== %
\def\maketitlepage{
  \thispagestyle{empty}
  \par \vspace*{0.6em}
  \begin{center}
    \includegraphics[width=0.6\linewidth]{figure_for_NCEPU/ncepu.png}
  \end{center}
  \begin{center}
    {\Heiti \zihao{5} \hfill  
    \par \vspace*{0.6em}
    % 根据学位类型显示不同标题
    \ifx\@degreetype\@academic
      {\zihao{-1} \textbf{\Songti 学术博士学位论文}}
    \else
      {\zihao{-1} \textbf{\Songti 专业博士学位论文}}
    \fi
    \par \vspace{3.4em}
    % 使用弹性盒子而不是固定高度的minipage
    {\begin{spacing}{1.35} \Heiti \zihao{2} \@ctitlezh \end{spacing}}
    \par \vspace{0.3em}
    \ifx\@Ltitle
      {\begin{spacing}{1} \zihao{-2} \textbf{\@ctitleen} \end{spacing}}
    \else
      {\begin{spacing}{1} \zihao{2} \textbf{\@ctitleen} \end{spacing}}
    \fi
    % \begin{minipage}[c][6cm]{14cm}
    %     \setlength{\baselineskip}{32pt} 
    %     \centering {\heiti \zihao{2} \@ctitlezh}
    %     \par \vspace{1.2em}
    %     {\begin{spacing}{1} \zihao{2} \textbf{\@ctitleen} \end{spacing}}
    % \end{minipage}
    % 使用vfill代替固定间距，自动分配剩余空间
    \vfill
    {\Songti \zihao{-2} \textbf{\@cauthorzh}}
    \vfill
    {\Songti \zihao{-2} \textbf{\@cdatezh}}}
  \end{center}
  \vspace*{2em}
  \clearpage
}

% ====== 中文信息页 ====== %
\def\makechinainfopage{
  \thispagestyle{empty}
 {\zihao{-4} \noindent
  \begin{tabularx}{\textwidth}{@{}p{11.2cm}p{3.5cm}@{}}
    \zihao{-4}{国内图书分类号：\@cclc}  &  \zihao{-4}{ 学校代码：10054} \\
    \zihao{-4}{国际图书分类号：\@cudc } & \zihao{-4}{ 密\quad\quad 级：公开}
  \end{tabularx}}
  \par\vspace{6em}
  \begin{center}
    % 根据学位类型显示不同标题
    \ifx\@degreetype\@academic
      {\zihao{-2} \textbf{学术博士学位论文}}
      \par\vspace{4.7em}
    \else
      {\zihao{-2} \textbf{专业博士学位论文}}
      \par\vspace{4.7em}
    \fi
    {\begin{spacing}{1.35} \Heiti \zihao{2} \@ctitlezh \end{spacing}}
    % 使用弹性空间代替固定间距
    \vfill
  \end{center}
  \begin{center}
    {\zihao{4} \renewcommand{\arraystretch}{1.76}
    \begin{tabular}{c@{\hspace{0em}}l}
        \makebox[3.7cm][s]{\zihao{4}{{\Heiti 博士研究生}：}}   & \zihao{4}\@cauthorzh   \\
        \makebox[3.7cm][s]{\zihao{4}{{\Heiti 导师}：}} & \zihao{4}\@cadvisorzh    \\
        % 专业博士显示企业导师
        \ifx\@degreetype\@professional
          \makebox[3.7cm][s]{\zihao{4}{{\Heiti 企业导师}：}} & \zihao{4}\@cmentorzh   \\
        \fi
        % 学术博士显示"申请学位"，专业博士显示"申请学位 博士"
        \ifx\@degreetype\@academic
          \makebox[3.7cm][s]{\zihao{4}{{\Heiti 申请学位}：}} & \zihao{4}\@cdegreezh   \\
          \makebox[3.7cm][s]{\zihao{4}{{\Heiti 学科}：}}  & \zihao{4}\@csubjectzh  \\
          \makebox[3.7cm][s]{\zihao{4}{{\Heiti 专业}：}}  & \zihao{4}\@cmajorzh  \\
        \else
          \makebox[3.7cm][s]{\zihao{4}{{\Heiti 申请学位}：}} & \zihao{4}\@cdegreezh 博士 \\
          \makebox[3.7cm][s]{\zihao{4}{{\Heiti 专业领域}：}}  & \zihao{4}\@csubjectzh  \\
          \makebox[3.7cm][s]{\zihao{4}{{\Heiti 学习方式}：}}  & \zihao{4}\@cclutivationzh  \\
        \fi
        \makebox[3.7cm][s]{\zihao{4}{{\Heiti 所在学院}：}} & \zihao{4}\@cschoolzh  \\
        \makebox[3.7cm][s]{\zihao{4}{{\Heiti 答辩日期}：}} & \zihao{4}\@cdatezh  \\
        \makebox[3.7cm][s]{\zihao{4}{{\Heiti 授予学位单位}：}}  & \zihao{4}华北电力大学  \\
    \end{tabular}}
  \end{center}
  \vspace*{4em}  % 添加底部间距
  \clearpage
}

% ====== 英文信息页 ====== %
\def\makeenglishinfopage{
  \thispagestyle{empty}
  \noindent \zihao{-4} Classified Index: \@cclc \\ 
  \noindent \zihao{-4} U.D.C: \@cudc
  \par \vspace{6.3em}
  \begin{center}
    % 根据学位类型显示不同标题
    \ifx\@degreetype\@academic
      {\zihao{-2} Dissertation for the Academic Doctoral Degree}
    \else
      {\zihao{-2} Dissertation for the Professional Doctoral Degree}
    \fi
    \par\vspace{2.9em}
    \ifx\@Ltitle
      {\begin{spacing}{1} \zihao{-2} \textbf{\@ctitleen} \end{spacing}}
    \else
      {\begin{spacing}{1} \zihao{2} \textbf{\@ctitleen} \end{spacing}}
    \fi
    % 使用弹性空间代替固定间距
    \vfill
  \end{center}
  \begin{center}
    {\renewcommand{\arraystretch}{1.76}
    \ifx\@degreetype\@academic
      % 学术博士表格
      \begin{tabular}{@{}m{6.7cm}m{8cm}@{}}
        \textbf{\zihao{4} Candidate:} & \zihao{4} \@cauthoren \\
        \textbf{\zihao{4} Supervisor:} & \zihao{4} \@cadvisoren \\
        \textbf{\zihao{4} Co-Supervisor:} & \zihao{4} \@ccosupervisoren \\
        \textbf{\zihao{4} Academic Degree Applied for:} & \zihao{4} \@cdegreeen \\
        \textbf{\zihao{4} Subject:} & \zihao{4} \@csubjecten \\
        \textbf{\zihao{4} Speciality:} & \zihao{4} \@cmajoren \\
        \textbf{\zihao{4} School:} & \zihao{4} \@cschoolen \\ 
        \textbf{\zihao{4} Date of Defence:} & \zihao{4} \@cdateen \\
        \textbf{\zihao{4} Degree-Conferring-Institution:} & \zihao{4} North China Electric Power University \\
      \end{tabular}
    \else
      % 专业博士表格
      \begin{tabular}{@{}m{7cm}m{8cm}@{}}
        \textbf{\zihao{4} Candidate:} & \zihao{4} \@cauthoren \\
        \textbf{\zihao{4} Supervisor:} & \zihao{4} \@cadvisoren \\
        \textbf{\zihao{4} Enterprise mentor:} & \zihao{4} \@cmentoren \\
        \textbf{\zihao{4} Professional Degree Applied for:} & \zihao{4} \@cdegreeen \\
        \textbf{\zihao{4} Speciality:} & \zihao{4} \@csubjecten \\
        \textbf{\zihao{4} Cultivation ways:} & \zihao{4} \@cclutivationen \\
        \textbf{\zihao{4} School:} & \zihao{4} \@cschoolen \\
        \textbf{\zihao{4} Date of Defence:} & \zihao{4} \@cdateen \\
        \textbf{\zihao{4} Degree-Conferring-Institution:} & \zihao{4} North China Electric Power University \\
      \end{tabular}
    \fi
    }
  \end{center}
  \vspace*{1em}  % 添加底部间距
  \clearpage
}

% ====== 密级设置 ====== %
\def\csecretlevel#1{\def\@csecretlevel{#1}}\def\@csecretlevel{public}  % 密级，默认为公开

% 定义密级选项
\def\@public{public}
\def\@internal{internal}
\def\@secret{secret}
\def\@confidential{confidential}
\def\@topsecret{topsecret}

% ====== 论文声明页 ====== %
\def\makestatement{
  \thispagestyle{empty}
  \vspace*{-2.2em}
  \begin{center}{\ziju{0.01} \Heiti \zihao{-2} 华北电力大学学位论文原创性声明}\end{center}
  \par\vspace*{0.6em}
  % 设置英文自动换行，允许长单词断行
  {\zihao{-4} \sloppy
  本人郑重声明：此处所提交的学位论文《\@ctitlezh》，是本人在导师指导下，在华北电力大学攻读学位期间独立进行研究工作所取得的成果。论文中除已注明部分外不包含他人已发表或完成的研究成果。对本文的研究工作做出重要贡献的个人和集体，均已在文中以明确方式注明。论文由本人撰写，未使用人工智能代写。本声明的法律结果将完全由本人承担。
  \par \vspace*{1.5em}
  ~~ 作者签名: \hspace{3.5cm}
  \hspace{2.5cm}日期:\hspace{1cm}年\hspace{0.6cm}月 \hspace{0.6cm}日 }
  \vspace*{4.5em}
  \begin{center}{\ziju{0} \Heiti \zihao{-2} 华北电力大学学位论文使用授权书}\end{center}
  \par\vspace*{1.2em}
  % 设置英文自动换行，允许长单词断行
  {\zihao{-4} 
  学位论文系研究生在华北电力大学攻读学位期间在导师指导下完成的成果，知识产权归属华北电力大学所有，学位论文的研究内容不得以其它单位的名义发表。研究生完全了解华北电力大学关于保存、使用学位论文的规定，同意学校保留并向有关部门送交论文的复印件和电子版本，同意学校将学位论文的全部或部分内容编入有关数据库进行检索，允许论文被查阅和借阅，学校可以为存在馆际合作关系的兄弟高校用户提供文献传递服务和交换服务。本人授权华北电力大学，可以采用影印、缩印或其他复制手段保存论文，可以公布论文的全部或部分内容。
  \par \vspace*{1.5em}
  保密论文在保密期内遵守有关保密规定，解密后适用于此使用权限规定。\par
  本人知悉学位论文的使用权限，并将遵守有关规定。
  \par \vspace*{1.6em}
  本学位论文属于（请在相应方框内打“\checked”）\par
  % 根据参数自动选择对应的选项
  \ifx\@csecretlevel\@public $\Large\CheckedBox$ \else $\Large\Square$ \fi 公开 \hspace*{0.5cm} 
  \ifx\@csecretlevel\@internal $\Large\CheckedBox$ \else $\Large\Square$ \fi 内部 \hspace*{0.5cm} 
  \ifx\@csecretlevel\@secret $\Large\CheckedBox$ \else $\Large\Square$ \fi 秘密 \hspace*{0.5cm} 
  \ifx\@csecretlevel\@confidential $\Large\CheckedBox$ \else $\Large\Square$ \fi 机密 \hspace*{0.5cm} 
  \ifx\@csecretlevel\@topsecret $\Large\CheckedBox$ \else $\Large\Square$ \fi 绝密 \par 
  \par \vspace*{1.6em}
  作者签名: \hspace{3.5cm}
  \hspace{3cm}日期:\hspace{1cm}年\hspace{0.6cm}月 \hspace{0.6cm}日 
  \par \vspace*{1.6em}
  导师签名: \hspace{3.5cm}
  \hspace{3cm}日期:\hspace{1cm}年\hspace{0.6cm}月 \hspace{0.6cm}日 
  }
}

\makeatother
% % ---- 封面 ----- %
% \makeatletter

% % ====== 学位类型参数定义 ====== %
% % 在main.tex中使用 \degreetype{academic} 或 \degreetype{professional}
% \def\degreetype#1{\def\@degreetype{#1}}\def\@degreetype{academic}  % 默认为学术博士

% % 定义学位类型选项
% \def\@academic{academic}
% \def\@professional{professional}

% % ====== 中文信息 ====== %
% \def\ctitlezh#1{\def\@ctitlezh{#1}}\def\@ctitlezh{}      % 题目
% \def\cauthorzh#1{\def\@cauthorzh{#1}}\def\@cauthorzh{}   % 作者
% \def\cadvisorzh#1{\def\@cadvisorzh{#1}}\def\@cadvisorzh{} % 导师
% \def\cdegreezh#1{\def\@cdegreezh{#1}}\def\@cdegreezh{}   % 申请学位
% \def\cschoolzh#1{\def\@cschoolzh{#1}}\def\@cschoolzh{}   % 院系
% \def\cdatezh#1{\def\@cdatezh{#1}}\def\@cdatezh{}         % 日期

% % 学术博士专用字段
% \def\csubjectzh#1{\def\@csubjectzh{#1}}\def\@csubjectzh{} % 学科（学术）/专业领域（专业）
% \def\cmajorzh#1{\def\@cmajorzh{#1}}\def\@cmajorzh{}       % 专业（仅学术博士）

% % 专业博士专用字段
% \def\cmentorzh#1{\def\@cmentorzh{#1}}\def\@cmentorzh{}    % 企业导师（仅专业博士）
% \def\cclutivationzh#1{\def\@cclutivationzh{#1}}\def\@cclutivationzh{} % 学习方式（仅专业博士）

% % ====== 英文信息 ====== %
% \def\ctitleen#1{\def\@ctitleen{#1}}\def\@ctitleen{}       % 题目
% \def\cauthoren#1{\def\@cauthoren{#1}}\def\@cauthoren{}    % 作者
% \def\cadvisoren#1{\def\@cadvisoren{#1}}\def\@cadvisoren{} % 导师
% \def\cdegreeen#1{\def\@cdegreeen{#1}}\def\@cdegreeen{}    % 申请学位
% \def\cschoolen#1{\def\@cschoolen{#1}}\def\@cschoolen{}    % 院系
% \def\cdateen#1{\def\@cdateen{#1}}\def\@cdateen{}          % 日期

% % 学术博士专用字段
% \def\csubjecten#1{\def\@csubjecten{#1}}\def\@csubjecten{} % 学科（学术）/专业领域（专业）
% \def\cmajoren#1{\def\@cmajoren{#1}}\def\@cmajoren{}       % 专业（仅学术博士）
% \def\ccosupervisoren#1{\def\@ccosupervisoren{#1}}\def\@ccosupervisoren{} % 联合导师（仅学术博士）

% % 专业博士专用字段
% \def\cmentoren#1{\def\@cmentoren{#1}}\def\@cmentoren{}    % 企业导师（仅专业博士）
% \def\cclutivationen#1{\def\@cclutivationen{#1}}\def\@cclutivationen{} % 学习方式（仅专业博士）

% % 图书分类号
% \def\cclc#1{\def\@cclc{#1}}\def\@cclc{}                   % 国内图书分类号
% \def\cudc#1{\def\@cudc{#1}}\def\@cudc{}                   % 国际图书分类号

% % ====== 论文标题页 ====== %
% \def\maketitlepage{
%   \thispagestyle{empty}
%   \par \vspace*{0.6em}
%   \begin{center}
%     \includegraphics[width=0.6\linewidth]{figure_for_NCEPU/ncepu.png}
%   \end{center}
%   \begin{center}
%     {\Heiti \zihao{5} \hfill  
%     \par \vspace*{0.6em}
%     % 根据学位类型显示不同标题
%     \ifx\@degreetype\@academic
%       {\zihao{-1} \textbf{\Songti 学术博士学位论文}}
%     \else
%       {\zihao{-1} \textbf{\Songti 专业博士学位论文}}
%     \fi
%     \par \vspace{1.9em}
%     \begin{minipage}[c][6cm]{14cm}
%         \setlength{\baselineskip}{32pt} 
%         \centering {\Heiti \zihao{2} \@ctitlezh}
%         \par \vspace{1.2em}
%         \centering {\zihao{-2} \textbf{\@ctitleen}}      
%     \end{minipage}
%     \par \vspace{14em}
%     {\Songti \zihao{-2} \textbf{\@cauthorzh}}
%     \par \vspace{10.5em}
%     {\Songti \zihao{-2} \textbf{\@cdatezh}}}
%   \end{center}
%   \clearpage
% }

% % ====== 中文信息页 ====== %
% \def\makechinainfopage{
%   \thispagestyle{empty}
%  {\zihao{-4} \noindent
%   \begin{tabularx}{\textwidth}{@{}p{11.2cm}p{3.5cm}@{}}
%     \zihao{-4}{国内图书分类号：\@cclc}  &  \zihao{-4}{ 学校代码：10054} \\
%     \zihao{-4}{国际图书分类号：\@cudc } & \zihao{-4}{ 密\quad\quad 级：公开}
%   \end{tabularx}}
%   \par\vspace{6em}
%   \begin{center}
%     % 根据学位类型显示不同标题
%     \ifx\@degreetype\@academic
%       {\zihao{-2} \textbf{学术博士学位论文}}
%       \par\vspace{4.7em}
%     \else
%       {\zihao{-2} \textbf{专业博士学位论文}}
%       \par\vspace{4.7em}
%     \fi
%     {\Heiti \zihao{2} \@ctitlezh}
%     % 根据学位类型调整间距
%     \ifx\@degreetype\@academic
%       \par\vspace{13.5em}
%     \else
%       \par\vspace{10.7em}
%     \fi
%   \end{center}
%   \begin{center}
%     {\zihao{4} \renewcommand{\arraystretch}{1.6}
%     \begin{tabular}{c@{\hspace{0em}}l}
%         \makebox[3.7cm][s]{\zihao{4}{{\Heiti 博士研究生}：}}   & \zihao{4}\@cauthorzh   \\
%         \makebox[3.7cm][s]{\zihao{4}{{\Heiti 导师}：}} & \zihao{4}\@cadvisorzh    \\
%         % 专业博士显示企业导师
%         \ifx\@degreetype\@professional
%           \makebox[3.7cm][s]{\zihao{4}{{\Heiti 企业导师}：}} & \zihao{4}\@cmentorzh   \\
%         \fi
%         % 学术博士显示"申请学位"，专业博士显示"申请学位 博士"
%         \ifx\@degreetype\@academic
%           \makebox[3.7cm][s]{\zihao{4}{{\Heiti 申请学位}：}} & \zihao{4}\@cdegreezh   \\
%           \makebox[3.7cm][s]{\zihao{4}{{\Heiti 学科}：}}  & \zihao{4}\@csubjectzh  \\
%           \makebox[3.7cm][s]{\zihao{4}{{\Heiti 专业}：}}  & \zihao{4}\@cmajorzh  \\
%         \else
%           \makebox[3.7cm][s]{\zihao{4}{{\Heiti 申请学位}：}} & \zihao{4}\@cdegreezh 博士 \\
%           \makebox[3.7cm][s]{\zihao{4}{{\Heiti 专业领域}：}}  & \zihao{4}\@csubjectzh  \\
%           \makebox[3.7cm][s]{\zihao{4}{{\Heiti 学习方式}：}}  & \zihao{4}\@cclutivationzh  \\
%         \fi
%         \makebox[3.7cm][s]{\zihao{4}{{\Heiti 所在学院}：}} & \zihao{4}\@cschoolzh  \\
%         \makebox[3.7cm][s]{\zihao{4}{{\Heiti 答辩日期}：}} & \zihao{4}\@cdatezh  \\
%         \makebox[3.7cm][s]{\zihao{4}{{\Heiti 授予学位单位}：}}  & \zihao{4}华北电力大学  \\
%     \end{tabular}}
%   \end{center}
%   \clearpage
% }

% % ====== 英文信息页 ====== %
% \def\makeenglishinfopage{
%   \thispagestyle{empty}
%   \noindent \zihao{-4} Classified Index: \@cclc \\ 
%   \noindent \zihao{-4} U.D.C: \@cudc
%   \par \vspace{6.3em}
%   \begin{center}
%     % 根据学位类型显示不同标题
%     \ifx\@degreetype\@academic
%       {\zihao{-2} Dissertation for the Academic Doctoral Degree}
%     \else
%       {\zihao{-2} Dissertation for the Professional Doctoral Degree}
%     \fi
%     \par\vspace{2.9em}
%     {\begin{spacing}{1.25} \bfseries \zihao{2} \@ctitleen \end{spacing}}
%     \par\vspace{9em}
%   \end{center}
%   \begin{center}
%     {\renewcommand{\arraystretch}{1.6}
%     \ifx\@degreetype\@academic
%       % 学术博士表格
%       \begin{tabular}{@{}m{6.7cm}m{8cm}@{}}
%         \textbf{\zihao{4} Candidate:} & \zihao{4} \@cauthoren \\
%         \textbf{\zihao{4} Supervisor:} & \zihao{4} \@cadvisoren \\
%         \textbf{\zihao{4} Co-Supervisor:} & \zihao{4} \@ccosupervisoren \\
%         \textbf{\zihao{4} Academic Degree Applied for:} & \zihao{4} \@cdegreeen \\
%         \textbf{\zihao{4} Subject:} & \zihao{4} \@csubjecten \\
%         \textbf{\zihao{4} Speciality:} & \zihao{4} \@cmajoren \\
%         \textbf{\zihao{4} School:} & \zihao{4} \@cschoolen \\ 
%         \textbf{\zihao{4} Date of Defence:} & \zihao{4} \@cdateen \\
%         \textbf{\zihao{4} Degree-Conferring-Institution:} & \zihao{4} North China Electric Power University \\
%       \end{tabular}
%     \else
%       % 专业博士表格
%       \begin{tabular}{@{}m{7cm}m{8cm}@{}}
%         \textbf{\zihao{4} Candidate:} & \zihao{4} \@cauthoren \\
%         \textbf{\zihao{4} Supervisor:} & \zihao{4} \@cadvisoren \\
%         \textbf{\zihao{4} Enterprise mentor:} & \zihao{4} \@cmentoren \\
%         \textbf{\zihao{4} Professional Degree Applied for:} & \zihao{4} \@cdegreeen \\
%         \textbf{\zihao{4} Speciality:} & \zihao{4} \@csubjecten \\
%         \textbf{\zihao{4} Cultivation ways:} & \zihao{4} \@cclutivationen \\
%         \textbf{\zihao{4} School:} & \zihao{4} \@cschoolen \\
%         \textbf{\zihao{4} Date of Defence:} & \zihao{4} \@cdateen \\
%         \textbf{\zihao{4} Degree-Conferring-Institution:} & \zihao{4} North China Electric Power University \\
%       \end{tabular}
%     \fi
%     }
%   \end{center}
%   \clearpage
% }

% % ====== 密级设置 ====== %
% \def\csecretlevel#1{\def\@csecretlevel{#1}}\def\@csecretlevel{public}  % 密级，默认为公开

% % 定义密级选项
% \def\@public{public}
% \def\@internal{internal}
% \def\@secret{secret}
% \def\@confidential{confidential}
% \def\@topsecret{topsecret}

% % ====== 论文声明页 ====== %
% \def\makestatement{
%   \thispagestyle{empty}
%   \vspace*{-2.2em}
%   \begin{center}{\ziju{0.01} \Heiti \zihao{-2} 华北电力大学学位论文原创性声明}\end{center}
%   \par\vspace*{0.6em}
%   {\zihao{-4} 
%   本人郑重声明：此处所提交的学位论文《\@ctitlezh》，是本人在导师指导下，在华北电力大学攻读学位期间独立进行研究工作所取得的成果。论文中除已注明部分外不包含他人已发表或完成的研究成果。对本文的研究工作做出重要贡献的个人和集体，均已在文中以明确方式注明。论文由本人撰写，未使用人工智能代写。本声明的法律结果将完全由本人承担。
%   \par \vspace*{1.5em}
%   ~~ 作者签名: \hspace{3.5cm}
%   \hspace{2.5cm}日期:\hspace{1cm}年\hspace{0.6cm}月 \hspace{0.6cm}日 }
%   \vspace*{4.5em}
%   \begin{center}{\ziju{0} \Heiti \zihao{-2} 华北电力大学学位论文使用授权书}\end{center}
%   \par\vspace*{1.2em}
%   {\zihao{-4}
%   学位论文系研究生在华北电力大学攻读学位期间在导师指导下完成的成果，知识产权归属华北电力大学所有，学位论文的研究内容不得以其它单位的名义发表。研究生完全了解华北电力大学关于保存、使用学位论文的规定，同意学校保留并向有关部门送交论文的复印件和电子版本，同意学校将学位论文的全部或部分内容编入有关数据库进行检索，允许论文被查阅和借阅，学校可以为存在馆际合作关系的兄弟高校用户提供文献传递服务和交换服务。本人授权华北电力大学，可以采用影印、缩印或其他复制手段保存论文，可以公布论文的全部或部分内容。
%   \par \vspace*{1.5em}
%   保密论文在保密期内遵守有关保密规定，解密后适用于此使用权限规定。\par
%   本人知悉学位论文的使用权限，并将遵守有关规定。
%   \par \vspace*{1.6em}
%   本学位论文属于（请在相应方框内打“\checked”）\par
%   % 根据参数自动选择对应的选项
%   \ifx\@csecretlevel\@public $\Large\CheckedBox$ \else $\Large\Square$ \fi 公开 \hspace*{0.5cm} 
%   \ifx\@csecretlevel\@internal $\Large\CheckedBox$ \else $\Large\Square$ \fi 内部 \hspace*{0.5cm} 
%   \ifx\@csecretlevel\@secret $\Large\CheckedBox$ \else $\Large\Square$ \fi 秘密 \hspace*{0.5cm} 
%   \ifx\@csecretlevel\@confidential $\Large\CheckedBox$ \else $\Large\Square$ \fi 机密 \hspace*{0.5cm} 
%   \ifx\@csecretlevel\@topsecret $\Large\CheckedBox$ \else $\Large\Square$ \fi 绝密 \par 
%   \par \vspace*{1.4em}
%   作者签名: \hspace{3.5cm}
%   \hspace{3cm}日期:\hspace{1cm}年\hspace{0.6cm}月 \hspace{0.6cm}日 
%   \par \vspace*{1.6em}
%   导师签名: \hspace{3.5cm}
%   \hspace{3cm}日期:\hspace{1cm}年\hspace{0.6cm}月 \hspace{0.6cm}日 
%   }
% }

% \makeatother