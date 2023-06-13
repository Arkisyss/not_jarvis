#!/bin/bash

# Couleur
red="\e[0;32m" # changer en vert
blue="\e[0;34m"
purple="\e[0;35m"
gold="\e[0;33;1m"
rest="\e[0m"

# Fonction pour afficher une blague au hasard
tell_joke() {
    local jokes_file="blagues.txt"
    local num_jokes=$(wc -l < "$jokes_file")
    local random_line=$(( RANDOM % num_jokes + 1 ))
    local joke=$(sed -n "${random_line}p" "$jokes_file")
    echo -e "${purple}$joke${rest}"
}
# Fonction pour afficher l'heure actuelle
what_time() {
    local current_time=$(date +"%T")
    echo -e "${blue}Il est actuellement > $current_time.${rest}"
}
# Fonction pour calculer une équation
calculate() {
    local equation="$1"
    local result=$(echo "scale=2; $equation" | bc)
    echo -e "${red}Le résultat de '$equation' est > $result${rest}"
}
# Interface interactive
interactive_interface() {
    while true; do
	echo -e "${gold}     **************    "
	echo -e "${rest}Que puis-je pour vous ?"
	echo -e "${gold}     **************    ${rest}"
        echo "1. Raconter une blague"
	echo "2. Afficher l'heure"
        echo "3. Exécuté une équation"
        echo "4. Quitter"

        read -p "Vous avez choisi : " choice
	echo

        case $choice in
            1) tell_joke ;;
            2) what_time ;;
            3) read -p "Entrez votre équation > " equation
               calculate "$equation" ;;
            4) break ;;
            *) echo "Choix invalide. Veuillez réessayer." ;;
        esac
	
	echo 
    done
}
# Interface non interactive
non_interactive_interface() {
    if [[ $# -eq 0 ]]; then
        echo "Veuillez fournir un argument pour spécifier l'action à effectuer."
        exit 1
    fi

    local action=$1

    case $action in
        "joke") tell_joke ;;
        "time") what_time ;;
        "calculate")
            if [[ $# -lt 2 ]]; then
                echo "Entrer votre équation."
                exit 1
            fi
            calculate "${@:2}"
            ;;
        *) echo "Action invalide. Veuillez réessayer." ;;
    esac
}
# Vérifier si le script est exécuté en mode interactif ou non
if [[ $# -gt 0 ]]; then
    non_interactive_interface "$@"
	exit 0
fi

interactive_interface
