#!/usr/bin/env bash

# Automatic repository grader.
# This file is independent: it grades the repository where it is executed.
# It does not need a custom README, config file, or manual input.
# Usage:
#   bash exercise2.sh
#   bash exercise2.sh /path/to/repository

set -u

MAX_TOTAL=100
REPORT_DIR="grading_reports"
REPO_PATH="${1:-.}"

line() {
    printf '%*s\n' 70 '' | tr ' ' '='
}

add_numbers() {
    awk 'BEGIN {
        total = 0
        for (i = 1; i < ARGC; i++) total += ARGV[i]
        printf "%.2f", total
    }' "$@"
}

cap_score() {
    local value="$1"
    local max="$2"

    awk -v value="$value" -v max="$max" 'BEGIN {
        if (value < 0) value = 0
        if (value > max) value = max
        printf "%.2f", value
    }'
}

score_by_goal() {
    local value="$1"
    local goal="$2"
    local max="$3"

    awk -v value="$value" -v goal="$goal" -v max="$max" 'BEGIN {
        if (goal <= 0) {
            printf "0.00"
        } else {
            score = (value / goal) * max
            if (score > max) score = max
            if (score < 0) score = 0
            printf "%.2f", score
        }
    }'
}

get_level() {
    local grade="$1"
    awk -v grade="$grade" 'BEGIN {
        if (grade >= 90) print "Excelente"
        else if (grade >= 80) print "Muy bueno"
        else if (grade >= 70) print "Aceptable"
        else if (grade >= 60) print "Basico"
        else print "Insuficiente"
    }'
}

