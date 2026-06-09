# AI-Powered Spreadsheet App - UI Documentation

## Overview
This Flutter application combines three powerful UI patterns:
- **Google Sheets Grid Layout** (Sheet Tab)
- **Gemini Chat Interface** (Chat Tab)
- **NotebookLM Add Resource UI** (Add Tab)

## Features

### 1. Sheet Tab (Google Sheets Style Grid)
- Grid view of all spreadsheets
- Visual card layout for each sheet
- Quick access to sheet selection
- Display row count for each sheet
- Active sheet highlighting with cyan border

**Key Components:**
- `_buildSheetGridTab()` - Main grid layout
- GridView with 2-column layout
- Card-based sheet representation

### 2. Add Tab (NotebookLM Style Resource Management)
- Add resources (documents, links, text)
- Resource list with delete functionality
- Clean, organized interface
- Resource type indication

**Key Components:**
- `_buildAddResourceTab()` - Resource management interface
- TextField for resource input
- ListView for resource display
- Add/Remove resource functionality

### 3. Chat Tab (Gemini Chat Interface)
- AI-powered chat interface
- Data analysis capabilities
- Add data directly from chat
- Real-time AI responses
- Message-style layout

**Key Components:**
- `_buildChatTab()` - Chat interface
- Multi-line input field
- AI analysis display card
- Dual action buttons (Ask AI / Add Data)

## Navigation
Bottom Navigation Bar with three tabs:
- **Sheet** (Table Icon) - View and manage spreadsheets
- **Add** (Plus Icon) - Add resources and data
- **Chat** (Chat Icon) - AI interaction and analysis

## Color Scheme
- **Primary Color:** Cyan (#00BCD4)
- **Background:** Dark Navy (#0A0E27)
- **Card Background:** Deep Blue (#1A1F3A, #2A2F4A)
- **Text:** White/Light Gray
- **Accent:** Cyan with opacity variations

## Theme Details
- Dark theme for modern appearance
- Rounded corners (12px border radius)
- Cyan accent color throughout
- Consistent spacing and padding
- Material Design 3 principles

## Functionality

### Sheet Management
- Create new sheets via AI prompt
- View all created sheets in grid format
- Select sheet to view data
- Display sheet metadata (title, row count)

### Resource Management
- Add resources with names and types
- View all resources in a list
- Delete resources individually
- Resource persistence in state

### AI Chat
- Ask questions about spreadsheet data
- Get AI-powered analysis
- Add data through natural language
- Real-time AI responses

## Technical Stack
- **Framework:** Flutter
- **Backend:** Supabase
- **AI:** Google Generative AI (Gemini)
- **State Management:** StatefulWidget

## API Integration
- Supabase for data persistence
- Gemini API for AI capabilities
- JSON schema generation
- Data extraction and analysis

## File Structure
```
lib/
├── main.dart          # Main application with all UI components
assets/
├── app_icon.png       # Application icon
```

## Usage

### Create a Sheet
1. Go to "Sheet" tab
2. Enter description in input field
3. Click "Create Sheet"
4. AI generates schema automatically

### Add Resources
1. Go to "Add" tab
2. Enter resource name/URL
3. Click "Add Resource"
4. View in resource list

### Chat with AI
1. Go to "Chat" tab
2. Enter question about data
3. Click "Ask AI"
4. View AI analysis
5. Or click "Add Data" to insert new row

## Customization

### Colors
Edit the theme in `MyApp` class:
```dart
primaryColor: Colors.cyan,
scaffoldBackgroundColor: Color(0xFF0A0E27),
```

### Layout
Modify grid columns in `_buildSheetGridTab()`:
```dart
crossAxisCount: 2,  // Change to 3 or 4 for more columns
```

### Functionality
Extend the chat capabilities by modifying prompts in:
- `_generateTable()` - Schema generation
- `_insertRowData()` - Data extraction
- `_askAiAboutData()` - Analysis

## Future Enhancements
- Sheet editing capabilities
- Resource upload functionality
- Advanced data visualization
- Collaborative features
- Export/Import functionality
- Custom themes
- Offline support

## Notes
- Ensure Supabase credentials are updated in `main.dart`
- Gemini API key must be configured
- Internet connection required for AI features
- Data persists in Supabase database
