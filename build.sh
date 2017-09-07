#!/bin/bash
set -e -x

rm -rf /opt/python/cp26*
rm -rf /opt/python/cp33*

# Binary wheels
for name in AccessControl Acquisition ExtensionClass Persistence \
            zope.container zope.i18nmessageid zope.proxy zope.security; do
    cd src/$name

    git describe

    for PYBIN in /opt/python/*/bin; do
        git clean -fd
        rm -rf build
        rm -rf dist
        "${PYBIN}/python" setup.py bdist_wheel
        cp dist/*.whl /io/wheelhouse
        rm -rf dist
    done

    cd ../..
done 

# Universal wheels
for name in zope.annotation zope.browser zope.browsermenu zope.browserpage \
            zope.browserresource zope.cachedescriptors zope.component \
            zope.componentvocabulary zope.configuration zope.contentprovider \
            zope.contenttype zope.datetime zope.deferredimport \
            zope.deprecation zope.dottedname zope.event zope.exceptions \
            zope.filerepresentation zope.formlib zope.globalrequest \
            zope.i18n zope.lifecycleevent zope.location zope.pagetemplate \
            zope.processlifetime zope.ptresource zope.publisher \
            zope.ramcache zope.schema zope.sendmail zope.sequencesort \
            zope.site zope.size zope.structuredtext zope.tal zope.tales \
            zope.testbrowser zope.testing zope.testrunner zope.traversing \
            zope.viewlet; do
    cd src/$name

    git describe

    git clean -fd
    rm -rf build
    rm -rf dist

    /opt/python/cp27-cp27mu/bin/python setup.py bdist_wheel --universal
    cp dist/*.whl /io/wheelhouse
    rm -rf dist

    cd ../..
done 


for whl in wheelhouse/*.whl; do
    if [[ $whl != *"none-any"* ]]; then
        auditwheel repair "$whl" -w /io/wheelhouse/ || echo 'skip'
    fi
done

# Remove linux wheels, replaced by manylinux
rm -f /io/wheelhouse/*-linux_*.whl