print_item() {
    local label="$1"
    local value="$2"
    local max="$3"
    printf '%-42s %7s / %s\n' "$label:" "$value" "$max"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

normalize_repo_path() {
    local path="$1"

    if [[ ! -d "$path" ]]; then
        echo "ERROR: La ruta no existe: $path" >&2
        exit 1
    fi

    cd "$path" 2>/dev/null || {
        echo "ERROR: No se pudo entrar a la ruta: $path" >&2
        exit 1
    }

    pwd
}

is_git_repo() {
    command_exists git && git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

safe_count_find() {
    find . \
        -path './.git' -prune -o \
        -path './node_modules' -prune -o \
        -path './vendor' -prune -o \
        -path './dist' -prune -o \
        -path './build' -prune -o \
        -path './coverage' -prune -o \
        -path './.venv' -prune -o \
        -path './venv' -prune -o \
        -path './__pycache__' -prune -o \
        "$@" 2>/dev/null
}

count_files_by_extensions() {
    safe_count_find -type f \( \
        -name '*.sh' -o -name '*.py' -o -name '*.js' -o -name '*.ts' -o \
        -name '*.jsx' -o -name '*.tsx' -o -name '*.java' -o -name '*.c' -o \
        -name '*.cpp' -o -name '*.cs' -o -name '*.go' -o -name '*.rs' -o \
        -name '*.php' -o -name '*.rb' -o -name '*.html' -o -name '*.css' -o \
        -name '*.sql' \
    \) -print | wc -l | tr -d ' '
}

count_all_project_files() {
    safe_count_find -type f -print | wc -l | tr -d ' '
}

count_dirs() {
    safe_count_find -type d -print | wc -l | tr -d ' '
}

count_lines_of_code() {
    local total=0
    local file

    while IFS= read -r -d '' file; do
        local lines
        lines="$(sed '/^[[:space:]]*$/d' "$file" 2>/dev/null | wc -l | tr -d ' ')"
        total=$((total + lines))
    done < <(safe_count_find -type f \( \
        -name '*.sh' -o -name '*.py' -o -name '*.js' -o -name '*.ts' -o \
        -name '*.jsx' -o -name '*.tsx' -o -name '*.java' -o -name '*.c' -o \
        -name '*.cpp' -o -name '*.cs' -o -name '*.go' -o -name '*.rs' -o \
        -name '*.php' -o -name '*.rb' -o -name '*.html' -o -name '*.css' -o \
        -name '*.sql' \
    \) -print0)

    echo "$total"
}

count_large_files() {
    safe_count_find -type f -size +300k -print | wc -l | tr -d ' '
}

count_empty_files() {
    safe_count_find -type f -size 0 -print | wc -l | tr -d ' '
}

count_todos() {
    local total=0
    local file

    while IFS= read -r -d '' file; do
        local matches
        matches="$(grep -Ein 'TODO|FIXME|HACK|console\.log|print_r|var_dump' "$file" 2>/dev/null | wc -l | tr -d ' ')"
        total=$((total + matches))
    done < <(safe_count_find -type f \( \
        -name '*.sh' -o -name '*.py' -o -name '*.js' -o -name '*.ts' -o \
        -name '*.jsx' -o -name '*.tsx' -o -name '*.java' -o -name '*.c' -o \
        -name '*.cpp' -o -name '*.cs' -o -name '*.go' -o -name '*.rs' -o \
        -name '*.php' -o -name '*.rb' -o -name '*.html' -o -name '*.css' \
    \) -print0)

    echo "$total"
}

has_any_file() {
    local pattern="$1"
    safe_count_find -type f -iname "$pattern" -print -quit | grep -q .
}

has_any_path_name() {
    local pattern="$1"
    safe_count_find -iname "$pattern" -print -quit | grep -q .
}

readme_file() {
    find . -maxdepth 2 \
        -path './.git' -prune -o \
        -type f -iname 'README*' -print -quit 2>/dev/null
}

count_documentation_files() {
    safe_count_find -type f \( \
        -iname '*.md' -o -iname '*.txt' -o -iname '*.rst' -o -iname '*.adoc' \
    \) -print | wc -l | tr -d ' '
}

count_code_comments() {
    local total=0
    local file

    while IFS= read -r -d '' file; do
        local matches
        matches="$(grep -E '^[[:space:]]*(#|//|/\*|\*|<!--)' "$file" 2>/dev/null | wc -l | tr -d ' ')"
        total=$((total + matches))
    done < <(safe_count_find -type f \( \
        -name '*.sh' -o -name '*.py' -o -name '*.js' -o -name '*.ts' -o \
        -name '*.jsx' -o -name '*.tsx' -o -name '*.java' -o -name '*.c' -o \
        -name '*.cpp' -o -name '*.cs' -o -name '*.go' -o -name '*.rs' -o \
        -name '*.php' -o -name '*.rb' -o -name '*.html' -o -name '*.css' \
    \) -print0)

    echo "$total"
}

detect_test_files_count() {
    safe_count_find -type f \( \
        -iname '*test*' -o -iname '*spec*' -o -path './tests/*' -o -path './test/*' \
    \) -print | wc -l | tr -d ' '
}

detect_config_files_count() {
    local count=0
    local files=(
        "package.json" "requirements.txt" "pyproject.toml" "Pipfile"
        "pom.xml" "build.gradle" "Cargo.toml" "go.mod" "composer.json"
        "Gemfile" "Makefile" "Dockerfile" "docker-compose.yml"
        ".gitignore" ".env.example"
    )

    for file in "${files[@]}"; do
        if [[ -f "$file" ]]; then
            count=$((count + 1))
        fi
    done

    echo "$count"
}

message_is_good() {
    local message
    message="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"

    case "$message" in
        update|updates|commit|changes|cambios|final|fix|arreglo|asd|test|.)
            return 1
            ;;
    esac

    [[ ${#message} -ge 12 ]]
}

grade_commits() {
    G_TOTAL_COMMITS=0
    G_GOOD_MESSAGES=0
    G_ACTIVE_DAYS=0
    G_AVG_FILES_PER_COMMIT=0
    G_SCORE_COMMITS=0
    G_WARN_COMMITS=""

    if ! is_git_repo; then
        G_WARN_COMMITS="No se detecto repositorio Git. La parte de commits queda en 0."
        G_SCORE_COMMITS="0.00"
        return
    fi

    local log_data
    log_data="$(git log --date=short --pretty=format:'%H|%ad|%s' 2>/dev/null || true)"

    if [[ -z "$log_data" ]]; then
        G_WARN_COMMITS="El repositorio no tiene commits."
        G_SCORE_COMMITS="0.00"
        return
    fi

    local active_days_tmp
    active_days_tmp="$(mktemp)"
    local total_files_changed=0

    while IFS='|' read -r sha commit_date message; do
        [[ -z "${sha:-}" ]] && continue

        G_TOTAL_COMMITS=$((G_TOTAL_COMMITS + 1))
        echo "$commit_date" >> "$active_days_tmp"

        if message_is_good "$message"; then
            G_GOOD_MESSAGES=$((G_GOOD_MESSAGES + 1))
        fi

        local changed_files
        changed_files="$(git show --name-only --format='' "$sha" 2>/dev/null | sed '/^[[:space:]]*$/d' | wc -l | tr -d ' ')"
        total_files_changed=$((total_files_changed + changed_files))
    done <<< "$log_data"

    G_ACTIVE_DAYS="$(sort -u "$active_days_tmp" | wc -l | tr -d ' ')"
    rm -f "$active_days_tmp"

    local good_message_percent
    good_message_percent="$(awk -v good="$G_GOOD_MESSAGES" -v total="$G_TOTAL_COMMITS" 'BEGIN {
        if (total == 0) print "0.00"; else printf "%.2f", (good / total) * 100
    }')"

    G_AVG_FILES_PER_COMMIT="$(awk -v files="$total_files_changed" -v total="$G_TOTAL_COMMITS" 'BEGIN {
        if (total == 0) print "0.00"; else printf "%.2f", files / total
    }')"

    local score_quantity
    local score_messages
    local score_active_days
    local score_commit_size
    local score_clean_worktree

    score_quantity="$(score_by_goal "$G_TOTAL_COMMITS" 10 8)"
    score_messages="$(score_by_goal "$good_message_percent" 80 5)"
    score_active_days="$(score_by_goal "$G_ACTIVE_DAYS" 4 5)"
    score_commit_size="$(awk -v avg="$G_AVG_FILES_PER_COMMIT" 'BEGIN {
        if (avg == 0) print "0.00"
        else if (avg <= 6) print "4.00"
        else if (avg <= 12) print "2.50"
        else print "1.00"
    }')"

    if [[ -z "$(git status --porcelain 2>/dev/null)" ]]; then
        score_clean_worktree="3.00"
    else
        score_clean_worktree="1.50"
        G_WARN_COMMITS="${G_WARN_COMMITS} Hay cambios sin commit."
    fi

    G_SCORE_COMMITS="$(add_numbers "$score_quantity" "$score_messages" "$score_active_days" "$score_commit_size" "$score_clean_worktree")"
    G_SCORE_COMMITS="$(cap_score "$G_SCORE_COMMITS" 25)"

    if (( G_TOTAL_COMMITS < 3 )); then
        G_WARN_COMMITS="${G_WARN_COMMITS} Pocos commits para evidenciar proceso."
    fi
}

grade_activity() {
    G_SCORE_ACTIVITY=0
    G_PROJECT_SPAN_DAYS=0
    G_LAST_DAY_PERCENT=0
    G_WARN_ACTIVITY=""

    if ! is_git_repo || (( G_TOTAL_COMMITS == 0 )); then
        G_SCORE_ACTIVITY="0.00"
        G_WARN_ACTIVITY="No hay historial Git suficiente para medir tiempo y constancia."
        return
    fi

    local first_day
    local last_day
    first_day="$(git log --reverse --date=short --pretty=format:'%ad' 2>/dev/null | head -n 1)"
    last_day="$(git log --date=short --pretty=format:'%ad' 2>/dev/null | head -n 1)"

    if command_exists date && date -d "$first_day" '+%s' >/dev/null 2>&1; then
        local first_seconds
        local last_seconds
        first_seconds="$(date -d "$first_day" '+%s')"
        last_seconds="$(date -d "$last_day" '+%s')"
        G_PROJECT_SPAN_DAYS=$(( (last_seconds - first_seconds) / 86400 + 1 ))
    else
        G_PROJECT_SPAN_DAYS="$G_ACTIVE_DAYS"
    fi

    local commits_last_day
    commits_last_day="$(git log --since="$last_day 00:00:00" --until="$last_day 23:59:59" --pretty=format:'%H' 2>/dev/null | wc -l | tr -d ' ')"
    G_LAST_DAY_PERCENT="$(awk -v last="$commits_last_day" -v total="$G_TOTAL_COMMITS" 'BEGIN {
        if (total == 0) print "0.00"; else printf "%.2f", (last / total) * 100
    }')"

    local score_span
    local score_active
    local score_not_last_day
    local score_consistency

    score_span="$(score_by_goal "$G_PROJECT_SPAN_DAYS" 7 4)"
    score_active="$(score_by_goal "$G_ACTIVE_DAYS" 5 5)"
    score_not_last_day="$(awk -v percent="$G_LAST_DAY_PERCENT" 'BEGIN {
        if (percent <= 35) print "4.00"
        else if (percent <= 60) print "2.50"
        else print "1.00"
    }')"
    score_consistency="$(awk -v active="$G_ACTIVE_DAYS" -v span="$G_PROJECT_SPAN_DAYS" 'BEGIN {
        if (span <= 0) print "0.00"
        else {
            ratio = active / span
            if (ratio >= 0.45) print "2.00"
            else if (ratio >= 0.25) print "1.20"
            else print "0.50"
        }
    }')"

    G_SCORE_ACTIVITY="$(add_numbers "$score_span" "$score_active" "$score_not_last_day" "$score_consistency")"
    G_SCORE_ACTIVITY="$(cap_score "$G_SCORE_ACTIVITY" 15)"

    if awk -v percent="$G_LAST_DAY_PERCENT" 'BEGIN { exit !(percent > 60) }'; then
        G_WARN_ACTIVITY="Muchos commits estan concentrados en el ultimo dia."
    fi
}

