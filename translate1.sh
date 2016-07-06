#! /bin/sh

# 1) Run translate1.sh
# 2) Edit the .po files, translating strings
# 3) Run translate2.sh to compile the translations
# 4) Test

PROJECT=deform_pure
echo
# python2.7 ./setup.py extract_messages
# pybabel extract -k tr --omit-header --sort-by-file -F $PROJECT/locale/main_mapping.conf -o $PROJECT/locale/messages.pot $PROJECT
pot-create --package-name $PROJECT --copyright-holder "Nando Florestan" -o $PROJECT/locale/messages.pot $PROJECT && \
echo "" && \
./setup.py update_catalog
