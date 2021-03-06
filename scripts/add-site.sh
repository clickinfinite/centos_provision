#!/usr/bin/env bash

# Generated by POWSCRIPT (https://github.com/coderofsalvation/powscript)

# Unless you like pain: edit the .pow sourcefiles instead of this file

# powscript general settings
set -e                                # halt on error
set +m                                
SHELL="$(echo $0)"                    # shellname
shopt -s lastpipe                     # flexible while loops (maintain scope)
shopt -s extglob                      # regular expressions
path="$(pwd)"
if [[ "$BASH_SOURCE" == "$0"  ]];then 
  SHELLNAME="$(basename $SHELL)"      # shellname without path
  selfpath="$( dirname "$(readlink -f "$0")" )"
  tmpfile="/tmp/$(basename $0).tmp.$(whoami)"
else
  selfpath="$path"
  tmpfile="/tmp/.dot.tmp.$(whoami)"
fi

# generated by powscript (https://github.com/coderofsalvation/powscript)


empty () 
{ 
    [[ "${#1}" == 0 ]] && return 0 || return 1
}

isset () 
{ 
    [[ ! "${#1}" == 0 ]] && return 0 || return 1
}

values () 
{ 
    echo "$2"
}




PROGRAM_NAME='add-site'


SHELL_NAME=$(basename "$0")

SUCCESS_RESULT=0
FAILURE_RESULT=1
ROOT_UID=0

KEITARO_URL="https://keitarotds.com"

WEBROOT_PATH="/var/www/keitaro"

NGINX_ROOT_PATH="/etc/nginx"
NGINX_VHOSTS_DIR="${NGINX_ROOT_PATH}/conf.d"
NGINX_KEITARO_CONF="${NGINX_VHOSTS_DIR}/vhosts.conf"

SCRIPT_NAME="${PROGRAM_NAME}.sh"
SCRIPT_URL="${KEITARO_URL}/${PROGRAM_NAME}.sh"
SCRIPT_LOG="${PROGRAM_NAME}.log"

CURRENT_COMMAND_OUTPUT_LOG="current_command.output.log"
CURRENT_COMMAND_ERROR_LOG="current_command.error.log"
CURRENT_COMMAND_SCRIPT_NAME="current_command.sh"

INDENTATION_LENGTH=2
INDENTATION_SPACES=$(printf "%${INDENTATION_LENGTH}s")

if [[ "${SHELL_NAME}" == 'bash' ]]; then
  if ! empty ${@}; then
    SCRIPT_COMMAND="curl -sSL "$SCRIPT_URL" | bash -s -- ${@}"
  else
    SCRIPT_COMMAND="curl -sSL "$SCRIPT_URL" | bash"
  fi
else
  if ! empty ${@}; then
    SCRIPT_COMMAND="${SHELL_NAME} ${@}"
  else
    SCRIPT_COMMAND="${SHELL_NAME}"
  fi
fi

declare -A VARS

RECONFIGURE_KEITARO_COMMAND_EN="curl -sSL ${KEITARO_URL}/install.sh | bash"

RECONFIGURE_KEITARO_COMMAND_RU="curl -sSL ${KEITARO_URL}/install.sh | bash -s -- -l ru"


declare -A DICT

DICT['en.errors.program_failed']='PROGRAM FAILED'
DICT['en.errors.must_be_root']='You must run this program as root.'
DICT['en.errors.run_command.fail']='There was an error evaluating current command'
DICT['en.errors.run_command.fail_extra']=''
DICT['en.errors.terminated']='Terminated by user'
DICT['en.messages.reload_nginx']="Reloading nginx"
DICT['en.messages.run_command']='Evaluating command'
DICT['en.messages.successful']='Everything is done!'
DICT['en.no']='no'
DICT['en.prompt_errors.validate_domains_list']='Please enter domains list, separated by comma without spaces (i.e. domain1.tld,www.domain1.tld). Each domain name must consist of only letters, numbers and hyphens and contain at least one dot.'
DICT['en.prompt_errors.validate_presence']='Please enter value'
DICT['en.prompt_errors.validate_yes_no']='Please answer "yes" or "no"'