grade_documentation() {
    G_SCORE_DOCS=0
    G_README_LINES=0
    G_WARN_DOCS=""

    local readme
    readme="$(readme_file || true)"
    local doc_files
    local comment_lines
    doc_files="$(count_documentation_files)"
    comment_lines="$(count_code_comments)"

    if [[ -z "$readme" ]]; then
        local score_docs
        local score_comments
        score_docs="$(score_by_goal "$doc_files" 2 4)"
        score_comments="$(score_by_goal "$comment_lines" 20 3)"
        G_SCORE_DOCS="$(add_numbers "$score_docs" "$score_comments")"
        G_SCORE_DOCS="$(cap_score "$G_SCORE_DOCS" 7)"
        G_WARN_DOCS="No se encontro README; se califico documentacion usando otros archivos y comentarios."
        return
    fi

    G_README_LINES="$(wc -l < "$readme" | tr -d ' ')"

    local score_exists="4.00"
    local score_length
    local score_usage
    local score_structure
    local score_examples
    local score_extra_docs

    score_length="$(score_by_goal "$G_README_LINES" 35 3)"
    score_extra_docs="$(score_by_goal "$doc_files" 3 1)"

    if grep -Eiq 'install|instalar|setup|configurar|npm install|pip install|requirements|dependenc' "$readme"; then
        score_usage="2.50"
    else
        score_usage="0.50"
    fi

    if grep -Eiq 'usage|uso|ejecutar|run|comando|bash|python|node|java' "$readme"; then
        score_structure="2.50"
    else
        score_structure="0.50"
    fi

    if grep -Eiq 'ejemplo|example|captura|screenshot|resultado|output|demo|prueba' "$readme"; then
        score_examples="2.00"
    else
        score_examples="0.50"
    fi

    G_SCORE_DOCS="$(add_numbers "$score_exists" "$score_length" "$score_usage" "$score_structure" "$score_examples" "$score_extra_docs")"
    G_SCORE_DOCS="$(cap_score "$G_SCORE_DOCS" 15)"

    if (( G_README_LINES < 15 )); then
        G_WARN_DOCS="El README existe, pero esta muy corto."
    fi
}

