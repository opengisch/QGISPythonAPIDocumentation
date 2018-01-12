#!/bin/bash

set -e

export PATH=$PATH:/usr/local/bin/:/Users/denis/opt/qgis/QGIS/build/output/bin
export PYTHONPATH=$PYTHONPATH:/Users/denis/opt/qgis/QGIS/build/output/python/

DIR=$(git rev-parse --show-toplevel)

./rst/make_api_rst.py --package core --class QgsCoordinate
make html -j4

exit

rm -rf ${DIR}/publish
mkdir ${DIR}/publish
pushd ${DIR}/publish

git clone git@github.com:opengisch/QGISPythonAPIDocumentation.git --depth 1 --branch gh-pages
cd QGISPythonAPIDocumentation
git rm . -r
cp -R ${DIR}/build/html/* .
touch .nojekyll
git add -A
git commit -m "Update docs"
git push

popd