DICT['ru.errors.program_failed']='ОШИБКА ВЫПОЛНЕНИЯ ПРОГРАММЫ'
DICT['ru.errors.must_be_root']='Эту программу может запускать только root.'
DICT['ru.errors.run_command.fail']='Ошибка выполнения текущей команды'
DICT['ru.errors.run_command.fail_extra']=''
DICT['ru.errors.terminated']='Выполнение прервано'
DICT['ru.messages.reload_nginx']="Перезагружается nginx"
DICT['ru.messages.run_command']='Выполняется команда'
DICT['ru.messages.successful']='Готово!'
DICT['ru.no']='нет'
DICT['ru.prompt_errors.validate_domains_list']='Укажите список доменных имён через запятую без пробелов (например domain1.tld,www.domain1.tld). Каждое доменное имя должно состоять только из букв, цифр и тире и содержать хотябы одну точку.'
DICT['ru.prompt_errors.validate_presence']='Введите значение'
DICT['ru.prompt_errors.validate_yes_no']='Ответьте "да" или "нет" (можно также ответить "yes" или "no")'




DICT['en.errors.see_logs']="Evaluating log saved to ${SCRIPT_LOG}. Please rerun \`${SCRIPT_COMMAND}\` after resolving problems."
DICT['en.errors.reinstall_keitaro']="Your Keitaro installation does not properly configured. Please reconfigure Keitaro by evaluating command \`${RECONFIGURE_KEITARO_COMMAND_EN}\`"
DICT['en.errors.vhost_already_exists']="Can not save site configuration - :vhost_filepath: already exists"
DICT['en.errors.site_root_not_exists']="Can not save site configuration - :site_root: directory does not exist"
DICT['en.messages.add_vhost']="Creating site config"
DICT['en.prompts.site_domains']='Please enter domain name with aliases, separated by comma without spaces (i.e. domain1.tld,www.domain1.tld)'
DICT['en.prompts.site_root']='Please enter site root directory'

DICT['ru.errors.reinstall_keitaro']="Keitaro отконфигурирована неправильно. Пожалуйста выполните перенастройку Keitaro выполнив команду \`${RECONFIGURE_KEITARO_COMMAND_RU}\`"
DICT['ru.errors.see_logs']="Журнал выполнения сохранён в ${SCRIPT_LOG}. Пожалуйста запустите \`${SCRIPT_COMMAND}\` после устранения возникших проблем."
DICT['ru.errors.vhost_already_exists']="Невозможно сохранить конфигурацию сайта - :vhost_filepath: уже существует"
DICT['ru.errors.site_root_not_exists']="Невозможно сохранить конфигурацию сайта - нет директории :site_root:"
DICT['ru.messages.add_vhost']="Создаётся конфигурация для сайта"
DICT['ru.prompts.site_domains']='Укажите доменное имя и список альясов через запятую без пробелов (например domain1.tld,www.domain1.tld)'
DICT['ru.prompts.site_root']='Укажите корневую директорию сайта'




assert_caller_root(){
  debug 'Ensure script has been running by root'
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: actual checking of current user"
  else
    if [[ "$EUID" == "$ROOT_UID" ]]; then
      debug 'OK: current user is root'
    else
      debug 'NOK: current user is not root'
      fail "$(translate errors.must_be_root)"
    fi
  fi
}



assert_installed(){
  local program="${1}"
  local error="${2}"
  if ! is_installed "$program"; then
    fail "$(translate ${error})" "see_logs"
  fi
}





