-- Abbreviations
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- LaTex
return {
  -- Toogle inline math mode
  s({trig = "q", dscr = "Inline math"},
    fmta(
      "$<>$<>",
      {i(1), i(2)}
    ) 
  ),

  -- Lowercase Greek alphabet
  s({trig = "a", dscr = "alpha"},
    fmta(
      "\\alpha",
      {}
    ) 
  ),
  s({trig = "b", dscr = "beta"},
    fmta(
      "\\beta",
      {}
    ) 
  ),
  s({trig = "l", dscr = "lambda"},
    fmta(
      "\\lambda",
      {}
    ) 
  ),
  s({trig = "p", dscr = "pi"},
    fmta(
      "\\pi",
      {}
    ) 
  ),
  s({trig = "f", dscr = "phi"},
    fmta(
      "\\varphi",
      {}
    ) 
  ),
  s({trig = "w", dscr = "omega"},
    fmta(
      "\\omega",
      {}
    ) 
  ),

  -- Math mode symbols
  s({trig = "uu", dscr = "Underscript"},
    fmta(
      "<>_{<>}",
      {i(1), i(2)}
    ) 
  ),
  s({trig = "ss", dscr = "Superscript"},
    fmta(
      "<>^{<>}",
      {i(1), i(2)}
    ) 
  ),
  s({trig = "pdiff", dscr = "Partial differential"},
    fmta(
      "\\partial_{<>}<>",
      {i(1), i(2)}
    )
  ),
  s({trig = "s", dscr = "Sequence (or simply curly brackets)"},
    fmta(
      "\\{<>\\}_{<>}<>",
      {i(1), i(2), i(3)}
    ) 
  ),
  s({trig = "c", dscr = "Subset"},
    fmta(
      "\\subset",
      {}
    ) 
  ),
  s({trig = "cc", dscr = "subseteq"},
    fmta(
      "\\subseteq",
      {}
    ) 
  ),
  s({trig = "o", dscr = "Composition"},
    fmta(
      "\\circ",
      {}
    ) 
  ),
  s({trig = "fdef", dscr = "Map definition"},
    fmta(
      "<>:\\,<>\\,\\to <>",
      {i(1), i(2), i(3)}
    ) 
  ),


  -- Math mode macros
  s({trig = "prime", dscr = "Prime"},
    fmta(
      "\\newprime{<>}<>",
      {i(1), i(2)}
    ) 
  ),
  s({trig = "pprime", dscr = "Double-prime"},
    fmta(
      "\\pprime{<>}<>",
      {i(1), i(2)}
    ) 
  ),
  s({trig = "txt", dscr = "Text"},
    fmta(
      "\\text{<>}<>",
      {i(1), i(2)}
    ) 
  ),
  s({trig = "tilde", dscr = "Tilde"},
    fmta(
      "\\tilde{<>}<>",
      {i(1), i(2)}
    ) 
  ),
  s({trig = "ff", dscr = "Traditional fraction"}, 
    {
      t("\\frac{"),
      i(1),
      t("}{"),
      i(2),
      t("}")
    }
  ),
  s({trig = "diff", dscr = "Total differential"},
    fmta(
      "\\frac{d}{d<>}",
      {i(1)}
    )
  ),
  s({trig = "int", dscr = "Definite integral"}, 
    {
      t("\\int_{"),
      i(1),
      t("}^{"),
      i(2),
      t("}"),
      i(3)
    }
  ),
  s({trig="sum", dscr = "Finite series"},
    fmta("\\sum_{<>=<>}^{<>}",
      {i(1), i(2), i(3)}
    )
  ),
  s({trig="infsum", dscr = "Infinite series"},
    fmta("\\sum_{<>=<>}^{\\infty}",
      {i(1), i(2)}
    )
  ),

  -- Math typefaces 
  s({trig = "bb", dscr = "Blackboard bold font"},
    fmta(
      "\\mathbb{<>}",
      {i(1)}
    )
  ),
  s({trig = "cal", dscr = "Calligraphic font"},
    fmta(
      "\\mathcal{<>}",
      {i(1)}
    )
  ),
  s({trig = "frak", dscr = "Fraktur font"},
    fmta(
      "\\mathfrak{<>}",
      {i(1)}
    )
  ),
  s({trig = "bs", dscr = "Boldsymbol (boldface for symbols)"},
    fmta(
      "\\boldsymbol{<>}",
      {i(1)}
    )   
  ),

  -- Text mode
  s({trig = "sec", dscr = "Section"},
    fmta(
      "\\section{<>}\\label{sec<>}",
      {i(1), i(2)}
    )   
  ),
  s({trig = "sub", dscr = "Sub-Section"},
    fmta(
      "\\subsection{<>}\\label{subsec<>}",
      {i(1), i(2)}
    )   
  ),
  s({trig = "subsub", dscr = "Sub-Sub-Section"},
    fmta(
      "\\subsubsection{<>}\\label{subsubsec<>}",
      {i(1), i(2)}
    )   
  ),
  s({trig = "it", dscr = "Italianised text"},
    fmta(
      "\\textit{<>}",
      {d(1, get_visual)}
    )
  ),
  s({trig = "bf", dscr = "Bold face text"},
    fmta(
      "\\textbf{<>}",
      {d(1, get_visual)}
    )
  ),
  s({trig = "ref", dscr = "General reference"},
    fmta(
      "\\ref{<>}",
      {i(1)}
    )
  ),
  s({trig = "refeq", dscr = "Equation reference"},
    fmta(
      "\\eqref{eq<>}<>",
      {i(1), i(2)}
    )
  ),
  s({trig = "cit", dscr = "Citation"},
    fmta(
      "\\cite{<>}$<>",
      {i(1), i(2)}
    )
  ),
  s({trig = "hl", dscr = "Highlighting yellow (default)"},
    fmta(
      "\\hl{<>}",
      {i(1)}
    )
  ),
  s({trig = "hlg", dscr = "Highlighting green"},
    fmta(
      "\\hl[LimeGreen]{<>}",
      {i(1)}
    )
  ),
  s({trig = "hlb", dscr = "Highlighting blue"},
    fmta(
      "\\hl[Cyan]{<>}",
      {i(1)}
    )
  ),
  s({trig = "hlp", dscr = "Highlighting purple"},
    fmta(
      "\\hl[WildStrawberry]{<>}",
      {i(1)}
    )
  ),
  s({trig = "code", dscr = "Command"},
    fmta(
      "\\hl[Gray]{\textcolor{Mulberry}{<>}}<>",
      {i(1), i(2)}
    )
  ),

  -- Envs shorthands
  s({trig="env", dscr = "General environment"},
    fmta(
      [[
        \begin{<>}
             <>
        \end{<>}
      ]],
      {i(1), i(2), rep(1)}
    )
  ),
  s({trig="item", dscr = "Bulleted lists"},
    fmta(
      [[
        \begin{itemize}
             \item <>;
             \item <>;
        \end{itemize}
        <>
      ]],
      {i(1), i(2), i(3)}
    )
  ),
  s({trig="fig", dscr = "Figure environment"},
    fmta(
      [[
        \begin{figure}[H]
            \centering 
            %\includegraphics[keepaspectratio, width=\textwidth]{../figures/<>.png}
            \caption{<>}
            \label{fig<>}
        \end{figure}
        <>
      ]],
      {i(1), i(2), i(3), i(4)}
    )
  ),
  s({trig="snip", dscr = "Snippets environment"},
    fmta(
    "\\lstinputlisting[language=<>]{snippets/<>}<>",
      {i(1), i(2), i(3)}
    )
  ),
  s({trig = "eq", dscr = "Numbered equation"},
    fmta(
      [[
        \begin{equation}\label{eq<>}
             <>
        \end{equation}
        <>
      ]],
      {i(1), i(2), i(3)}
    )
  ), 
  s({trig = "multieq", dscr = "Multiline equation"},
    fmta(
      [[
        \begin{align}
             <> =& <> = \nonumber \\
                =& <> \,, \label{eq<>} 
        \end{align}
        <>
      ]],
      {i(1), i(2), i(3), i(4), i(5)}
    )
  ),
  s({trig = "sys", dscr = "System of equations"},
    fmta(
      [[
        \begin{equation}\label{eq<>}
           \begin{cases}
              <> \,, \\
              <> \,, 
           \end{cases}
        \end{equation}
        <>
      ]],
      {i(1), i(2), i(3), i(4)}
    )
  ), 
  s({trig = "thm", dscr = "Theorem custom env"},
    fmta(
      [[
        \begin{theorem}[label=thm<>]{<>}{}
             <>
        \end{theorem}
        <>
      ]],
      {i(1), i(2), i(3), i(4)}
    )
  ), 
  s({trig = "def", dscr = "Definition custom env"},
    fmta(
      [[
        \begin{definition}[<>]\label{def<>}
             <>
        \end{definition}
        <>
      ]],
      {i(1), i(2), i(3), i(4)}
    )
  ), 
  s({trig = "obs", dscr = "Obervation custom env"},
    fmta(
      [[
        \begin{observation}\label{obs<>}
             <>
        \end{observation}
        <>
      ]],
      {i(1), i(2), i(3)}
    )
  ), 
  s({trig = "ex", dscr = "Example custom env"},
    fmta(
      [[
        \begin{example}[label=ex<>]{}{}
             <>
        \end{example}
        <>
      ]],
      {i(1), i(2), i(3)}
    )
  ),
  s({trig = "interp", dscr = "Interpretation custom env"},
    fmta(
      [[
        \begin{interpretation*}{}
             <>
        \end{interpretation*}
        <>
      ]],
      {i(1), i(2)}
    )
  ),
  s({trig = "cor", dscr = "Corollary custom env"},
    fmta(
      [[
        \begin{corollary}
             <>
        \end{corollary}
        <>
      ]],
      {i(1), i(2)}
    )
  ),  
  s({trig = "lemma", dscr = "Lemma custom env"},
    fmta(
      [[
        \begin{lemma}
             <>
        \end{lemma}
        <>
      ]],
      {i(1), i(2)}
    )
  ),  
  s({trig = "prop", dscr = "Proposition custom env"},
    fmta(
      [[
        \begin{proposition*}
             <>
        \end{proposition*}
        <>
      ]],
      {i(1), i(2)}
    )
  ),
  s({trig = "rmk", dscr = "Remark custom env"},
    fmta(
      [[
        \begin{remark*}
             <>
        \end{remark*}
        <>
      ]],
      {i(1), i(2)}
    )
  ),
  s({trig = "proof", dscr = "Proof custom env"},
    fmta(
      [[
        \begin{proof}
             <>
        \end{proof}
        <>
      ]],
      {i(1), i(2)}
    )
  ),
  s({trig = "exercises", dscr = "Exercise custom env"},
    fmta(
      [[
        \subsection{Exercises}
        \begin{exercise}{<>}
             \textbf{Solution:} <>
        \end{exercise}
        <>
      ]],
      {i(1), i(2), i(3)}
    )
  ),
}