grade_tests() {
    G_SCORE_TESTS=0
    G_TEST_FILES=0
    G_WARN_TESTS=""

    G_TEST_FILES="$(detect_test_files_count)"

    local score_files
    local score_scripts="0.00"
    local score_ci="0.00"
    local score_assertions="0.00"

    score_files="$(score_by_goal "$G_TEST_FILES" 4 6)"

    if [[ -f "package.json" ]] && grep -Eiq '"test"[[:space:]]*:' package.json; then
        score_scripts="$(add_numbers "$score_scripts" 3)"
    fi
    if [[ -f "Makefile" ]] && grep -Eiq '(^test:| test)' Makefile; then
        score_scripts="$(cap_score "$(add_numbers "$score_scripts" 2)" 3)"
    fi
    if [[ -f "pyproject.toml" ]] && grep -Eiq 'pytest|unittest|tool.pytest' pyproject.toml; then
        score_scripts="$(cap_score "$(add_numbers "$score_scripts" 2)" 3)"
    fi

    if has_any_path_name ".github"; then
        score_ci="2.00"
    fi

    local assertion_count=0
    local test_file
    while IFS= read -r -d '' test_file; do
        local matches
        matches="$(grep -Ein 'assert|expect|should|describe|it\(|test\(' "$test_file" 2>/dev/null | wc -l | tr -d ' ')"
        assertion_count=$((assertion_count + matches))
    done < <(safe_count_find -type f \( -iname '*test*' -o -iname '*spec*' -o -path './tests/*' \) -print0)
    score_assertions="$(score_by_goal "$assertion_count" 10 4)"

    G_SCORE_TESTS="$(add_numbers "$score_files" "$score_scripts" "$score_ci" "$score_assertions")"
    G_SCORE_TESTS="$(cap_score "$G_SCORE_TESTS" 15)"

    if (( G_TEST_FILES == 0 )); then
        G_WARN_TESTS="No se encontraron archivos de pruebas."
    fi
}