is_exists_directory(){
  local directory="${1}"
  local result_on_skip="${2}"
  debug "Checking ${directory} directory existence"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of ${directory} directory existence disabled"
    if [[ "$result_on_skip" == "no" ]]; then
      debug "NO: simulate ${directory} directory does not exist"
      return ${FAILURE_RESULT}
    fi
    debug "YES: simulate ${directory} directory exists"
    return ${SUCCESS_RESULT}
  fi
  if [ -d "${directory}" ]; then
    debug "YES: ${directory} directory exists"
    return ${SUCCESS_RESULT}
  else
    debug "NO: ${directory} directory does not exist"
    return ${FAILURE_RESULT}
  fi
}



is_exists_path(){
  local path="${1}"
  local result_on_skip="${2}"
  debug "Checking ${path} path existence"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of ${path} path existence disabled"
    if [[ "$result_on_skip" == "no" ]]; then
      debug "NO: simulate ${path} path does not exist"
      return ${FAILURE_RESULT}
    fi
    debug "YES: simulate ${path} path exists"
    return ${SUCCESS_RESULT}
  fi
  if [ -e "${path}" ]; then
    debug "YES: ${path} path exists"
    return ${SUCCESS_RESULT}
  else
    debug "NO: ${path} path does not exist"
    return ${FAILURE_RESULT}
  fi
}



is_exists_file(){
  local file="${1}"
  local result_on_skip="${2}"
  debug "Checking ${file} file existence"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of ${file} file existence disabled"
    if [[ "$result_on_skip" == "no" ]]; then
      debug "NO: simulate ${file} file does not exist"
      return ${FAILURE_RESULT}
    fi
    debug "YES: simulate ${file} file exists"
    return ${SUCCESS_RESULT}
  fi
  if [ -f "${file}" ]; then
    debug "YES: ${file} file exists"
    return ${SUCCESS_RESULT}
  else
    debug "NO: ${file} file does not exist"
    return ${FAILURE_RESULT}
  fi
}



set_ui_lang(){
  if empty "$UI_LANG"; then
    UI_LANG=$(detect_language)
  fi
  debug "Language: ${UI_LANG}"
}


detect_language(){
  if ! empty "$LC_ALL"; then
    detect_language_from_var "$LC_ALL"
  else
    if ! empty "$LC_MESSAGES"; then
      detect_language_from_var "$LC_MESSAGES"
    else
      detect_language_from_var "$LANG"
    fi
  fi
}


detect_language_from_var(){
  local lang_value="${1}"
  if [[ "$lang_value" =~ ^ru_[[:alpha:]]+\.UTF-8$ ]]; then
    echo ru
  else
    echo en
  fi
}



translate(){
  local key="${1}"
  local i18n_key=$UI_LANG.$key
  if isset ${DICT[$i18n_key]}; then
    echo "${DICT[$i18n_key]}"
  fi
}



is_installed(){
  local command="${1}"
  debug "Try to found "$command""
  if isset "$SKIP_CHECKS"; then
    debug "SKIPPED: actual checking of '$command' presence skipped"
  else
    if [[ $(sh -c "command -v "$command" -gt /dev/null") ]]; then
      debug "FOUND: "$command" found"
    else
      debug "NOT FOUND: "$command" not found"
      return ${FAILURE_RESULT}
    fi
  fi
}



add_indentation(){
  sed -r "s/^/$INDENTATION_SPACES/g"
}



get_user_var(){
  local var_name="${1}"
  local validation_methods="${2}"
  print_prompt_help "$var_name"
  while true; do
    print_prompt "$var_name"
    value="$(read_stdin)"
    debug "$var_name: got value '${value}'"
    if ! empty "$value"; then
      VARS[$var_name]="${value}"
    fi
    error=$(get_error "${var_name}" "$validation_methods")
    if isset "$error"; then
      debug "$var_name: validation error - '${error}'"
      print_prompt_error "$error"
      VARS[$var_name]=''
    else
      debug "  ${var_name}=${value}" 'light.blue'
      break
    fi
  done
}


hack_stdin_if_pipe_mode(){
  if is_pipe_mode; then
    debug 'Detected pipe bash mode. Stdin hack enabled'
    hack_stdin
  else
    debug "Can't detect pipe bash mode. Stdin hack disabled"
  fi
}


