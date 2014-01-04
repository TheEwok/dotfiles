fun! SetUp()
    " normalize g:phpcomplete_min_num_of_chars_for_namespace_completion option
    let g:phpcomplete_min_num_of_chars_for_namespace_completion = 2
    " disable built-in functions
    let g:php_builtin_classnames = {}
    " disable tags
    exe ':set tags='
endf

fun! TestCase_completes_builtin_classes()
    call SetUp()
    let g:php_builtin_classnames = {
                \ 'ArrayAccess': '',
                \ 'ArrayObject': '',
                \ }

    " returns every builtin class when nothing typed in
    let res = phpcomplete#CompleteUse('')
    call VUAssertEquals([
                \{'word': 'ArrayAccess', 'kind': 'c'},
                \{'word': 'ArrayObject', 'kind': 'c'}],
                \res)

    " returns every builtin class when only a \ typed in
    let res = phpcomplete#CompleteUse('\')
    call VUAssertEquals([
                \{'word': 'ArrayAccess', 'kind': 'c'},
                \{'word': 'ArrayObject', 'kind': 'c'}],
                \res)

    " filters to the typed in string
    let res = phpcomplete#CompleteUse('ArrayO')
    call VUAssertEquals([
                \{'word': 'ArrayObject', 'kind': 'c'}]
                \, res)

    " removes the leading \ when its in the base, php manual doesn't recommend
    " to type out those since imports are always absolute
    let res = phpcomplete#CompleteUse('\ArrayO')
    call VUAssertEquals([
                \{'word': 'ArrayObject', 'kind': 'c'}]
                \, res)
endf

fun! TestCase_completes_namespaces_from_tags()
    call SetUp()
    exe ':set tags='.expand('%:p:h').'/'.'fixtures/CompleteUse/tags'

    let res = phpcomplete#CompleteUse('Ass')
    call VUAssertEquals([
                \ {'word': 'Assetic', 'menu': 'fixtures/CompleteUse/foo.php', 'info': 'fixtures/CompleteUse/foo.php', 'kind': 'n'},
                \ {'word': 'Assetic\Asset', 'menu': 'fixtures/CompleteUse/foo.php', 'info': 'fixtures/CompleteUse/foo.php', 'kind': 'n'},
                \ {'word': 'Assetic\Asset\Iterator', 'menu': 'fixtures/CompleteUse/foo.oho', 'info': 'fixtures/CompleteUse/foo.oho', 'kind': 'n'},
                \ {'word': 'Assetic\Cache', 'menu': 'fixtures/CompleteUse/foo.php', 'info': 'fixtures/CompleteUse/foo.php', 'kind': 'n'}],
                \ res)

    " removes the leading \ when its in the base, php manual doesn't recommend
    " to type out those since imports are always absolute
    let res = phpcomplete#CompleteUse('\Ass')
    call VUAssertEquals([
                \ {'word': 'Assetic', 'menu': 'fixtures/CompleteUse/foo.php', 'info': 'fixtures/CompleteUse/foo.php', 'kind': 'n'},
                \ {'word': 'Assetic\Asset', 'menu': 'fixtures/CompleteUse/foo.php', 'info': 'fixtures/CompleteUse/foo.php', 'kind': 'n'},
                \ {'word': 'Assetic\Asset\Iterator', 'menu': 'fixtures/CompleteUse/foo.oho', 'info': 'fixtures/CompleteUse/foo.oho', 'kind': 'n'},
                \ {'word': 'Assetic\Cache', 'menu': 'fixtures/CompleteUse/foo.php', 'info': 'fixtures/CompleteUse/foo.php', 'kind': 'n'}],
                \ res)
endf

fun! TestCase_completes_namespaces_and_classes_from_tags_when_a_leading_namespace_is_already_typed_in()
    call SetUp()
    exe ':set tags='.expand('%:p:h').'/'.'fixtures/CompleteUse/tags'

    let res = phpcomplete#CompleteUse('Assetic\Asset\Ba')
    call VUAssertEquals([
                \ {'word': 'Assetic\Asset\BaseAsset', 'menu': 'fixtures/CompleteUse/foo.php', 'info': 'fixtures/CompleteUse/foo.php', 'kind': 'c'}],
                \ res)
endf

fun! TestCase_honors_the_min_num_of_chars_for_namespace_completion_setting_for_namespaces()
    call SetUp()
    exe ':set tags='.expand('%:p:h').'/'.'fixtures/CompleteUse/tags'
    let g:phpcomplete_min_num_of_chars_for_namespace_completion = 99

    let res = phpcomplete#CompleteUse('Assetic\')
    call VUAssertEquals([], res)
endf

fun! TestCase_honors_the_min_num_of_chars_for_namespace_completion_setting_for_classnames()
    call SetUp()
    exe ':set tags='.expand('%:p:h').'/'.'fixtures/CompleteUse/tags'
    let g:phpcomplete_min_num_of_chars_for_namespace_completion = 99

    let res = phpcomplete#CompleteUse('Assetic\Asset\Ba')
    call VUAssertEquals([], res)
endf
