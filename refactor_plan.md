# Flutter Project Refactor Plan

## Target Architecture: Layered Architecture with Riverpod

### 1. Core Layer (`lib/core/`)
- `constants.dart`: Supabase and Gemini credentials.
- `app_theme.dart`: Material 3 theme configuration.

### 2. Data Layer (`lib/data/`)
- **Models** (`lib/data/models/`):
    - `sheet_model.dart`: Represents a spreadsheet schema.
    - `sheet_row_model.dart`: Represents a row in a spreadsheet.
    - `resource_model.dart`: Represents a NotebookLM-style resource.
- **Services** (`lib/data/services/`):
    - `supabase_service.dart`: Handles all Supabase CRUD operations.
    - `gemini_service.dart`: Handles AI schema generation, data extraction, and analysis.

### 3. Logic Layer (`lib/logic/`)
- `sheet_provider.dart`: Manages state for sheets and rows.
- `chat_provider.dart`: Manages state for AI interactions.
- `resource_provider.dart`: Manages state for resources.

### 4. Presentation Layer (`lib/presentation/`)
- **Screens** (`lib/presentation/screens/`):
    - `home_screen.dart`: Main scaffold with BottomNavigationBar.
    - `tabs/sheet_tab.dart`: Grid view of sheets.
    - `tabs/add_tab.dart`: Resource management view.
    - `tabs/chat_tab.dart`: Gemini-powered chat interface.
- **Widgets** (`lib/presentation/widgets/`):
    - `ai_analysis_card.dart`: Reusable card for AI responses.
    - `sheet_grid_item.dart`: Individual sheet card in the grid.
    - `resource_list_item.dart`: Individual resource item.

## Dependencies to Add
- `flutter_riverpod`: For state management.
- `freezed_annotation` & `json_annotation`: For model generation (optional but recommended for production).
- `intl`: For date formatting.