hack_stdin(){
  exec 3<&1
}




is_pipe_mode(){
  [ "${SHELL_NAME}" == 'bash' ]
}



print_prompt(){
  local var_name="${1}"
  prompt=$(translate "prompts.$var_name")
  prompt="$(print_with_color "$prompt" 'bold')"
  if ! empty ${VARS[$var_name]}; then
    prompt="$prompt [${VARS[$var_name]}]"
  fi
  echo -en "$prompt > "
}


print_prompt_error(){
  local error_key="${1}"
  error=$(translate "prompt_errors.$error_key")
  print_with_color "*** ${error}" 'red'
}





print_prompt_help(){
  local var_name="${1}"
  print_translated "prompts.$var_name.help"
}



read_stdin(){
  if is_pipe_mode; then
    read -r -u 3 variable
  else
    read -r variable
  fi
  echo "$variable" | sed 's/[^a-zA-Z[:digit:][:punct:]]//g'
}




clean_up(){
  debug 'called clean_up()'
}



debug(){
  local message="${1}"
  local color="${2}"
  if empty "$color"; then
    color='light.green'
  fi
  print_with_color "$message" "$color" >> "$SCRIPT_LOG"
}



fail(){
  local message="${1}"
  local see_logs="${2}"
  log_and_print_err "*** $(translate errors.program_failed) ***"
  log_and_print_err "$message"
  if isset "$see_logs"; then
    log_and_print_err "$(translate errors.see_logs)"
  fi
  print_err
  clean_up
  exit ${FAILURE_RESULT}
}



init(){
  init_log
  debug "Starting init stage: log basic info"
  debug "Command: ${SCRIPT_COMMAND}"
  debug "User ID: "$EUID""
  debug "Current date time: $(date +'%Y-%m-%d %H:%M:%S %:z')"
  trap on_exit SIGHUP SIGINT SIGTERM
}



init_log(){
  if [ -f ${SCRIPT_LOG} ]; then
    name_for_old_log=$(get_name_for_old_log ${SCRIPT_LOG})
    mv "$SCRIPT_LOG" "$name_for_old_log"
    debug "Old log ${SCRIPT_LOG} moved to "$name_for_old_log""
  else
    debug "${SCRIPT_LOG} created"
  fi
}

get_name_for_old_log(){
  local basename="${1}"
  old_suffix=0
  if [ -f ${basename}.1 ]; then
    old_suffix=$(ls ${basename}.* | grep -oP '\d+$' | sort | tail -1)
  fi
  current_suffix=$(expr "$old_suffix" + 1)
  echo "$basename".$current_suffix
}



log_and_print_err(){
  local message="${1}"
  print_err "$message" 'red'
  debug "$message" 'red'
}



on_exit(){
  debug "Terminated by user"
  echo
  clean_up
  fail "$(translate 'errors.terminated')"
}



print_content_of(){
  local filepath="${1}"
  if [ -f "$filepath" ]; then
    if [ -s "$filepath" ]; then
      echo "Content of '${filepath}':\n$(cat "$filepath" | add_indentation)"
    else
      echo "File '${filepath}' is empty"
    fi
  else
    echo "Can't show '${filepath}' content - file does not exist"
  fi
}



print_err(){
  local message="${1}"
  local color="${2}"
  print_with_color "$message" "$color" >&2
}



print_translated(){
  local key="${1}"
  message=$(translate "${key}")
  if ! empty "$message"; then
    echo "$message"
  fi
}



declare -A COLOR_CODE

COLOR_CODE['bold']=1

COLOR_CODE['default']=39
COLOR_CODE['red']=31
COLOR_CODE['green']=32
COLOR_CODE['yellow']=33
COLOR_CODE['blue']=34
COLOR_CODE['magenta']=35
COLOR_CODE['cyan']=36
COLOR_CODE['grey']=90
COLOR_CODE['light.red']=91
COLOR_CODE['light.green']=92
COLOR_CODE['light.yellow']=99
COLOR_CODE['light.blue']=94
COLOR_CODE['light.magenta']=95
COLOR_CODE['light.cyan']=96
COLOR_CODE['light.grey']=37