grade_code_quality() {
    G_SCORE_CODE=0
    G_CODE_FILES="$(count_files_by_extensions)"
    G_TOTAL_FILES="$(count_all_project_files)"
    G_TOTAL_DIRS="$(count_dirs)"
    G_LINES_CODE="$(count_lines_of_code)"
    G_LARGE_FILES="$(count_large_files)"
    G_EMPTY_FILES="$(count_empty_files)"
    G_TODO_COUNT="$(count_todos)"
    G_CONFIG_FILES="$(detect_config_files_count)"
    G_WARN_CODE=""

    local score_size
    local score_structure
    local score_config
    local score_cleanliness
    local score_no_empty

    score_size="$(score_by_goal "$G_LINES_CODE" 250 5)"
    score_structure="$(score_by_goal "$G_TOTAL_DIRS" 5 3)"
    score_config="$(score_by_goal "$G_CONFIG_FILES" 3 3)"

    score_cleanliness="$(awk -v todos="$G_TODO_COUNT" -v large="$G_LARGE_FILES" 'BEGIN {
        score = 3
        if (todos > 5) score -= 1
        if (todos > 15) score -= 1
        if (large > 2) score -= 1
        if (score < 0) score = 0
        printf "%.2f", score
    }')"

    score_no_empty="$(awk -v empty="$G_EMPTY_FILES" 'BEGIN {
        if (empty == 0) print "1.00"
        else if (empty <= 2) print "0.50"
        else print "0.00"
    }')"

    G_SCORE_CODE="$(add_numbers "$score_size" "$score_structure" "$score_config" "$score_cleanliness" "$score_no_empty")"
    G_SCORE_CODE="$(cap_score "$G_SCORE_CODE" 15)"

    if (( G_LINES_CODE < 80 )); then
        G_WARN_CODE="El repositorio tiene pocas lineas de codigo para un trabajo completo."
    fi
    if (( G_TODO_COUNT > 15 )); then
        G_WARN_CODE="${G_WARN_CODE} Hay muchos TODO/FIXME/debug pendientes."
    fi
}

grade_completeness() {
    G_SCORE_COMPLETE=0
    G_WARN_COMPLETE=""

    local score_files
    local score_code_files
    local score_entry
    local score_gitignore
    local score_not_empty

    score_files="$(score_by_goal "$G_TOTAL_FILES" 10 4)"
    score_code_files="$(score_by_goal "$G_CODE_FILES" 5 4)"

    if has_any_file "main.*" || has_any_file "app.*" || has_any_file "index.*" || [[ -f "exercise2.sh" ]]; then
        score_entry="3.00"
    else
        score_entry="1.00"
        G_WARN_COMPLETE="No se detecto un archivo principal claro como main, app, index o exercise2.sh."
    fi

    if [[ -f ".gitignore" ]]; then
        score_gitignore="2.00"
    else
        score_gitignore="0.50"
    fi

    if (( G_TOTAL_FILES > 0 && G_CODE_FILES > 0 )); then
        score_not_empty="2.00"
    else
        score_not_empty="0.00"
    fi

    G_SCORE_COMPLETE="$(add_numbers "$score_files" "$score_code_files" "$score_entry" "$score_gitignore" "$score_not_empty")"
    G_SCORE_COMPLETE="$(cap_score "$G_SCORE_COMPLETE" 15)"
}

