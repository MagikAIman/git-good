#/usr/bin/env bash
_dothis_completions()
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  local commands_number=${DOTHIS_COMPLETION_COMMANDS_NUMBER:-50}
  local IFS=$'\n'
  local suggestions=($(compgen -W "$(fc -l -$commands_number | sed 's/\t//')" -- "${COMP_WORDS[1]}"))

  if [ "${#suggestions[@]}" == "1" ]; then
    local number="${suggestions[0]/%\ */}"
    COMPREPLY=("$number")
  else
    for i in "${!suggestions[@]}"; do
      suggestions[$i]="$(printf '%*s' "-$COLUMNS"  "${suggestions[$i]}")"
    done

    COMPREPLY=("${suggestions[@]}")
  fi
}

complete -F _dothis_completions dothis