RESET_FORMATTING='\e[0m'


print_with_color(){
  local message="${1}"
  local color="${2}"
  if ! empty "$color"; then
    escape_sequence="\e[${COLOR_CODE[$color]}m"
    echo -e "${escape_sequence}${message}${RESET_FORMATTING}"
  else
    echo "$message"
  fi
}




reload_nginx(){
  debug "Reload nginx"
  run_command "nginx -s reload" "$(translate 'messages.reload_nginx')" 'hide_output'
}



run_command(){
  local command="${1}"
  local message="${2}"
  local hide_output="${3}"
  local allow_errors="${4}"
  local run_as="${5}"
  local print_fail_message_method="${6}"
  debug "Evaluating command: ${command}"
  if empty "$message"; then
    run_command_message=$(print_with_color "$(translate 'messages.run_command')" 'blue')
    message="$run_command_message \`$command\`"
  else
    message=$(print_with_color "${message}" 'blue')
  fi
  if isset "$hide_output"; then
    echo -en "${message} . "
  else
    echo -e "${message}"
  fi
  if isset "$PRESERVE_RUNNING"; then
    print_command_status "$command" 'SKIPPED' 'yellow' "$hide_output"
    debug "Actual running disabled"
  else
    really_run_command "${command}" "${hide_output}" "${allow_errors}" "${run_as}" "${print_fail_message_method}"
  fi
}


print_command_status(){
  local command="${1}"
  local status="${2}"
  local color="${3}"
  local hide_output="${4}"
  debug "Command result: ${status}"
  if isset "$hide_output"; then
    print_with_color "$status" "$color"
  fi
}


really_run_command(){
  local command="${1}"
  local hide_output="${2}"
  local allow_errors="${3}"
  local run_as="${4}"
  local print_fail_message_method="${5}"
  local current_command_script=$(save_command_script "${command}" "${run_as}")
  local evaluated_command=$(command_run_as "${current_command_script}" "${run_as}")
  evaluated_command=$(unbuffer_streams "${evaluated_command}")
  evaluated_command=$(save_command_logs "${evaluated_command}")
  evaluated_command=$(hide_command_output "${evaluated_command}" "${hide_output}")
  debug "Real command: ${evaluated_command}"
  if ! eval "${evaluated_command}"; then
    print_command_status "${command}" 'NOK' 'red' "${hide_output}"
    if isset "$allow_errors"; then
      remove_current_command "$current_command_script"
      return ${FAILURE_RESULT}
    else
      fail_message=$(print_current_command_fail_message "$print_fail_message_method" "$current_command_script")
      remove_current_command "$current_command_script"
      fail "${fail_message}" "see_logs"
    fi
  else
    print_command_status "$command" 'OK' 'green' "$hide_output"
    remove_current_command "$current_command_script"
  fi
}


command_run_as(){
  local command="${1}"
  local run_as="${2}"
  if isset "$run_as"; then
    echo "sudo -u '${run_as}' bash '${command}'"
  else
    echo "bash ${command}"
  fi
}


unbuffer_streams(){
  local command="${1}"
  echo "stdbuf -i0 -o0 -e0 ${command}"
}


save_command_logs(){
  local evaluated_command="${1}"
  local output_log="${2}"
  local error_log="${3}"
  save_output_log="tee -i ${CURRENT_COMMAND_OUTPUT_LOG} | tee -ia ${SCRIPT_LOG}"
  save_error_log="tee -i ${CURRENT_COMMAND_ERROR_LOG} | tee -ia ${SCRIPT_LOG}"
  echo "((${evaluated_command}) 2> >(${save_error_log}) > >(${save_output_log}))"
}


remove_colors_from_file(){
  local file="${1}"
  debug "Removing colors from file ${file}"
  sed -r -e 's/\x1b\[([0-9]{1,3}(;[0-9]{1,3}){,2})?[mGK]//g' -i "$file"
}


