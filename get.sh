#!/bin/bash
set -e -x

cd src

for name in AccessControl Acquisition ExtensionClass Persistence; do
    if [ ! -d $name ]; then
        git clone https://github.com/zopefoundation/$name.git;
    fi
    cd $name
    git fetch
    git checkout `git tag -l '?.*' | tail -n 1`
    git reset --hard
    git clean -fd
    cd ..
done 

for name in zope.container zope.i18nmessageid zope.proxy zope.security \
            zope.annotation zope.browser zope.browsermenu zope.browserpage \
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

    if [ ! -d $name ]; then
        git clone https://github.com/zopefoundation/$name.git;
    fi
    cd $name
    git fetch
    git checkout `git tag -l '?.*' | grep -v a | grep -v b | tail -n 1`
    git reset --hard
    git clean -fd
    cd ..
done 

cd ..
