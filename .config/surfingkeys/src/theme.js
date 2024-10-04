export default `
 body {
    font-family: "Input Mono", "DejaVu Sans Mono", DejaVu, Arial, sans-serif;
    font-size: 12pt;
  }

  #sk_keystroke kbd {
      font-family: "Sudo Nerd Font Mono", "Sudo Mono", "Sudo",
        "Input Mono Nerd Font", "Input Mono", "DejaVu Sans Mono", "DejaVu", "Arial",
        sans-serif;
      font-size: 10pt;
    }

  .sk_theme,
  .sk_theme input {

  }
  .sk_omnibar_middle,
  #sk_omnibarSearchArea,
  .sk_theme kbd,
  .sk_theme #sk_omnibarSearchResult > ul > li,
  .sk_theme #sk_omnibarSearchResult > ul > li:nth-child(2n+1) {
    border: 1px solid !important;
  }
  #sk_editor,
  .sk_theme,
  .sk_theme #sk_omnibarSearchResult > ul > li,
  .sk_theme #sk_omnibarSearchResult > ul > li:nth-child(2n+1) {
    color: #828bb8 !important;
    border-color: #131421 !important;
    background-color: #191b28 !important;
  }
  #sk_editor .normal-mode .ace_cursor {
    border-color: #82aaff !important;
    background-color: #82aaff !important;
  }
  #sk_omnibar {
    padding: 0 !important;
  }
  .expandRichHints kbd > .candidates {
    color: #828bb8 !important;
  }

  .sk_omnibar_middle,
  #sk_tab,
  #sk_omnibarSearchArea {
    border-color: #131421 !important;
    background-color: #222436 !important;
    margin: 0 !important;
    padding: 0.5rem 1rem !important;
  }

  #sk_tab_title {
    color: #828bb8 !important;
  }

  .sk_theme .prompt {
    color: #fff !important;
  }
  .sk_theme .separator {
    color: #86e1fc !important;
  }
  .sk_theme .url {
    text-decoration: underline !important;
    color: #82aaff !important;
  }
  .sk_theme .feature_name {
    color: #c099ff !important;
  }
  .sk_theme .feature_name > span {
    border-color: #2f334d !important;
  }
  .sk_theme .resultPage,
  .sk_theme .annotation {
    color: #828bb8 !important;
  }
  .sk_theme .omnibar_timestamp {
    color: #c099ff !important;
  }
  .sk_theme .omnibar_visitcount {
    color: #82aaff !important;
  }
  .sk_theme .omnibar_highlight {
    color: #191b28 !important;
    background-color: #ffc777 !important;
  }
  .sk_theme kbd {
    color: #82aaff !important;
    border-color: #000 !important;
    background-color: #222436 !important;
    box-shadow: none;
  }
  .sk_theme tbody {
    color: #c3e88d !important;
  }
  .sk_theme input {
    color: #fff !important;
  }
  .sk_theme #sk_omnibarSearchResult {
    margin: 0 !important;
    padding: 0 !important;
    font-size: 16px !important;
  }
  .sk_theme #sk_omnibarSearchResult .omnibar_folder {
    color: #82aaff !important;
  }
  .sk_theme #sk_omnibarSearchResult > ul > li,
  .sk_theme #sk_omnibarSearchResult > ul > li:nth-child(2n+1) {
    transition: background-color !important;
    padding: 1em 1.5em !important;
  }
  .sk_theme #sk_omnibarSearchResult > ul > li.title,
  .sk_theme #sk_omnibarSearchResult > ul > li:nth-child(2n+1).title {
    color: #fff !important;
  }
  .sk_theme #sk_omnibarSearchResult > ul > li.focused,
  .sk_theme #sk_omnibarSearchResult > ul > li:nth-child(2n+1).focused {
    color: #fff !important;
    background-color: #2f334d !important;
  }
  .sk_theme .expand {
    animation: 1 forwards expand !important;
  }
  .sk_theme .collapse {
    animation: 1 forwards collapse !important;
  }
`