hide_command_output(){
  local command="${1}"
  local hide_output="${2}"
  if isset "$hide_output"; then
    echo "${command} > /dev/null"
  else
    echo "${command}"
  fi
}


save_command_script(){
  local command="${1}"
  local run_as="${2}"
  local current_command_dir=$(mktemp -d)
  if isset "$run_as"; then
    chown "$run_as" "$current_command_dir"
  fi
  local current_command_script="${current_command_dir}/${CURRENT_COMMAND_SCRIPT_NAME}"
  echo '#!/usr/bin/env bash' > "${current_command_script}"
  echo 'set -o pipefail' >> "${current_command_script}"
  echo -e "${command}" >> "${current_command_script}"
  debug "$(print_content_of ${current_command_script})"
  echo "${current_command_script}"
}


print_current_command_fail_message(){
  local print_fail_message_method="${1}"
  local current_command_script="${2}"
  remove_colors_from_file "${CURRENT_COMMAND_OUTPUT_LOG}"
  remove_colors_from_file "${CURRENT_COMMAND_ERROR_LOG}"
  if empty "$print_fail_message_method"; then
    print_fail_message_method="print_common_fail_message"
  fi
  local fail_message_header=$(translate 'errors.run_command.fail')
  local fail_message=$(eval "$print_fail_message_method" "$current_command_script")
  echo -e "${fail_message_header}\n${fail_message}"
}


print_common_fail_message(){
  local current_command_script="${1}"
  print_content_of ${current_command_script}
  print_tail_content_of "${CURRENT_COMMAND_OUTPUT_LOG}"
  print_tail_content_of "${CURRENT_COMMAND_ERROR_LOG}"
}


print_tail_content_of(){
  local file="${1}"
  MAX_LINES_COUNT=20
  print_content_of "${file}" |  tail -n "$MAX_LINES_COUNT"
}


remove_current_command(){
  local current_command_script="${1}"
  debug "Removing current command script and logs"
  rm -f "$CURRENT_COMMAND_OUTPUT_LOG" "$CURRENT_COMMAND_ERROR_LOG" "$current_command_script"
  rmdir $(dirname "$current_command_script")
}



get_error(){
  local var_name="${1}"
  local validation_methods_string="${2}"
  local value="${VARS[$var_name]}"
  local error=""
  read -ra validation_methods <<< "$validation_methods_string"
  for validation_method in "${validation_methods[@]}"; do
    if ! eval "${validation_method} '${value}'"; then
      debug "${var_name}: '${value}' invalid for ${validation_method} validator"
      error="${validation_method}"
      break
    else
      debug "${var_name}: '${value}' valid for ${validation_method} validator"
    fi
  done
  echo "${error}"
}



validate_presence(){
  local value="${1}"
  isset "$value"
}


SUBDOMAIN_REGEXP="[[:alnum:]-]+"
DOMAIN_REGEXP="(${SUBDOMAIN_REGEXP}\.)+[[:alpha:]]${SUBDOMAIN_REGEXP}"
DOMAIN_LIST_REGEXP="${DOMAIN_REGEXP}(,${DOMAIN_REGEXP})*"

validate_domains_list(){
  local value="${1}"
  [[ "$value" =~ ^(${DOMAIN_LIST_REGEXP})$ ]]
}



is_no(){
  local answer="${1}"
  shopt -s nocasematch
  [[ "$answer" =~ ^(no|n|нет|н) ]]
}



is_yes(){
  local answer="${1}"
  shopt -s nocasematch
  [[ "$answer" =~ ^(yes|y|да|д) ]]
}


validate_yes_no(){
  local value="${1}"
  (is_yes "$value" || is_no "$value")
}



first_domain(){
  echo "${VARS['site_domains']%%,*}"
}



vhost_filepath(){
  echo "${NGINX_VHOSTS_DIR}/$(first_domain).conf"
}



