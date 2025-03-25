#!/bin/bash

echo -e '\nInstalling personal repositories\n'

mkdir -p ~/git/personal
pushd ~/git/personal

git clone git@github.com:CodelyTV/aggregates-course.git codely-aggregates-course || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@github.com:CodelyTV/typescript-ddd-example.git codely-typescript-ddd-example || if [ ${?} -gt 0 ]; then exit 1; fi

git clone git@github.com:samuelcasanova/ddd-course-codelytv.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@github.com:samuelcasanova/elasticsearch-codelytv-course.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@github.com:samuelcasanova/samuelcasanova.github.io.git || if [ ${?} -gt 0 ]; then exit 1; fi

popd