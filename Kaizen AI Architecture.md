# 🌱 KAIZEN AI — Architecture Blueprint
> **Version:** 1.0 | **Tech Lead:** AI Architect | **Stack:** Flutter · BLoC · Drift · GoRouter · Neumorphism

---

## 📋 TABLE OF CONTENTS

1. [Project Overview & Decisions Log](#1-project-overview--decisions-log)
2. [Tech Stack & Dependencies](#2-tech-stack--dependencies)
3. [Folder Structure](#3-folder-structure)
4. [Design System](#4-design-system)
5. [Data Models](#5-data-models)
6. [Feature Architecture](#6-feature-architecture)
7. [Rafael AI Engine](#7-rafael-ai-engine)
8. [Habit Tree Algorithm](#8-habit-tree-algorithm)
9. [Navigation Map (GoRouter)](#9-navigation-map-gorouter)
10. [BLoC Event-State Contracts](#10-bloc-event-state-contracts)
11. [Sprint Implementation Plan](#11-sprint-implementation-plan)
12. [Key Technical Decisions & Risks](#12-key-technical-decisions--risks)

---

## 1. PROJECT OVERVIEW & DECISIONS LOG

### App Identity
- **Name:** Kaizen AI
- **Purpose:** Habit formation using the Kaizen philosophy — small, consistent, daily improvements
- **Target:** Single user, fully offline, mobile-first (iOS + Android)

### Confirmed Decisions (from Product Owner)

| # | Decision | Choice | Impact |
|---|----------|--------|--------|
| D1 | Rafael AI Engine | Local rule-based + heuristic (offline) | No API layer needed |
| D2 | AI Modes | 2 distinct modes: **Copilot** (suggest) + **Autopilot** (auto-apply) | Separate BLoC states |
| D3 | Habit Tree Mapping | 1 habit → 1 tree (parallel trees) | Tree table has unique habitId FK |
| D4 | Timer Background | Yes — continues when app minimized | Requires flutter_foreground_task |
| D5 | Heatmap Range | User selects 3 / 6 / 12 months | RangeSelector widget + Stats query filter |
| D6 | Notifications | Out of MVP scope (Sprint 8+) | No local_notifications dependency in v1 |
| D7 | Tree Stages | 6 stages: Hạt → Mầm → Cây con → Cây → Cây to → Cây cổ thụ | Streak-threshold algorithm |

---

## 2. TECH STACK & DEPENDENCIES

### Core Framework
```
Flutter SDK: >=3.19.0
Dart SDK: >=3.3.0
```

### pubspec.yaml Dependencies

#### State Management & Architecture
- `flutter_bloc: ^8.1.x` — BLoC state management
- `bloc: ^8.1.x` — Core BLoC library
- `get_it: ^7.6.x` — Service locator for DI
- `injectable: ^2.3.x` — Code gen for get_it
- `injectable_generator: ^2.4.x` — (dev)

#### Navigation
- `go_router: ^13.x.x` — Declarative routing

#### Database
- `drift: ^2.18.x` — Type-safe SQLite ORM
- `drift_flutter: ^0.2.x` — Flutter integration
- `sqlite3_flutter_libs: ^0.5.x` — SQLite binaries
- `shared_preferences: ^2.2.x` — Simple key-value storage

#### Background Timer
- `flutter_foreground_task: ^7.x.x` — Foreground service (Android) + background task (iOS)

#### Charts & Visualization
- `fl_chart: ^0.68.x` — Bar charts for Stats
- Custom heatmap via CustomPainter (no package — full control needed)

#### Animation
- `lottie: ^3.x.x` — Hourglass animation (or CustomPainter fallback)

#### Utilities
- `equatable: ^2.0.x` — Value equality for entities/states
- `freezed: ^2.5.x` — Immutable data classes (entities, states)
- `freezed_annotation: ^2.4.x`
- `json_annotation: ^4.8.x`
- `build_runner: ^2.4.x` — (dev) Code generation

#### Code Quality (dev)
- `flutter_lints: ^4.0.x`
- `very_good_analysis: ^6.0.x`

---

## 3. FOLDER STRUCTURE

```
kaizen_ai/
├── lib/
│   ├── main.dart
│   ├── app/
│   │   ├── app.dart                        # MaterialApp + theme setup
│   │   ├── router/
│   │   │   ├── app_router.dart             # GoRouter configuration
│   │   │   └── route_paths.dart            # Route path constants
│   │   └── di/
│   │       ├── injection_container.dart    # get_it registrations
│   │       └── injection_container.config.dart  # (generated)
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_constants.dart          # App-wide magic numbers
│   │   │   ├── duration_constants.dart     # Default/min/max durations, increments
│   │   │   └── tree_constants.dart         # Stage thresholds
│   │   ├── database/
│   │   │   ├── app_database.dart           # Drift @DriftDatabase declaration
│   │   │   ├── app_database.g.dart         # (generated)
│   │   │   └── daos/                       # Data Access Objects per feature
│   │   │       ├── habit_dao.dart
│   │   │       ├── habit_log_dao.dart
│   │   │       └── habit_tree_dao.dart
│   │   ├── errors/
│   │   │   ├── failures.dart               # Abstract Failure + subclasses
│   │   │   └── exceptions.dart             # DatabaseException, etc.
│   │   ├── extensions/
│   │   │   ├── date_extensions.dart        # toDateOnly(), isSameDay(), etc.
│   │   │   ├── duration_extensions.dart    # formatMMSS(), etc.
│   │   │   └── color_extensions.dart       # neumorphic shadow helpers
│   │   ├── theme/
│   │   │   ├── app_theme.dart              # ThemeData light + dark
│   │   │   ├── app_colors.dart             # Color palette constants
│   │   │   ├── app_text_styles.dart        # TextStyle definitions
│   │   │   ├── app_dimensions.dart         # Spacing, radius, shadow offsets
│   │   │   └── neumorphism/
│   │   │       ├── neumorphic_styles.dart  # BoxDecoration factories
│   │   │       └── neumorphic_theme.dart   # Context extension for neumorphic props
│   │   ├── usecases/
│   │   │   └── usecase.dart                # Abstract UseCase<Type, Params>
│   │   └── widgets/                        # Shared design system components
│   │       ├── neumorphic_button.dart
│   │       ├── neumorphic_card.dart
│   │       ├── neumorphic_container.dart
│   │       ├── neumorphic_toggle.dart
│   │       ├── neumorphic_slider.dart
│   │       ├── app_drawer.dart             # Shared navigation drawer
│   │       └── empty_state_widget.dart
│   │
│   ├── features/
│   │   │
│   │   ├── habit/                          # FEATURE: Habit Management
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── habit_local_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── habit_model.dart        # Drift companion + fromEntity/toEntity
│   │   │   │   │   └── habit_log_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── habit_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── habit.dart              # @freezed
│   │   │   │   │   ├── habit_log.dart          # @freezed
│   │   │   │   │   └── enums/
│   │   │   │   │       ├── habit_status.dart   # completed | gave_up | skipped
│   │   │   │   │       ├── level_up_mode.dart  # manual | copilot | autopilot
│   │   │   │   │       └── tree_type.dart      # oak | pine | cherry | bamboo | ...
│   │   │   │   ├── repositories/
│   │   │   │   │   └── habit_repository.dart   # Abstract interface
│   │   │   │   └── usecases/
│   │   │   │       ├── create_habit_usecase.dart
│   │   │   │       ├── update_habit_usecase.dart
│   │   │   │       ├── delete_habit_usecase.dart
│   │   │   │       ├── get_all_habits_usecase.dart
│   │   │   │       ├── get_habit_by_id_usecase.dart
│   │   │   │       ├── level_up_habit_usecase.dart
│   │   │   │       ├── level_down_habit_usecase.dart
│   │   │   │       └── archive_habit_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── habit_list/
│   │   │       │   │   ├── habit_list_bloc.dart
│   │   │       │   │   ├── habit_list_event.dart
│   │   │       │   │   └── habit_list_state.dart
│   │   │       │   └── habit_form/
│   │   │       │       ├── habit_form_bloc.dart
│   │   │       │       ├── habit_form_event.dart
│   │   │       │       └── habit_form_state.dart
│   │   │       ├── pages/
│   │   │       │   ├── home_page.dart          # Splash/Home = HabitList
│   │   │       │   ├── create_habit_page.dart
│   │   │       │   └── edit_habit_page.dart
│   │   │       └── widgets/
│   │   │           ├── habit_card.dart          # Neumorphic swipeable card
│   │   │           ├── habit_list_view.dart
│   │   │           ├── level_badge_widget.dart
│   │   │           ├── streak_display_widget.dart
│   │   │           └── icon_color_picker.dart
│   │   │
│   │   ├── timer/                          # FEATURE: Timer
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── timer_service.dart      # flutter_foreground_task wrapper
│   │   │   │   └── repositories/
│   │   │   │       └── timer_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── timer_session.dart      # @freezed: elapsed, target, status
│   │   │   │   ├── repositories/
│   │   │   │   │   └── timer_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── start_timer_usecase.dart
│   │   │   │       ├── pause_timer_usecase.dart
│   │   │   │       ├── resume_timer_usecase.dart
│   │   │   │       ├── give_up_timer_usecase.dart
│   │   │   │       └── finish_timer_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── timer_bloc.dart
│   │   │       │   ├── timer_event.dart
│   │   │       │   └── timer_state.dart        # 5 states: Initial|Running|Paused|GaveUp|Finished
│   │   │       ├── pages/
│   │   │       │   └── timer_page.dart
│   │   │       └── widgets/
│   │   │           ├── hourglass_animation.dart # CustomPainter sand animation
│   │   │           ├── countdown_display.dart   # MM:SS text
│   │   │           ├── timer_progress_bar.dart  # Neumorphic inset progress
│   │   │           └── timer_action_buttons.dart
│   │   │
│   │   ├── stats/                          # FEATURE: Statistics
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── stats_local_datasource.dart
│   │   │   │   └── repositories/
│   │   │   │       └── stats_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── day_stat.dart           # date, status, durationMinutes, completionPct
│   │   │   │   │   └── period_summary.dart     # aggregated for bar chart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── stats_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_heatmap_data_usecase.dart   # returns List<DayStat>
│   │   │   │       └── get_bar_chart_data_usecase.dart # returns List<PeriodSummary>
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── stats_bloc.dart
│   │   │       │   ├── stats_event.dart
│   │   │       │   └── stats_state.dart
│   │   │       ├── pages/
│   │   │       │   └── stats_page.dart
│   │   │       └── widgets/
│   │   │           ├── habit_selector_bar.dart      # Dropdown/chips to pick habit
│   │   │           ├── heatmap_calendar.dart        # CustomPainter circular heatmap
│   │   │           ├── heatmap_legend.dart
│   │   │           ├── range_selector_widget.dart   # 3/6/12 month tabs
│   │   │           └── completion_bar_chart.dart    # fl_chart bar chart
│   │   │
│   │   ├── habit_tree/                     # FEATURE: Habit Tree
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── habit_tree_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── tree_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── habit_tree.dart         # @freezed: habitId, treeType, stage, totalDays
│   │   │   │   ├── repositories/
│   │   │   │   │   └── tree_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_trees_usecase.dart
│   │   │   │       ├── get_tree_for_habit_usecase.dart
│   │   │   │       ├── update_tree_stage_usecase.dart
│   │   │   │       └── assign_tree_to_habit_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── tree_bloc.dart
│   │   │       │   ├── tree_event.dart
│   │   │       │   └── tree_state.dart
│   │   │       ├── pages/
│   │   │       │   ├── habit_tree_page.dart    # Garden view: all trees
│   │   │       │   └── tree_detail_page.dart   # Single tree + stats
│   │   │       └── widgets/
│   │   │           ├── tree_canvas.dart            # CustomPainter tree renderer
│   │   │           ├── tree_stage_indicator.dart   # Progress through 6 stages
│   │   │           ├── tree_type_selector.dart     # Pick tree species
│   │   │           └── tree_card.dart              # Neumorphic card per tree
│   │   │
│   │   ├── rafael_ai/                      # FEATURE: AI Engine
│   │   │   ├── engine/                     # Pure Dart — no Flutter imports
│   │   │   │   ├── rafael_engine.dart          # Orchestrator
│   │   │   │   ├── pattern_analyzer.dart       # Analyzes log history
│   │   │   │   ├── level_advisor.dart          # Outputs LevelAdvice
│   │   │   │   └── models/
│   │   │   │       ├── habit_pattern.dart      # Computed pattern from logs
│   │   │   │       ├── level_advice.dart       # levelUp | levelDown | maintain + reason
│   │   │   │       └── ai_mode.dart            # none | copilot | autopilot (enum)
│   │   │   ├── domain/
│   │   │   │   └── usecases/
│   │   │   │       ├── analyze_and_advise_usecase.dart
│   │   │   │       └── auto_apply_advice_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── rafael_bloc.dart
│   │   │       │   ├── rafael_event.dart
│   │   │       │   └── rafael_state.dart
│   │   │       └── widgets/
│   │   │           ├── copilot_bottom_sheet.dart   # Suggestion + Accept/Dismiss
│   │   │           ├── autopilot_snackbar.dart     # "Rafael adjusted your habit"
│   │   │           └── ai_insight_card.dart        # Inline insight on HabitCard
│   │   │
│   │   └── settings/                       # FEATURE: Settings
│   │       ├── data/
│   │       │   └── datasources/
│   │       │       └── settings_datasource.dart    # SharedPreferences wrapper
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   │   └── app_settings.dart       # @freezed
│   │       │   └── usecases/
│   │       │       ├── get_settings_usecase.dart
│   │       │       └── save_settings_usecase.dart
│   │       └── presentation/
│   │           ├── bloc/
│   │           │   ├── settings_bloc.dart
│   │           │   ├── settings_event.dart
│   │           │   └── settings_state.dart
│   │           ├── pages/
│   │           │   ├── settings_page.dart          # Global settings
│   │           │   ├── habit_settings_page.dart    # Per-habit config
│   │           │   ├── introduction_page.dart
│   │           │   └── about_page.dart
│   │           └── widgets/
│   │               ├── settings_section.dart
│   │               ├── duration_config_tile.dart
│   │               └── ai_mode_selector.dart
│   │
│   └── l10n/                               # (Future: i18n support)
│
├── test/
│   ├── unit/
│   │   ├── rafael_ai/
│   │   │   ├── pattern_analyzer_test.dart
│   │   │   └── level_advisor_test.dart
│   │   └── habit/
│   │       └── level_usecase_test.dart
│   ├── widget/
│   │   ├── habit_card_test.dart
│   │   └── heatmap_calendar_test.dart
│   └── helpers/
│       └── test_helpers.dart
│
├── assets/
│   ├── animations/
│   │   └── hourglass.json              # Lottie animation
│   ├── images/
│   │   └── trees/                      # SVG/PNG per tree type × 6 stages
│   │       ├── oak_stage_0.svg
│   │       ├── oak_stage_1.svg
│   │       └── ...
│   └── icons/
│       └── habit_icons/                # Custom habit icons
│
├── android/
├── ios/
└── pubspec.yaml
```

---

## 4. DESIGN SYSTEM

### 4.1 Color Palette

```
PRIMARY SURFACE COLORS (60% White family)
  Surface Base:        #EEF2EE   — main background (slight green tint)
  Surface Elevated:    #F5F7F5   — card base (lighter)
  Shadow Light:        #FFFFFF   — neumorphic highlight (top-left)
  Shadow Dark:         #C8D4C8   — neumorphic shadow (bottom-right)

PRIMARY BRAND (30% Green family)
  Primary:             #4CAF50   — main green (CTAs, accents)
  Primary Dark:        #388E3C   — pressed states
  Primary Light:       #81C784   — secondary accents
  Primary Container:   #C8E6C9   — chip backgrounds
  On Primary:          #FFFFFF

SEMANTIC COLORS (10% Others)
  Success:             #2E7D32
  Warning:             #F6AD55   — Give Up state / yellow heatmap dot
  Danger:              #E53E3E   — timer urgency
  Missed:              #2D3748   — Black heatmap dot (skipped day)
  Text Primary:        #1A2E1A
  Text Secondary:      #4A6B4A
  Text Hint:           #90A090

HEATMAP RED SPECTRUM (Completed days — 6 distinct shades)
  Level 1 (10 min):   #FED7D7   — very light red
  Level 2 (15 min):   #FEB2B2
  Level 3 (20 min):   #FC8181
  Level 4 (25 min):   #F56565
  Level 5 (30 min):   #E53E3E
  Level 6 (35+ min):  #9B2C2C   — darkest red
```

> **Contrast note:** All 6 red shades have been selected with ΔE > 8 between adjacent levels to ensure perceptible difference for habit level progression.

### 4.2 Neumorphism Specifications

```
Standard Neumorphic Container:
  background:          Surface Base (#EEF2EE)
  borderRadius:        16px (cards), 12px (small), 50px (buttons), 8px (inputs)
  boxShadow:
    - offset: (-4, -4), blur: 10, color: Shadow Light (#FFFFFF) at 80% opacity
    - offset: (4, 4),   blur: 10, color: Shadow Dark (#C8D4C8) at 60% opacity

Pressed / Active Inset:
  boxShadow:
    - offset: (4, 4),   blur: 8,  color: Shadow Dark (inward simulation)
    - offset: (-4, -4), blur: 8,  color: Shadow Light (inward simulation)
  
Progress Bar (inset groove):
  Container: inset shadow
  Fill:      Linear gradient — Primary Light → Primary

Toggle Button:
  Active:   Inset shadow + Primary color accent ring
  Inactive: Standard raised shadow
```

### 4.3 Typography

```
Font Family: Primary = "Nunito" (rounded, friendly, nature-aligned)
             Monospace = "JetBrains Mono" (timer countdown only)

Scale:
  displayLarge:   32sp, Bold      — Page titles
  displayMedium:  24sp, Bold      — Section headers
  headlineMedium: 20sp, SemiBold  — Card titles, habit names
  titleMedium:    16sp, SemiBold  — Drawer items, labels
  bodyLarge:      15sp, Regular   — Body text
  bodyMedium:     13sp, Regular   — Descriptions, hints
  labelLarge:     14sp, Bold      — Button labels
  monoLarge:      48sp, Bold      — Timer countdown (JetBrains Mono)
```

### 4.4 Spacing & Dimensions

```
Grid: 8dp base unit
  xs:   4dp
  sm:   8dp
  md:   16dp
  lg:   24dp
  xl:   32dp
  xxl:  48dp

Card elevation equiv:  shadow offset 4dp
Drawer width:          80% of screen
BottomSheet min-height: 40% of screen
Timer Hourglass size:  240×320dp
Heatmap cell size:     14dp circle, 4dp gap
```

---

## 5. DATA MODELS

### 5.1 Drift Tables

#### habits
| Column | Type | Default | Notes |
|--------|------|---------|-------|
| id | INTEGER PK autoincrement | — | |
| name | TEXT (1-100) | — | |
| description | TEXT nullable | null | |
| icon_code | INTEGER | — | IconData.codePoint |
| color_hex | TEXT | '#4CAF50' | Hex string |
| current_duration_minutes | INTEGER | 10 | Current daily target |
| max_duration_minutes | INTEGER | 120 | User-configurable ceiling |
| increment_minutes | INTEGER | 5 | Step per level up |
| tree_type | TEXT | 'oak' | Enum as string |
| level_up_mode | TEXT | 'manual' | manual/copilot/autopilot |
| current_streak | INTEGER | 0 | Consecutive completion days |
| longest_streak | INTEGER | 0 | All-time best streak |
| total_completed_days | INTEGER | 0 | For tree growth |
| is_archived | BOOLEAN | false | Soft delete |
| created_at | DATETIME | now() | |
| updated_at | DATETIME | now() | |

#### habit_logs
| Column | Type | Default | Notes |
|--------|------|---------|-------|
| id | INTEGER PK autoincrement | — | |
| habit_id | INTEGER FK habits.id | — | |
| log_date | DATETIME | — | Store as midnight UTC |
| target_duration_minutes | INTEGER | — | Snapshot at time of session |
| actual_duration_minutes | INTEGER | 0 | Updated on finish/give_up |
| status | TEXT | 'skipped' | completed/gave_up/skipped |
| completion_percentage | REAL | 0.0 | actual/target × 100 |
| created_at | DATETIME | now() | |

> **Constraint:** UNIQUE(habit_id, log_date) — one log per habit per day

#### habit_trees
| Column | Type | Default | Notes |
|--------|------|---------|-------|
| id | INTEGER PK autoincrement | — | |
| habit_id | INTEGER FK habits.id UNIQUE | — | 1:1 with habit |
| tree_type | TEXT | 'oak' | oak/pine/cherry/bamboo/bonsai |
| current_stage | INTEGER | 0 | 0–5 |
| created_at | DATETIME | now() | |
| updated_at | DATETIME | now() | |

### 5.2 SharedPreferences Keys

```
PREF_THEME_MODE         = 'theme_mode'           // 'light' | 'dark'
PREF_GLOBAL_AI_MODE     = 'global_ai_mode'       // 'none' | 'copilot' | 'autopilot'
PREF_ONBOARDING_DONE    = 'onboarding_done'      // bool
PREF_TIMER_HABIT_ID     = 'timer_active_habit_id'  // int (for recovery)
PREF_TIMER_START_EPOCH  = 'timer_start_epoch'    // int (ms timestamp)
PREF_TIMER_ELAPSED_SEC  = 'timer_elapsed_seconds'// int (paused snapshot)
PREF_TIMER_STATUS       = 'timer_status'         // 'running' | 'paused'
```

### 5.3 Domain Entities (Freezed)

#### Habit (entity)
```
- id, name, description, iconCode, colorHex
- currentDurationMinutes, maxDurationMinutes, incrementMinutes
- treeType: TreeType (enum)
- levelUpMode: LevelUpMode (enum)
- currentStreak, longestStreak, totalCompletedDays
- isArchived, createdAt, updatedAt
```

#### HabitLog (entity)
```
- id, habitId, logDate
- targetDurationMinutes, actualDurationMinutes
- status: HabitStatus (enum)
- completionPercentage: double
```

#### HabitTree (entity)
```
- id, habitId
- treeType: TreeType (enum)
- currentStage: int (0-5)
- createdAt, updatedAt
```

#### TimerSession (entity)
```
- habitId, targetSeconds
- elapsedSeconds
- status: TimerStatus (initial|running|paused|gaveUp|finished)
- startedAt: DateTime?
```

#### AppSettings (entity)
```
- themeMode: ThemeMode
- globalAiMode: AiMode
- onboardingDone: bool
```

#### LevelAdvice (AI output)
```
- habitId
- advice: AdviceType (levelUp | levelDown | maintain)
- reasoning: String (human-readable explanation)
- suggestedDurationMinutes: int
- confidence: double (0.0–1.0)
- triggerRules: List<String> (which rules fired)
```

#### HabitPattern (AI computed)
```
- habitId
- windowDays: int (analysis window size)
- logs: List<HabitLog> (last N days)
- completionRate: double
- giveUpRate: double
- avgCompletionPercentage: double
- consecutiveGiveUps: int
- consecutiveCompletions: int
- lastNDaysStatus: List<HabitStatus>
```

---

## 6. FEATURE ARCHITECTURE

### 6.1 Habit Management Feature

**Flow:** HomePage → Drawer / FAB → Create/Edit → HabitCard

**HabitCard responsibilities:**
- Display: name, icon, current duration, streak badge, tree stage mini-icon
- Swipe right: Start timer → navigate to TimerPage
- Swipe left: Reveal delete / archive actions
- Long press: Edit habit
- Level Up button (visible only in manual mode, conditionally in copilot)
- AI insight indicator dot (when Rafael has advice pending)

**Streak calculation logic (in HabitRepository):**
- On each save of a HabitLog with status=completed, check yesterday's log
- If yesterday was also completed → increment streak; else reset to 1
- Update longest_streak if currentStreak > longestStreak
- On skipped day: streak resets to 0 (computed at app open, not background)

### 6.2 Timer Feature

**Timer States:**
```
TimerInitial   → [TapToStart]    → TimerRunning
TimerRunning   → [Pause]         → TimerPaused
TimerRunning   → [GiveUp]        → TimerGaveUp
TimerRunning   → [elapsed=0]     → TimerFinished
TimerPaused    → [Resume]        → TimerRunning
TimerPaused    → [GiveUp]        → TimerGaveUp
TimerGaveUp                      — saves log (gave_up) → pop with result
TimerFinished                    — saves log (completed) → pop with result
```

**Background timer mechanism:**
- On Start: write PREF_TIMER_START_EPOCH + PREF_TIMER_STATUS to SharedPrefs
- On Pause: write PREF_TIMER_ELAPSED_SEC snapshot, status='paused'
- On app resume: TimerService reads prefs, computes elapsed = now - startEpoch + savedElapsed
- flutter_foreground_task posts a persistent notification: "⏳ Reading — 08:32 remaining"
- On finish/give_up: clear all timer prefs

**HourglassAnimation (CustomPainter):**
- Draw two triangles (top full → empty, bottom empty → fills)
- Sand particles: N dots that fall from top chamber to bottom
- Progress drives sand level: 0% → all sand top, 100% → all sand bottom
- Subtle swing animation on the hourglass frame (SineWave curve)

### 6.3 Stats Feature

**Data pipeline:**
```
StatsPage selects Habit → selects Range (3/6/12m)
  → GetHeatmapDataUseCase(habitId, startDate, endDate) → List<DayStat>
  → GetBarChartDataUseCase(habitId, period, groupBy) → List<PeriodSummary>
```

**Heatmap cell color logic:**
```
if (no log for day)           → Color(#2D3748)  // Black
if (status == skipped)        → Color(#2D3748)  // Black  
if (status == gave_up)        → Color(#F6AD55)  // Yellow
if (status == completed):
  durationMinutes <= 10       → Level 1 red (#FED7D7)
  durationMinutes <= 15       → Level 2 red (#FEB2B2)
  durationMinutes <= 20       → Level 3 red (#FC8181)
  durationMinutes <= 25       → Level 4 red (#F56565)
  durationMinutes <= 30       → Level 5 red (#E53E3E)
  durationMinutes >  30       → Level 6 red (#9B2C2C)
```

**Heatmap layout:**
- Circular dots in a grid: columns = weeks, rows = 7 days (Mon–Sun)
- Show month labels above columns
- On tap: tooltip shows date + duration + status
- Range selector switches query and re-renders

**Bar Chart (fl_chart):**
- X axis: days (daily view), weeks (weekly view), months (monthly view)
- Y axis: completion % (0–100%)
- Bar color: green gradient; red outline if < 50%
- Toggle: day / week / month view tabs above chart

### 6.4 Habit Tree Feature

**Garden Page layout:**
- Horizontal scrollable list of TreeCard widgets
- Each TreeCard shows: tree illustration (current stage), habit name, current streak, stage name
- Tap card → TreeDetailPage (full tree render + progress to next stage)

**TreeDetailPage:**
- Large tree canvas (CustomPainter)
- Stage progress indicator (dots: ● ● ○ ○ ○ ○)
- "X days until next stage" countdown
- Habit mini-stats (streak, completion rate)

---

## 7. RAFAEL AI ENGINE

### 7.1 Architecture (Pure Dart, no Flutter)

```
RafaelEngine
├── PatternAnalyzer.analyze(List<HabitLog>, windowDays) → HabitPattern
└── LevelAdvisor.advise(HabitPattern, Habit) → LevelAdvice
```

### 7.2 Behavioral Psychology Foundations

The engine is grounded in three behavioral science models:

**A. Fogg Behavior Model (B = MAP)**
- Behavior = Motivation × Ability × Prompt
- Low completion % → Ability is too low → Reduce duration (level down)
- High completion % consistently → Ability is adequate → Increase duration (level up)

**B. Goldilocks Principle (Flow State)**
- Challenge must be just above current skill level — not too easy, not too hard
- Target zone: 75–90% completion rate triggers the "flow sweet spot"
- Below 50% = frustration zone → level down
- Above 95% consistently = boredom zone → level up candidate

**C. Loss Aversion & Streak Protection**
- Never auto-level-up if it would predictably break a streak
- Copilot mode shows streak-at-risk warning when suggesting level up
- Level-down is always safe to suggest (preserves streak)

### 7.3 PatternAnalyzer

Computes over a rolling window (default 7 days, minimum 5 logs required):

```
OUTPUTS:
- completionRate         = completed_days / total_logged_days
- giveUpRate             = gave_up_days / total_logged_days  
- avgCompletionPct       = mean(completionPercentage) over window
- consecutiveCompletions = streak from today backwards (completed only)
- consecutiveGiveUps     = consecutive give_ups from today backwards
- trend                  = improving | declining | stable
  (compare first-half avg vs second-half avg completion pct)
```

**Insufficient data guard:** If < 5 logs in window → advice = maintain, confidence = 0.0

### 7.4 LevelAdvisor — Rule Set

#### LEVEL UP Rules (all must be true)
| Rule | Threshold | Rationale |
|------|-----------|-----------|
| R1: Minimum streak | currentStreak >= 7 days | One full week of consistency |
| R2: Completion rate | completionRate >= 0.90 (90%) | 9/10 days completed |
| R3: No recent give-up | consecutiveGiveUps == 0, no give_up in last 5 days | Stability confirmed |
| R4: Average completion | avgCompletionPct >= 88% | High-quality completions |
| R5: Not at max | currentDuration < maxDuration | Room to grow |
| R6: Trend | trend == improving OR stable | Not declining |

#### LEVEL DOWN Rules (any ONE is sufficient)
| Rule | Threshold | Rationale |
|------|-----------|-----------|
| D1: High give-up rate | giveUpRate >= 0.40 (40%) | Frustration signal |
| D2: Low average completion | avgCompletionPct < 50% over 5 days | Ability mismatch |
| D3: Consecutive give-ups | consecutiveGiveUps >= 3 | Acute struggle |
| D4: Not at minimum | currentDuration > minimumDuration (10 min) | Can still go lower |

#### MAINTAIN (default)
- Returns if neither level-up nor level-down conditions are met
- Also returns if currentDuration is already at minimum and D rules fire → suggest "maintain at min, check motivation"

### 7.5 Confidence Scoring

```
confidence = 1.0
  - 0.2 if window < 7 days (fewer data points)
  - 0.1 if trend is 'stable' (less signal)
  + 0.1 if consecutiveCompletions >= 14 (strong signal for level up)
  - 0.15 if only 1 D-rule fires (borderline level down)
  Clamped to [0.0, 1.0]
```

### 7.6 Mode Behaviors

#### None Mode
- Engine never runs. No suggestions. User manages manually.

#### Copilot Mode (suggest, user decides)
- Engine analyzes after each HabitLog is saved
- If advice != maintain AND confidence >= 0.6:
  → Show `CopilotBottomSheet` with:
     - Advice headline ("Rafael suggests leveling up! 📈")
     - Reasoning text (from LevelAdvice.reasoning)
     - Current → Suggested duration
     - Accept button (applies change) + Dismiss button
- If advice fires but confidence < 0.6: show subtle AI insight card on HabitCard only

#### Autopilot Mode (auto-apply)
- Engine analyzes after each HabitLog is saved
- If advice != maintain AND confidence >= 0.7:
  → Auto-update habit duration via UpdateHabitUseCase
  → Show AutopilotSnackbar: "🌿 Rafael adjusted Reading to 15 min/day" with Undo action
- Undo window: 5 seconds (snackbar duration), then change is permanent

### 7.7 Analysis Trigger Points

Engine runs at these moments only (battery-friendly):
1. After `FinishTimerUseCase` completes (most important)
2. After `GiveUpTimerUseCase` completes
3. On app open if last analysis was > 1 day ago (catch skipped days)

---

## 8. HABIT TREE ALGORITHM

### 8.1 Stage Thresholds

Based on Phillippa Lally's habit formation research (2010, UCL) — habits form between 18–254 days (median 66 days):

| Stage | Name (VI) | Total Completed Days | Visual Description |
|-------|-----------|----------------------|--------------------|
| 0 | Hạt (Seed) | 0 days | Single seed in soil, no sprout |
| 1 | Mầm (Sprout) | 3 days | Tiny green shoot emerging |
| 2 | Cây con (Sapling) | 7 days | Small plant with 2-3 leaves |
| 3 | Cây (Young Tree) | 21 days | Recognizable tree with trunk |
| 4 | Cây to (Big Tree) | 42 days | Full canopy, strong trunk |
| 5 | Cây cổ thụ (Ancient Tree) | 66 days | Massive, gnarled, majestic |

**Rationale for milestones:**
- 3 days: Psychological commitment threshold (first visible progress)
- 7 days: One-week milestone (well-established in habit literature)
- 21 days: Popular "21-day rule" cultural milestone (Maltz 1960)
- 42 days: Half of Lally's median — midpoint reward
- 66 days: Lally's median habit formation threshold — "True habit" achieved

### 8.2 Stage Progression Logic

```
UpdateTreeStageUseCase:
  1. Fetch habit.totalCompletedDays
  2. Compute newStage = stageFor(totalCompletedDays):
       days < 3   → stage 0
       days < 7   → stage 1
       days < 21  → stage 2
       days < 42  → stage 3
       days < 66  → stage 4
       days >= 66 → stage 5
  3. If newStage != tree.currentStage:
       → Update tree in DB
       → Emit StageAdvanced event → trigger celebration animation
```

**Streak break behavior:** Stage does NOT go backward. Total completed days is cumulative (streak resets, but days don't uncollect). This prevents frustration from a single missed day destroying visual progress.

### 8.3 Tree Types Available

| ID | Name | Visual Character |
|----|------|-----------------|
| oak | Cây Sồi | Broad, classic tree form |
| pine | Cây Thông | Triangular conifer |
| cherry | Hoa Anh Đào | Pink-tinted blossom tree |
| bamboo | Tre | Vertical segments, clusters |
| bonsai | Bonsai | Miniature, artistic form |

Each tree type has 6 SVG assets (stage_0 through stage_5) + CustomPainter fallback.

### 8.4 Tree Canvas Rendering

`TreeCanvas` (CustomPainter):
- Background: subtle soil/grass strip at bottom
- Tree: draws from SVG asset OR procedural (fallback)
- Ambient animation: gentle leaf sway (sin wave on canvas transform)
- Stage-up animation: particle burst + scale-up effect (on StageAdvanced event)
- Season theming: optional (future feature)

---

## 9. NAVIGATION MAP (GoRouter)

```
/                           → HomePage (HabitList + Drawer)
  /habit/create             → CreateHabitPage
  /habit/:habitId/edit      → EditHabitPage
  /habit/:habitId/timer     → TimerPage
  /habit/:habitId/stats     → StatsPage
  /habit/:habitId/tree      → TreeDetailPage
  /habit-tree               → HabitTreePage (Garden — all trees)
  /stats                    → StatsPage (no habit pre-selected)
  /settings                 → SettingsPage
  /settings/habit/:habitId  → HabitSettingsPage
  /introduction             → IntroductionPage
  /about                    → AboutPage
```

**Drawer items → routes:**
```
Habit (Home)       → /
Introduction       → /introduction
Habit Tree         → /habit-tree
Stats              → /stats
Settings           → /settings
About              → /about
```

**Deep link from notification (future):**
```
kaizen://habit/:habitId/timer   → Direct to timer
```

---

## 10. BLOC EVENT-STATE CONTRACTS

### HabitListBloc
```
EVENTS:
  LoadHabits
  DeleteHabit(habitId)
  ArchiveHabit(habitId)
  ReorderHabits(List<Habit>)
  LevelUpHabit(habitId)               // manual mode
  LevelDownHabit(habitId)             // manual mode

STATES:
  HabitListInitial
  HabitListLoading
  HabitListLoaded(habits: List<Habit>)
  HabitListError(message: String)
```

### HabitFormBloc
```
EVENTS:
  LoadHabitForEdit(habitId)
  NameChanged(value)
  DescriptionChanged(value)
  IconChanged(iconCode)
  DurationChanged(minutes)
  MaxDurationChanged(minutes)
  IncrementChanged(minutes)
  TreeTypeChanged(treeType)
  LevelUpModeChanged(mode)
  SubmitForm

STATES:
  HabitFormInitial
  HabitFormLoading
  HabitFormReady(habit: Habit?, isValid: bool)
  HabitFormSubmitting
  HabitFormSuccess
  HabitFormError(message: String)
```

### TimerBloc
```
EVENTS:
  TimerStarted(habitId, targetSeconds)
  TimerPaused
  TimerResumed
  TimerGaveUp
  TimerTicked(remainingSeconds)   // from Stream<int>
  TimerFinished                   // emitted internally

STATES:
  TimerInitial
  TimerRunning(remaining: int, progress: double)
  TimerPaused(remaining: int, progress: double)
  TimerGaveUp(completionPct: double)
  TimerFinished(actualSeconds: int)
```

### StatsBloc
```
EVENTS:
  LoadStats(habitId, range: StatsRange)
  ChangeRange(range: StatsRange)
  ChangeHabit(habitId)
  ChangeChartView(view: ChartView)   // daily|weekly|monthly

STATES:
  StatsInitial
  StatsLoading
  StatsLoaded(heatmap: List<DayStat>, chart: List<PeriodSummary>, selectedHabit: Habit)
  StatsError(message: String)
```

### RafaelBloc
```
EVENTS:
  AnalyzeHabit(habitId)
  AcceptAdvice(advice: LevelAdvice)
  DismissAdvice(habitId)
  UndoAutoApply(habitId, previousDuration)

STATES:
  RafaelIdle
  RafaelAnalyzing(habitId)
  RafaelHasAdvice(advice: LevelAdvice, mode: AiMode)   // copilot: show sheet
  RafaelApplied(habitId, newDuration)                  // autopilot: show snackbar
  RafaelMaintain(habitId)
  RafaelError(message: String)
```

### TreeBloc
```
EVENTS:
  LoadTrees
  LoadTreeForHabit(habitId)
  AssignTreeToHabit(habitId, treeType)
  UpdateTreeAfterSession(habitId)    // called after timer finishes

STATES:
  TreeInitial
  TreeLoading
  TreesLoaded(trees: List<HabitTree>)
  TreeLoaded(tree: HabitTree, habit: Habit)
  TreeStageAdvanced(tree: HabitTree, previousStage: int)  // triggers celebration
  TreeError(message: String)
```

### SettingsBloc
```
EVENTS:
  LoadSettings
  ToggleTheme
  ChangeAiMode(mode: AiMode)
  MarkOnboardingDone

STATES:
  SettingsInitial
  SettingsLoaded(settings: AppSettings)
  SettingsUpdated(settings: AppSettings)
```

---

## 11. SPRINT IMPLEMENTATION PLAN

> **Convention:** Each sprint = ~1 week. Sprints are ordered by dependency. Claude Code should implement one sprint fully before moving to the next.

---

### 🏗 SPRINT 1 — Foundation & Infrastructure
**Goal:** Compilable app with routing, DB, and design system ready

**Tasks:**
1. Initialize Flutter project with Feature-First folder structure
2. Configure `pubspec.yaml` with all dependencies
3. Set up `build_runner` code generation pipeline
4. Implement Drift database schema (3 tables, all DAOs, relationships)
5. Configure `get_it` + `injectable` DI container
6. Set up GoRouter with all routes (placeholder pages)
7. Implement `app_colors.dart`, `app_text_styles.dart`, `app_dimensions.dart`
8. Implement `neumorphic_styles.dart` (BoxDecoration factories for raised/inset)
9. Build shared widgets: `NeumorphicCard`, `NeumorphicButton`, `NeumorphicContainer`, `NeumorphicToggle`
10. Implement `AppTheme` (light + dark `ThemeData`)

**Deliverable:** App launches, shows placeholder home, routing works, DB initializes without error.

---

### 🌱 SPRINT 2 — Habit Management (CRUD)
**Goal:** Full habit lifecycle — create, list, edit, delete, archive

**Tasks:**
1. Implement `Habit` + `HabitLog` domain entities (freezed)
2. Implement `HabitRepository` interface + `HabitRepositoryImpl`
3. Implement all Habit usecases (CRUD + level up/down + archive)
4. Implement `HabitListBloc` + `HabitFormBloc`
5. Build `HomePage` with horizontal/vertical `HabitListView`
6. Build `HabitCard` widget (neumorphic, streak badge, icon, duration display)
7. Build `CreateHabitPage` + `EditHabitPage` (form with icon/color/duration pickers)
8. Implement swipe-to-delete + swipe-to-archive on HabitCard
9. Build `AppDrawer` with all navigation items + theme/AI toggles
10. Implement Level Up / Level Down buttons on HabitCard (manual mode)
11. Empty state widget for first launch

**Deliverable:** User can create/edit/delete habits, see them listed with streaks.

---

### ⏳ SPRINT 3 — Timer
**Goal:** Functional timer with background support and all 5 states

**Tasks:**
1. Implement `TimerSession` entity + `TimerStatus` enum
2. Implement `TimerService` (flutter_foreground_task setup for Android + iOS)
3. Implement timer persistence in SharedPreferences (recovery on app kill)
4. Implement `TimerBloc` with all 5 states and tick stream
5. Build `TimerPage` layout (hourglass center, progress bar, controls)
6. Build `HourglassAnimation` (CustomPainter — sand flow effect)
7. Build `TimerProgressBar` (neumorphic inset, green fill)
8. Build `CountdownDisplay` (large monospace font)
9. Build `TimerActionButtons` (4 buttons: TapToStart / Pause / Resume / GiveUp)
10. On `TimerFinished`: create `HabitLog` (completed) → update streak → trigger RafaelBloc.AnalyzeHabit + TreeBloc.UpdateTreeAfterSession
11. On `TimerGaveUp`: create `HabitLog` (gave_up, with completionPct) → trigger analysis
12. Test background timer: minimize app mid-session, verify notification shows, reopen app restores state

**Deliverable:** Timer runs in background, all states work, logs are saved on session end.

---

### 📊 SPRINT 4 — Statistics
**Goal:** Heatmap calendar + bar chart, per-habit and range-selectable

**Tasks:**
1. Implement `DayStat` + `PeriodSummary` entities
2. Implement `StatsRepository` + `StatsRepositoryImpl` (Drift queries with date ranges)
3. Implement `GetHeatmapDataUseCase` + `GetBarChartDataUseCase`
4. Implement `StatsBloc`
5. Build `StatsPage` with habit selector + range tabs at top
6. Build `HabitSelectorBar` (scrollable chip row to pick which habit's stats to view)
7. Build `RangeSelectorWidget` (3M / 6M / 12M segmented control)
8. Build `HeatmapCalendar` (CustomPainter):
   - Grid of circles: columns = weeks, rows = 7 (Mon–Sun)
   - Color mapping (6 red shades + yellow + black per spec)
   - Tap-to-tooltip (date, duration, status)
   - Month labels above columns
9. Build `HeatmapLegend` (color swatch row with labels)
10. Build `CompletionBarChart` (fl_chart BarChart, daily/weekly/monthly toggle)
11. Wire range change → re-query → rebuild both widgets

**Deliverable:** Stats page shows accurate heatmap + bar chart with correct colors per log data.

---

### 🤖 SPRINT 5 — Rafael AI Engine
**Goal:** Full Copilot and Autopilot AI behavior

**Tasks:**
1. Implement `HabitPattern` + `LevelAdvice` entities
2. Implement `PatternAnalyzer.analyze()` (all metrics: completionRate, giveUpRate, etc.)
3. Implement `LevelAdvisor.advise()` (all R1-R6 + D1-D4 rules + confidence scoring)
4. Implement `RafaelEngine` orchestrator
5. Write unit tests for PatternAnalyzer and LevelAdvisor (cover edge cases: insufficient data, at-min duration, at-max duration)
6. Implement `AnalyzeAndAdviseUseCase` + `AutoApplyAdviceUseCase`
7. Implement `RafaelBloc`
8. Build `CopilotBottomSheet` (advice headline, reasoning, current→suggested duration, Accept/Dismiss)
9. Build `AutopilotSnackbar` with Undo action (5s window)
10. Build `AiInsightCard` (subtle indicator on HabitCard for pending copilot advice)
11. Wire analysis trigger: after FinishTimer + after GiveUpTimer + on app open (if stale)
12. Add AI mode toggle to Drawer (None / Copilot / Autopilot)
13. Per-habit level_up_mode override in HabitSettings

**Deliverable:** AI correctly identifies level-up/down patterns, Copilot shows bottom sheet, Autopilot auto-adjusts with undo.

---

### 🌳 SPRINT 6 — Habit Tree
**Goal:** Visual tree growth tied to habit completion streaks

**Tasks:**
1. Implement `HabitTree` entity + `TreeType` enum
2. Implement `HabitTreeRepository` + impl
3. Implement Tree usecases (get, assign, update stage)
4. Implement `TreeBloc`
5. Set up tree assets: SVG files for 5 tree types × 6 stages = 30 assets (or use CustomPainter procedural drawing)
6. Build `TreeCanvas` (CustomPainter — renders current stage, ambient sway animation)
7. Build `HabitTreePage` (Garden view — horizontal scroll of TreeCards)
8. Build `TreeCard` (neumorphic card: mini tree + habit name + stage name + days-to-next-stage)
9. Build `TreeDetailPage` (full canvas + stage progress dots + habit mini-stats)
10. Build `TreeTypeSelectorWidget` (scrollable selector on CreateHabit / HabitSettings)
11. Build `StageAdvanced` celebration animation (particle burst on TreeCanvas)
12. Auto-create HabitTree when new Habit is created (with default treeType)
13. Wire `UpdateTreeAfterSession` → called from TimerBloc on finish
14. Show "🌳 Your Oak grew to Stage 3!" banner when stage advances

**Deliverable:** Each habit has a tree that visually grows through 6 stages as days accumulate.

---

### ✨ SPRINT 7 — Polish, Edge Cases & Settings
**Goal:** Production-ready UX, full settings, all edge cases handled

**Tasks:**

**Settings:**
1. Build `SettingsPage` (global: theme, AI mode, default max duration, default increment)
2. Build `HabitSettingsPage` (per-habit: max duration, increment, level_up_mode, tree type change)
3. Build `IntroductionPage` (Kaizen philosophy explanation, app walkthrough)
4. Build `AboutPage` (version, credits, links)

**Edge Cases:**
5. First launch: show IntroductionPage, create sample habit
6. Habit with no logs: heatmap shows all-black dots, AI returns maintain
7. All habits archived: empty state with "Create your first habit" CTA
8. Timer recovery: app killed mid-session → on reopen, ask "Resume your Reading session?" dialog
9. Streak reset on missed day: computed lazily on app open (check yesterday's log on each habit)
10. Level at max: disable Level Up button/advice, show "Max level reached 🏆"
11. Level at min: disable Level Down, AI advice changes to "Consider different strategy"

**Polish:**
12. Page transition animations (slide in/out, fade)
13. HabitCard entrance animation (staggered list animation)
14. Streak milestone celebration (at 7, 21, 42, 66 days: special overlay)
15. Dark mode audit: ensure all neumorphic shadows work in dark theme
16. Handle Android back navigation correctly with GoRouter
17. Performance: Drift queries with proper indexes on habit_id + log_date

**Deliverable:** App is stable, handles all edge cases, settings work end-to-end.

---

### 🧪 SPRINT 8 (Future) — Testing & Notifications
**Goal:** Test coverage + push notifications for reminders

**Tasks (future scope):**
1. Unit tests: Rafael engine (comprehensive rule coverage)
2. Widget tests: HabitCard, HeatmapCalendar, TimerPage states
3. Integration tests: Full timer → log → stats flow
4. Add `flutter_local_notifications`
5. Per-habit reminder time picker in HabitSettings
6. Schedule daily notification per habit
7. Notification tap → deep link to timer

---

## 12. KEY TECHNICAL DECISIONS & RISKS

### Decision Rationale

| Decision | Alternative Considered | Why Chosen |
|----------|------------------------|------------|
| Drift over Hive | Hive (NoSQL) | Type-safe SQL queries needed for stats aggregation (date ranges, group-by) |
| CustomPainter for heatmap | `heatmap_calendar` package | Full control over circular dots, 6-shade color mapping, tap interactions |
| flutter_foreground_task | `workmanager` | Provides both Foreground Service + background handlers; simpler API |
| Freezed for entities | Manual Equatable | copyWith, pattern matching, and equality in one codegen step |
| Feature-First over Layer-First | Layer-first (all blocs together) | Better scalability; each feature is independently testable and removable |

### Risks & Mitigations

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| CustomPainter hourglass performance | Medium | Use `RepaintBoundary`; only repaint on tick, not every frame |
| iOS background timer killed by OS | High | Save timestamp to SharedPrefs on every pause; reconstruct elapsed on resume |
| Drift migration (schema changes) | Medium | Write migration scripts from Sprint 1; version DB from day 1 |
| Rafael AI false positives (wrong level change) | Medium | Require confidence >= 0.6/0.7 threshold; always provide Undo; unit test all rules |
| 30 tree SVG assets (size) | Low | Use CustomPainter procedural trees as fallback; SVGs are small (<10KB each) |
| Dark mode neumorphism legibility | Medium | Use dedicated shadow colors for dark theme (invert light/dark shadow swap) |

### Constants to Configure (app_constants.dart + duration_constants.dart)

```
DEFAULT_HABIT_DURATION_MINUTES = 10
DEFAULT_INCREMENT_MINUTES      = 5
DEFAULT_MAX_DURATION_MINUTES   = 120
MINIMUM_DURATION_MINUTES       = 10
ANALYSIS_WINDOW_DAYS           = 7
ANALYSIS_MIN_LOGS_REQUIRED     = 5
COPILOT_CONFIDENCE_THRESHOLD   = 0.60
AUTOPILOT_CONFIDENCE_THRESHOLD = 0.70
UNDO_SNACKBAR_DURATION_SECONDS = 5
TREE_STAGE_THRESHOLDS          = [0, 3, 7, 21, 42, 66]  // days per stage
HEATMAP_RED_DURATION_LEVELS    = [10, 15, 20, 25, 30]   // minutes per color level
```

---

*Architecture designed by AI Tech Lead — Kaizen AI v1.0*
*"Every day, a little better. 🌱"*