stage1(){
  debug "Starting stage 1: initial script setup"
  parse_options "$@"
  set_ui_lang
}



parse_options(){
  while getopts ":hpsl:" opt; do
    case $opt in
      p)
        PRESERVE_RUNNING=true
        ;;
      s)
        SKIP_CHECKS=true
        ;;
      l)
        case $OPTARG in
          en)
            UI_LANG=en
            ;;
          ru)
            UI_LANG=ru
            ;;
          *)
            print_err "Specified language \"$OPTARG\" is not supported"
            exit ${FAILURE_RESULT}
            ;;
        esac
        ;;
      :)
        print_err "Option -$OPTARG requires an argument."
        exit ${FAILURE_RESULT}
        ;;
      h)
        usage
        exit ${SUCCESS_RESULT}
        ;;
      \?)
        usage
        exit ${FAILURE_RESULT}
        ;;
    esac
  done
}


usage(){
  set_ui_lang
  if [[ "$UI_LANG" == 'ru' ]]; then
    ru_usage
  else
    en_usage
  fi
}


ru_usage(){
  print_err "$SCRIPT_NAME позволяет запустить дополнительный сайт совместно с Keitaro"
  print_err
  print_err "Использование: "$SCRIPT_NAME" [-ps] [-l en|ru] "
  print_err
  print_err "  -p"
  print_err "    С опцией -p (preserve commands running) "$SCRIPT_NAME" не выполняет установочные команды. Вместо этого текст команд будет показан на экране."
  print_err
  print_err "  -s"
  print_err "    С опцией -s (skip checks) "$SCRIPT_NAME" не будет проверять присутствие нужных программ в системе, не будет проверять факт запуска из под root."
  print_err
  print_err "  -l <lang>"
  print_err "    "$SCRIPT_NAME" определяет язык через установленные переменные окружения LANG/LC_MESSAGES/LC_ALL, однако язык может быть явно задан помощи параметра -l."
  print_err "    На данный момент поддерживаются значения en и ru (для английского и русского языков)."
  print_err
}


en_usage(){
  print_err "$SCRIPT_NAME allows to run additional site together with Keitaro"
  print_err
  print_err "Usage: "$SCRIPT_NAME" [-ps] [-l en|ru] domain1.tld [domain2.tld] ..."
  print_err
  print_err "  -p"
  print_err "    The -p (preserve commands running) option causes "$SCRIPT_NAME" to preserve the invoking of installation commands. Installation commands will be printed to stdout instead."
  print_err
  print_err "  -s"
  print_err "    The -s (skip checks) option causes "$SCRIPT_NAME" to skip checks of required programs presence, skip check root running"
  print_err
  print_err "  -l <lang>"
  print_err "    By default "$SCRIPT_NAME" tries to detect language from LANG/LC_MESSAGES/LC_ALL environment variables, but language can be explicitly set  with -l option."
  print_err "    Only en and ru (for English and Russian) values are supported now."
  print_err
}



stage2(){
  debug "Starting stage 2: make some asserts"
  assert_caller_root
  assert_installed 'nginx' 'errors.reinstall_keitaro'
  assert_nginx_configured
}



assert_nginx_configured(){
  if ! is_nginx_properly_configured; then
    fail "$(translate 'errors.reinstall_keitaro')" "see_logs"
  fi
}


is_nginx_properly_configured(){
  if ! is_exists_file "${NGINX_KEITARO_CONF}"; then
    log_and_print_err "ERROR: File ${NGINX_KEITARO_CONF} doesn't exists"
    return ${FAILURE_RESULT}
  fi
  if ! is_exists_directory "${WEBROOT_PATH}"; then
    log_and_print_err "ERROR: Directory ${WEBROOT_PATH} doesn't exists"
    return ${FAILURE_RESULT}
  fi
  is_keitaro_configured
}


