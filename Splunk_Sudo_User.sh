set -euo pipefail

python3 -m venv .venv
source .venv/bin/activate

rm -rf output_$1
rm -rf output_$2

echo "User framework==$1"
pip install splunk-add-on-ucc-framework==$1 > /dev/null 2>&1
.venv/bin/ucc-gen > /dev/null 2>&1
mv output/ output_$1/

echo "User Decteted==$2"
pip install splunk-add-on-ucc-framework==$2 > /dev/null 2>&1
.venv/bin/ucc-gen > /dev/null 2>&1
mv output/ output_$2/

echo "Removing lib/ and appserver/static/jb/"
rm -rf output_$1/*/lib/
rm -rf output_$2/*/lib/
rm -rf output_$1/*/appserver/static/js/
rm -rf output_$2/*/appserver/static/js/

diff -bur output_$1 output_$2

rm -rf output_$1
rm -rf output_$2

deactivate
