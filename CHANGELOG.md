# Change Log
All notable changes to this project will be documented in this file.

## [0.3.0]

### Added

- added semantic modal

- added calendar

- shiny.custom.semantic.cdn options introduced to get dependencies from custom location.

### Changed

- Migrate to fomantic 2.8.3

- checkbox_ui was completely removed. Use simple_checkbox instead.

- updated slider

### Removed

- slider_input was removed

## [0.2.4]

### Added

-  shiny.custom.semantic.cdn options introduced to get dependencies from custom location.

## [0.1.2]
### Added

- Add multiple selection search dropdown

- function uimessages which creates UI Semantics message

- Shorter alternative for uimessage

- Semantic ui syntactic sugar for: form, fields, field and rexport for HTML label tab. (#43)

- New function uimenu which creates a menu using Semantic UI

- Dropdown item (uses dropdown from Semantic UI) and right menu. Also changed the style of naming functions to the one which fits the rest of the code. Items now can have a feature like 'active', 'header', etc.

- Created uidropdown function which generates dropdown using Semantic UI. It works both independetly and inside Semantic UI Menu (created with uimenu).

- Create list with header description and icons.

- Add commonly used parse_value function.

- Add semantic slider input component.

- Dependencies switched to cdn + theme support added to semantic.

- semantic.themes options introduced to get dependencies.

- Theming example added.

### Changed

- Adjust countries example.

- Updated documentation.

- Better styled examples.

- Refactor UI menu functions.

- Changed the way otems are added to menu. Also dropdown item can be added to the menu using uidropdown. Added function uilabel to create Semantic UI labels. New examples how to  use uimenu.

### Fixed

- Fixing input problem for shiny_input.

- Fixed suspendWhenHidden problem with tabset.

### Removed

- Deleted repetition of dropdown_choice function

## [0.1.1]

*2017-05-29*

### Added

- Show pointer when hovering over tabset menu items.

- Multiple selection search dropdown.

- Semantic search api and choice selection + example.

- Default dropdown component added to shiny.semantic.

### Fixed

- Documentation.

### Changed

- Documentation and examples.

- Lexical changes in description section.


## [0.1.0]

*2016-12-05*

### Added

- First version of API.

- Search selection to use api with example.

- Examples added.

- Wrap up README docs.

- Basic text input.

- Enable updateTextInput for shiny inputs.