is_keitaro_configured(){
  debug "Checking keitaro params in ${NGINX_KEITARO_CONF}"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of keitaro params in ${NGINX_KEITARO_CONF} disabled"
    FASTCGI_PASS_LINE="fastcgi_pass unix:/var/run/php70-fpm.sock;"
    return ${SUCCESS_RESULT}
  fi
  if grep -q -e "root ${WEBROOT_PATH};" "${NGINX_KEITARO_CONF}"; then
    FASTCGI_PASS_LINE="$(cat "$NGINX_KEITARO_CONF" | grep fastcgi_pass | sed 's/^ +//')"
    if empty "${FASTCGI_PASS_LINE}"; then
      log_and_print_err "ERROR: ${NGINX_KEITARO_CONF} is not properly configured (can't find 'fastcgi_pass ...;' directive)"
      log_and_print_err "$(print_content_of ${NGINX_KEITARO_CONF})"
      return ${FAILURE_RESULT}
    else
      debug "OK: it seems like ${NGINX_KEITARO_CONF} is properly configured"
      return ${SUCCESS_RESULT}
    fi
  else
    log_and_print_err "ERROR: ${NGINX_KEITARO_CONF} is not properly configured (can't find 'root ${WEBROOT_PATH};' directive"
    log_and_print_err $(print_content_of ${NGINX_KEITARO_CONF})
    return ${FAILURE_RESULT}
  fi
}



stage3(){
  debug "Starting stage 3: get user vars"
  get_user_vars
}



get_user_vars(){
  debug 'Read vars from user input'
  hack_stdin_if_pipe_mode
  get_user_var 'site_domains' 'validate_presence validate_domains_list'
  VARS['site_root']="/var/www/$(first_domain)"
  get_user_var 'site_root' 'validate_presence'
}



stage4(){
  debug "Starting stage 4: add vhost"
  ensure_can_add_vhost
  add_vhost
  reload_nginx
  show_successful_message
}



add_vhost(){
  debug "Add vhost"
  run_command "echo '$(vhost_content)' > '$(vhost_filepath)'" "$(translate 'messages.add_vhost')" "hide_output"
  debug $(print_content_of "$(vhost_filepath)")
}

function vhost_content() {
	cat <<-END
      server {
        listen 80;
        server_name ${VARS['site_domains']};
        root ${VARS['site_root']};
        index index.php index.html;
        access_log /var/log/nginx/$(first_domain).access.log main;
        error_log /var/log/nginx/$(first_domain).error.log warn;
        location ~* \.(jpg|jpeg|gif|png|js|css|txt|zip|ico|gz|csv)\$ {
          expires 10d;
        }
        location ~* \.(htaccess|ini|dat)\$ {
          return 403;
        }
        location ~ \.php\$ {
          fastcgi_split_path_info ^(.+\.php)(/.+)\$;
          ${FASTCGI_PASS_LINE}
          fastcgi_index index.php;
          fastcgi_buffers 16 16k;
          fastcgi_buffer_size 32k;
          fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
          include fastcgi_params;
        }
        location / {
          try_files \$uri \$uri/ /index.php?\$args;
        }
      }
	END
}



ensure_can_add_vhost(){
  debug "Ensure can add vhost"
  if is_exists_path "$(vhost_filepath)" "no"; then
    local message="$(translate 'errors.vhost_already_exists')"
    fail "${message/:vhost_filepath:/$(vhost_filepath)}"
  fi
  if ! is_exists_directory "${VARS['site_root']}"; then
    local message="$(translate 'errors.site_root_not_exists')"
    fail "${message/:site_root:/${VARS['site_root']}}"
  fi
}




show_successful_message(){
  print_with_color "$(translate 'messages.successful')" 'green'
  print_translated 'messages.ssl_enabled_for_sites'
  for domain in "${DOMAINS[@]}"; do
    print_with_color "https://${domain}/admin" 'green'
  done
}








add_site(){
  init "$@"
  stage1 "$@"
  stage2
  stage3
  stage4
}


add_site "$@"

# wait for all async child processes (because "await ... then" is used in powscript)
[[ $ASYNC == 1 ]] && wait


exit 0