save_report() {
    local final_grade="$1"
    local level="$2"

    mkdir -p "$REPORT_DIR"

    local timestamp
    timestamp="$(date '+%Y%m%d_%H%M%S' 2>/dev/null || echo "reporte")"

    REPORT_TXT="$REPORT_DIR/reporte_calificacion_$timestamp.txt"
    REPORT_CSV="$REPORT_DIR/reporte_calificacion_$timestamp.csv"

    {
        echo "REPORTE AUTOMATICO DE CALIFICACION"
        echo "Repositorio: $ABS_REPO_PATH"
        echo "Nota final: $final_grade/$MAX_TOTAL"
        echo "Nivel: $level"
        echo
        echo "Puntajes:"
        echo "- Commits e historial: $G_SCORE_COMMITS/25"
        echo "- Tiempo y constancia: $G_SCORE_ACTIVITY/15"
        echo "- Documentacion: $G_SCORE_DOCS/15"
        echo "- Pruebas: $G_SCORE_TESTS/15"
        echo "- Calidad tecnica: $G_SCORE_CODE/15"
        echo "- Entrega y completitud: $G_SCORE_COMPLETE/15"
        echo
        echo "Metricas:"
        echo "- Commits: $G_TOTAL_COMMITS"
        echo "- Dias activos: $G_ACTIVE_DAYS"
        echo "- Promedio de archivos por commit: $G_AVG_FILES_PER_COMMIT"
        echo "- Porcentaje de commits en ultimo dia: $G_LAST_DAY_PERCENT%"
        echo "- Lineas de codigo: $G_LINES_CODE"
        echo "- Archivos de codigo: $G_CODE_FILES"
        echo "- Archivos de prueba: $G_TEST_FILES"
        echo "- Lineas README: $G_README_LINES"
        echo "- TODO/FIXME/debug detectados: $G_TODO_COUNT"
        echo
        echo "Observaciones:"
        for warning in "$G_WARN_COMMITS" "$G_WARN_ACTIVITY" "$G_WARN_DOCS" "$G_WARN_TESTS" "$G_WARN_CODE" "$G_WARN_COMPLETE"; do
            if [[ -n "${warning// }" ]]; then
                echo "- $warning"
            fi
        done
    } > "$REPORT_TXT"

    {
        echo "Categoria,Puntaje,Maximo"
        echo "Commits e historial,$G_SCORE_COMMITS,25"
        echo "Tiempo y constancia,$G_SCORE_ACTIVITY,15"
        echo "Documentacion,$G_SCORE_DOCS,15"
        echo "Pruebas,$G_SCORE_TESTS,15"
        echo "Calidad tecnica,$G_SCORE_CODE,15"
        echo "Entrega y completitud,$G_SCORE_COMPLETE,15"
        echo "TOTAL,$final_grade,100"
    } > "$REPORT_CSV"
}

main() {
    ABS_REPO_PATH="$(normalize_repo_path "$REPO_PATH")"

    grade_commits
    grade_activity
    grade_documentation
    grade_tests
    grade_code_quality
    grade_completeness

    local final_grade
    local level
    final_grade="$(add_numbers "$G_SCORE_COMMITS" "$G_SCORE_ACTIVITY" "$G_SCORE_DOCS" "$G_SCORE_TESTS" "$G_SCORE_CODE" "$G_SCORE_COMPLETE")"
    final_grade="$(cap_score "$final_grade" "$MAX_TOTAL")"
    level="$(get_level "$final_grade")"

    save_report "$final_grade" "$level"

    line
    echo "CALIFICACION AUTOMATICA DEL REPOSITORIO"
    line
    echo "Repositorio: $ABS_REPO_PATH"
    echo "Nota final: $final_grade/$MAX_TOTAL"
    echo "Nivel: $level"
    echo
    print_item "Commits e historial" "$G_SCORE_COMMITS" "25"
    print_item "Tiempo y constancia" "$G_SCORE_ACTIVITY" "15"
    print_item "Documentacion" "$G_SCORE_DOCS" "15"
    print_item "Pruebas" "$G_SCORE_TESTS" "15"
    print_item "Calidad tecnica" "$G_SCORE_CODE" "15"
    print_item "Entrega y completitud" "$G_SCORE_COMPLETE" "15"
    echo
    echo "Metricas revisadas:"
    echo "- Commits: $G_TOTAL_COMMITS"
    echo "- Dias activos: $G_ACTIVE_DAYS"
    echo "- Lineas de codigo: $G_LINES_CODE"
    echo "- Archivos de codigo: $G_CODE_FILES"
    echo "- Archivos de prueba: $G_TEST_FILES"
    echo "- Lineas en README: $G_README_LINES"
    echo "- TODO/FIXME/debug detectados: $G_TODO_COUNT"
    echo
    echo "Reportes generados:"
    echo "- $REPORT_TXT"
    echo "- $REPORT_CSV"
    echo

    local has_warning=0
    for warning in "$G_WARN_COMMITS" "$G_WARN_ACTIVITY" "$G_WARN_DOCS" "$G_WARN_TESTS" "$G_WARN_CODE" "$G_WARN_COMPLETE"; do
        if [[ -n "${warning// }" ]]; then
            if (( has_warning == 0 )); then
                echo "Observaciones:"
            fi
            has_warning=1
            echo "- $warning"
        fi
    done
}

main "$@"
