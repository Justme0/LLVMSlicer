echo -e "Line of Code of Headers (under dir. include/)"
find ./src -name "*.h" | xargs cat | wc -l

echo -e "Line of Code of Source (under dir. lib/)"
find ./src -name "*.cpp" | xargs cat | wc -l
